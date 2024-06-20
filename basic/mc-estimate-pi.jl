using BenchmarkTools
using Test

"""
	mt_estimate_pi(n::Int)

Estimate the value of π using a Monte Carlo method.

# Arguments
- `n::Int`: Number of random points to generate.

# Returns
- `π::Float64`: Estimated value of π.
"""
function mt_estimate_pi(n::Int)
	inside = 0
	for _ in 1:n
		x, y = rand(), rand()
		if x^2 + y^2 < 1
			inside += 1
		end
	end
	return 4 * inside / n
end

@testset "Monte Carlo π estimation" begin
	@test 3.0 < mt_estimate_pi(10000) < 4.0
	@test 3.0 < mt_estimate_pi(100000) < 4.0
	@test 3.0 < mt_estimate_pi(1000000) < 4.0
end

println("Benchmarking mt_estimate_pi function:")
println("n = 100:")
@btime mt_estimate_pi(100);
println("n = 1000:")
@btime mt_estimate_pi(1000);
println("n = 10000:")
@btime mt_estimate_pi(10000);
println("n = 100000:")
@btime mt_estimate_pi(100000);
println("n = 1000000:")
@btime mt_estimate_pi(1000000);


res = mt_estimate_pi(10000000)
println("Estimated value of π: $res with n = 10000000")

res = mt_estimate_pi(100000000)
println("Estimated value of π: $res with n = 100000000")
