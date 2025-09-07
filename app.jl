module App
using GenieFramework
using Revise
# commands to make sure the autoreloader actually tracks changes to the dependent files
Revise.includet("Index.jl")
Revise.includet("MarkdownPage.jl")
Revise.includet("partials/main_partials.jl")
end
