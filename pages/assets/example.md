# This is markdown from a file in pages/assets/
Here we can put anything that you would like to put into markdown. Here is the Eckart-Young-Mirsky theorem. 
\[
\min_{B\in\mathbb{R}^{n\times n}, \text{rank}(B)\leq k} ||A - B|| = ||A - \sum_{i=1}^k \sigma_i u_i v_i^T ||
\]

And here is some syntax-highlighted code
```
#include<iostream>

int main() {
    std::cout << "Now we've written some C++ in our website!";
    print_msg("happy");
}

void print_msg(std::string adj) {
    std::cout << "I am very " << adj << "today";
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
