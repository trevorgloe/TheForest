module Plotting
using GenieFramework
using Revise
include("../partials/main_partials.jl")
include("../layouts/main_layout.jl")

@app begin

end

function ui()
        StippleUI.layout(view="hHh Lpr lff",
                [
                        topBar(),
                        page_container(
                                [
                                Html.div(class="",
                                        [
                                                h1("Plotting using Stipple.jl")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/plotting", ui, layout = pageLayout("Plotting"))

end
