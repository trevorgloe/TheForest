module Plotting
using GenieFramework
using Revise
using PlotlyBase
include("readCOVIDData.jl")
using .readCData
include("randomInnerProd.jl")
using .randomInnerProd
include("../partials/main_partials.jl")
include("../layouts/main_layout.jl")

# get all the covid data for plotting
df = loadDeathData("pages/covid_data/covid_death_data.txt")
loadGDPDataIntoDataFrame(df) # now this data frame has all the covid data we want
trace1 = scatter(df, x=:GDP_2020, y=:death_per100k, text=:country, mode="markers")
@app begin
        @in N = 2020
        @out traces = [scatter(df, x=:GDP_2020, y=:death_per100k, text=:country, marker=attr(size=10), mode="markers")]
        @out layout = PlotlyBase.Layout(
                title="COVID19 Deaths Against GDP",
                xaxis=attr(
                        title="2020 GDP",
                        showgrid=true
                ),
                yaxis=attr(
                        title="COVID Deaths/100k Population",
                        showgrid=true,
                )
        )
        @onchange N begin
                colname = "GDP_" * string(N)
                xdata = df[!, colname]
                ydata = df[!, "death_per100k"]
                # display(xdata)
                traces = [scatter(x=xdata, y=ydata, text=:country, marker=attr(size=10), mode="markers")]
                layout = PlotlyBase.Layout(
                        title="COVID19 Deaths Against GDP",
                        xaxis=attr(
                                title="$N GDP",
                                showgrid=true
                        ),
                        yaxis=attr(
                                title="COVID Deaths/100k Population",
                                showgrid=true,
                        ),
                        autosize=true
                        # margin=attr(l=20, r=10, t=100, b=100, pad=4)
                )
        end
        @in vecN = "20"
        @out realN = 20
        @out vecTraces = []
        @out vecLayout = PlotlyBase.Layout()
        @onchange vecN begin
                try
                        println(vecN)
                        realN = parse(Int64, vecN)
                catch
                else
                        # this exception handler ensures that when the text is changing (and empty char arrays are sent to vecN, the code will not error because it doesn't know what to do with the new string
                        # this printing can be surpressed, it is not strictly necessary
                        println("Cannot convert text to a number")
                end
                ydata, xdata = computeAvgOverAlpha(realN, 200)
                vecTraces = [scatter(x=vec(xdata), y=vec(ydata), mode="lines")]
                vecLayout = PlotlyBase.Layout(
                        title="Expected Inner Product with Decaying Weights",
                        xaxis=attr(
                                title="Rate of exponential decay of weights",
                                showgrid=true
                        ),
                        yaxis=attr(
                                title="Average weighted inner product squared",
                                showgrid=true
                        )
                )
        end
end

function ui()
        StippleUI.layout(view="hHh Lpr lff",
                [
                        topBar(),
                        page_container(
                                [
                                h1("Plotting using Stipple.jl"),
                                Html.div(class="st-module",
                                        [
                                                p(class="st-module-title", "Data loaded on start"),
                                                p("Below is a nice interactive plot that you can make with PlotlyJS and julia. The data for this plot is loaded on the website starting up."),
                                                Html.div(class="col q-pa-lg",
                                                        [
                                                                plot(:traces, layout=:layout)
                                                        ]),
                                                slider(1974:1:2024, :N),
                                                h3("GDP in {{N}}"),
                                                p("Data for the plot above come from The Johns Hopkins University Coronavirus Resource Center Mortality Analysis and World Bank Group")
                                        ]
                                ),
                                Html.div(class="st-module",
                                        [
                                                p(class="st-module-title", "Data calculated dynamically"),
                                                Html.div(class="col-6", [
                                                        textfield(
                                                                "Dimension",
                                                                :vecN,
                                                                maxlength="6",
                                                        )]),
                                                Html.div(class="col-6", [
                                                        plot(:vecTraces, layout=:vecLayout)
                                                ]
                                                ),
                                                p("The plot above shows the average normalized inner product \\(\\langle u, v\\rangle\\) where \\(u\\) and \\(v\\) are random Gaussian vectors and the inner product is given by \\(\\sum_{i=0}^N u_i v_i \\alpha^{-i-1}\\). The different values of \\(\\alpha\\) are on the x-axis. The inner product is normalized by the norms of the vectors under the same inner product. There is a text input box to change the dimension \\(N \\)."),
                                                p("The data for this plot is generated upon changing the text input box above. So each time that number is changed, new data is created.")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/plotting", ui, layout = pageLayout("Plotting"))

end
