module MarkdownPage
using GenieFramework
using StippleMarkdown
using Revise
include("../partials/main_partials.jl")
include("../layouts/main_layout.jl")

@app begin

end

# Helper function to read in markdown from a file
function readMD(filename::String)
        read(filename, String)
end

function ui()
        StippleUI.layout(view="hHh Lpr lff",
                [
                        topBar(),
                        page_container(
                                [
                                Html.div(class="",
                                        [
                                                h1("Displaying markdown on a page"),
                                                # Note that file name is relative to root directory, not this file
                                                markdowntext(readMD("pages/assets/example.md"))
                                        ]
                                )
                        ]
                        )
                ]
        )
end

@page("/markdown", ui, layout = pageLayout("Markdown"))

end
