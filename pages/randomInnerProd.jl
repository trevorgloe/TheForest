module randomInnerProd
using LinearAlgebra
using Random

function computeAvgInnerSqr(N::Int, M::Int, alpha::Real)
        # computes the average value of <u,v>^2 where u and v are random Gaussian vectors and the inner product is given by a weighted inner product with weights alpha^{-i}
        # u and v are N-dimensional vectors and the expectation is approximated by M samples
        # The inner product is normalized by the G-norm of the vectors
        g = alpha .^ (0:-1:-N+1)
        G = Diagonal(g)
        tot = 0
        for i in 1:M
                u = randn(N, 1)
                v = randn(N, 1)
                inner = u' * G * v
                unorm = u' * G * u
                vnorm = v' * G * v
                tot += inner[1]^2 / (unorm[1] * vnorm[1])
        end
        avg = tot / M
        return avg
end

function computeAvgOverAlpha(N::Int, M::Int, alphahi::Real=5, alphalow::Real=1, nalpha::Int=20)
        # computes all the average inner products with the weighted inner product with weights given by exponentially decreasing values by a factor of alpha, where alpha ranges from alphahi to alphalow
        all_avgs = zeros(1, nalpha)
        avec = LinRange(alphalow, alphahi, nalpha)
        for (i, a) in enumerate(avec)
                all_avgs[i] = computeAvgInnerSqr(N, M, a)
        end
        return all_avgs, avec
end

export computeAvgInnerSqr, computeAvgOverAlpha

end
