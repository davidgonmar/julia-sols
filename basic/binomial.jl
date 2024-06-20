using Test
using BenchmarkTools

"""
	binomial(n::Int, p::Float64, T::Type = Int)

Compute the binomial distribution with parameters `n` and `p`.

# Arguments
- `n::Int`: Number of trials.
- `p::Float64`: Probability of success.
- `T::Type = Int`: Type of the result.

# Returns
- `result::T`: Number of successes.
"""

function binomial(n::Int, p::Float64, T::Type = Int)
	result = T(0)
	for _ ∈ 1:n
		r = rand(Float64)
		if r < p
			result += T(1)
		end
	end
	result
end

@testset "Binomial tests" begin
	@test 0 <= binomial(10, 0.5) <= 10
	@test 0 <= binomial(10, 0.5, Int64) <= 10
	@test 0 <= binomial(10, 0.5, BigInt) <= 10
	@test 0 <= binomial(10, 0.5, Float64) <= 10
	@test 0 <= binomial(10, 0.5, BigFloat) <= 10

	@test 0 <= binomial(100, 0.5) <= 100
	@test 0 <= binomial(100, 0.5, Int64) <= 100
	@test 0 <= binomial(100, 0.5, BigInt) <= 100
	@test 0 <= binomial(100, 0.5, Float64) <= 100
	@test 0 <= binomial(100, 0.5, BigFloat) <= 100
end

println("Benchmarking binomial function:")
println("n = 10, p = 0.5, default type:")
@btime binomial(10, 0.5);
println("n = 10, p = 0.5, type = Int64:")
@btime binomial(10, 0.5, Int64);
println("n = 10, p = 0.5, type = Float32:")
@btime binomial(10, 0.5, Float32);
println("n = 10, p = 0.5, type = Float64:")
@btime binomial(10, 0.5, Float64);
println("n = 10, p = 0.5, type = BigInt:")
@btime binomial(10, 0.5, BigInt);
println("n = 10, p = 0.5, type = BigFloat:");
@btime binomial(10, 0.5, BigFloat);
