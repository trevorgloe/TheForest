module MarkdownPage
using GenieFramework
using Revise
include("partials/main_partials.jl")
include("layouts/main_layout.jl")

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
                                                h1("Displaying markdown on a page")
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/markdown", ui, layout = pageLayout("Markdown"))

end
