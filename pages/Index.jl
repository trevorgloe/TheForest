module Index
using GenieFramework
using Genie.Renderer.Html
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
                                                p("Hello! TheForest is configurable, multi-use website template using Stipple.jl and the GenieFramework. Directly below is a brief description of the layout of this project. Further down is information on how to edit the template to suit your needs can be found below. Navigating to the other pages via the navigation dropdown will showcase the other features included in this template.")
                                        ]
                                ),
                                Html.div(class="",
                                        [
                                                h2("Description of the project"),
                                                p("TheForest is a website template that runs in the <a href=https://learn.genieframework.com/>GenieFramework</a> using Stipple.jl and StippleUI for most of the functionality."),
                                                p("The file organization roughly follows that outlines in the Stipple.jl documentation for multipage apps. The page modules are contained in pages/ along with any markdown files that they render. Partials (in the form of imported functions which return html) are contained in partials/. For example, in each of the pages of the template, the function <code>topBar()</code> is called. This function references a partial contained in partials/main_partials.jl which creates the top bar on each page. This way, if there are changes to the top bar, it can be made in main_partials.jl and affect all the pages together. Layout files are contained in layouts/. The layout used for each page is given by the function <code>pageLayout(title)</code> defined in layouts/main_layout.jl. This is a function that takes in the title of the page and returns the html template (based on <code>DEFAULT_LAYOUT</code>) that Stipple.jl uses to render each page."),
                                                p("A few additional features have been added to the vanilla framework. These features were mainly selected as they served my own purposes for the website to display mathematics and computational science code, along with interactive julia apps."),
                                                ul([
                                                        li("LaTeX math rendering with MathJax. Although StippleLatex does support math rendering through LaTeX, I wanted the math written in markdown files to be rendered, which required some additional scripts. This is done via a script tag at the top of layouts/main_layout.jl"),
                                                        li("Code syntax highlighting with highlight.js. Stipple does have some support for code highlighting, but once again, it did not support code highlighting for code blocks in markdown. This was added by the inclusion of a script tag at the top of layouts/main_layout.jl, but also an additional script at the bottom of the html layout. Because of the way the DOM is handled by Stipple.jl, specifically the order in which things like codeblocks are rendered on the page, the highlight.js functions need to be called later in the rendering than they would otherwise be capable. To fix this, a mutation observer was added to the bottom of the main page layout which will re-run the highlighting functions from highlight.js whenever the code blocks are changed. This ends up looking fairly complicated but the end result is that all code blocks, whether inside a markdown block or otherwise, will receive syntax highlighting.")
                                                ])
                                       ]
                                )
                        ]
                        )
                ]
        )
end

@page("/", ui, layout = pageLayout("Home"))
end
