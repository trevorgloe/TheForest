# This is markdown from a file in pages/assets/
Here we can put anything that you would like to put into markdown. Here is the Eckart-Young-Mirsky theorem. 
\[
\min_{B\in\mathbb{R}^{n\times n}, \text{rank}(B)\leq k} ||A - B|| = ||A - \sum_{i=1}^k \sigma_i u_i v_i^T ||
\]

And here is some syntax-highlighted code
```cpp
#include&ltiostream&gt

int main() {
    std::cout << "Now we've written some C++ in our website!";
    print_msg("happy");
}

void print_msg(std::string adj) {
    std::cout << "I am very " << adj << " today";
}
```

And here is some more syntax highlighted code, this time in julia
```julia
using LinearAlgebra

A = randn(20, 20)
b = randn(20)

# lets see how long it takes to solve this linear system
@time x = A \ b
```

Additional languages for syntax highlighting can be added by editing the layout template function in `layouts/main_layout.jl`. Near the top of that function is the script tag 
```html
&ltscript src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/languages/julia.min.js"&gt&lt/script&gt
```
This script adds the julia language to the languages that highlight.js supports in syntax highlighting. Note that with any of the scripts that have `&lt`, or `&gt`, I am escaping the characters using &amplt or &ampgt so the html does not interpret the tag. More information on the highlighting can be found at [highlight.js](https://highlightjs.org/)

