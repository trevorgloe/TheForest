module App
using GenieFramework
using Revise
# commands to make sure the autoreloader actually tracks changes to the dependent files
# Pages:
Revise.includet("pages/Index.jl")
Revise.includet("pages/MarkdownPage.jl")
Revise.includet("pages/Plotting.jl")
Revise.includet("pages/ReactivePage.jl")

# Other dependences we'd like Revise to track:
Revise.includet("partials/main_partials.jl")
end
