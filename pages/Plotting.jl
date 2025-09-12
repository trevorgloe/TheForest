module Plotting
using GenieFramework
using Revise
using PlotlyBase
include("readCOVIDData.jl")
using .readCData
include("../partials/main_partials.jl")
include("../layouts/main_layout.jl")

# get all the covid data for plotting
df = loadDeathData("pages/covid_data/covid_death_data.txt")
loadGDPDataIntoDataFrame(df) # now this data frame has all the covid data we want
trace1 = scatter(df, x=:GDP_2020, y=:death_per100k, text=:country, mode="markers")
@app begin
        @in N = 0
        @out m = 0.0
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
                ),
                width=1500,
                height=800
        )
end

function ui()
        StippleUI.layout(view="hHh Lpr lff",
                [
                        topBar(),
                        page_container(
                                [
                                Html.div(class="st-module",
                                        [
                                                h1("Plotting using Stipple.jl"),
                                                p("Below is a nice interactive plot that you can make with PlotlyJS and julia. The data for this plot is loaded on the website starting up."),
                                                plot(:traces, layout=:layout),
                                                p("Data for the plot above come from The Johns Hopkins University Coronavirus Resource Center Mortality Analysis and World Bank Group")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/plotting", ui, layout = pageLayout("Plotting"))

end
