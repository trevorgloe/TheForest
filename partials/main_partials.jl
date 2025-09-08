# Some partials to have on every page

using GenieFramework

@genietools

function topBar()
        # adds a top bar which stays put while scrolling with a navigation button
        quasar(:header, toolbar([
                navButton(["Home", "Markdown", "Plotting", "Reactive Apps"], ["", "markdown", "plotting", "reactive_apps"]),
                toolbartitle("TheForest Template - A Stipple.jl Website Template")
        ]))
end

function navButton(display::AbstractVector, adrss::AbstractVector)
        # creates a dropdown navigation bar from a vector of display names and vector of actual routes that those buttons will send the user to
        items = []
        for i in 1:length(display)
                append!(items, item(clickable="", tag="a", href="/" * adrss[i], itemsection(display[i])))
        end
        return btndropdown(class="nav-dropdown", label="Navigation", list(bordered=true, separator=true,
                items))
end
