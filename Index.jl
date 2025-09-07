module Index
using GenieFramework
using Revise
include("partials/main_partials.jl")
Revise.includet("partials/main_partials.jl")
include("layouts/main_layout.jl")

@app begin
        @in left_drawer_open = true
        @in ministate = true
        @in selected_component = "badge"
end

function ui()
        StippleUI.layout(view="hHh Lpr lff",
                [
                        topBar(),
                        page_container(
                                [
                                Html.div(class="",
                                        [
                                                h1("TheForest Website Template")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/", ui, layout = pageLayout("Home"))
end
