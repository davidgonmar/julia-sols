using Test
using BenchmarkTools

"""
	factorial_iter(n::Int, T::Type = Int)

Compute the factorial of `n` using an iterative algorithm.

# Arguments
- `n::Int`: Number to compute the factorial of.
- `T::Type = Int`: Type of the result.

# Returns
- `result::T`: Factorial of `n`.
"""
function factorial_iter(n::Int, T::Type = Int)
	result = T(1)
	for i ∈ 1:n
		result *= i
	end
	result
end

@testset "Factorial tests" begin
	@test factorial_iter(5) == 120
	@test factorial_iter(5, Int64) == 120
	@test factorial_iter(5, BigInt) == 120
	@test factorial_iter(5, Float64) == 120.0
	@test factorial_iter(5, BigFloat) == 120.0

	@test factorial_iter(10) == 3628800
	@test factorial_iter(10, Int64) == 3628800
	@test factorial_iter(10, BigInt) == 3628800
	@test factorial_iter(10, Float64) == 3628800.0
	@test factorial_iter(10, BigFloat) == 3628800.0
end

println("Benchmarking factorial_iter function:")
println("n = 20, default type:");
@btime factorial_iter(20);
println("n = 20, type = Int64:");
@btime factorial_iter(20, Int64);
println("n = 20, type = Float32:");
@btime factorial_iter(20, Float32);
println("n = 20, type = Float64:");
@btime factorial_iter(20, Float64);
println("n = 20, type = BigInt:");
@btime factorial_iter(20, BigInt);
println("n = 20, type = BigFloat:");
@btime factorial_iter(20, BigFloat);

println("n = 100, default type:");
@btime factorial_iter(100);
println("n = 100, type = Int64:");
@btime factorial_iter(100, Int64);
println("n = 100, type = Float32:");
@btime factorial_iter(100, Float32);
println("n = 100, type = Float64:");
@btime factorial_iter(100, Float64);
println("n = 100, type = BigInt:");
@btime factorial_iter(100, BigInt);
println("n = 100, type = BigFloat:");
@btime factorial_iter(100, BigFloat);
