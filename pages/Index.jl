module Index
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
                                                h1("TheForest Website Template"),
                                                p("Hello! TheForest is configurable, multi-use website template using Stipple.jl and the GenieFramework.Directly below is a brief description of the layout of this project. Further down is information on how to edit the template to suit your needs can be found below. Navigating to the other pages via the navigation dropdown will showcase the other features included in this template.")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/", ui, layout = pageLayout("Home"))
end
