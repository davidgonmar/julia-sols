using Test
using BenchmarkTools

"""
	strang_matrix(N::Int, T::Type = Float64)

Create a Strang matrix of size `N` with elements of type `T`.

# Arguments
- `N::Int`: Size of the matrix.
- `T::Type = Float64`: Type of the elements of the matrix.

# Returns
- `A::Matrix{T}`: Strang matrix of size `N` with elements of type `T`.
"""
function strang_matrix(N::Int, T::Type = Float64)
	A = zeros(T, N, N)
	for i ∈ 1:N
		A[i, i] = T(-2)
		if i < N
			A[i, i+1] = T(1)
			A[i+1, i] = T(1)
		end
	end
	A
end



if abspath(PROGRAM_FILE) == @__FILE__
	@testset "Strang matrix tests" begin
		@testset "Size 5, Int" begin
			A = strang_matrix(5, Int)
			@test A == [-2 1 0 0 0; 1 -2 1 0 0; 0 1 -2 1 0; 0 0 1 -2 1; 0 0 0 1 -2]
		end
		@testset "Size 3, Float64" begin
			A = strang_matrix(3, Float64)
			@test A == [-2.0 1.0 0.0; 1.0 -2.0 1.0; 0.0 1.0 -2.0]
		end
		@testset "Size 4, Int32" begin
			A = strang_matrix(4, Int32)
			@test A == Int32[-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -2]
		end
		@testset "Size 2, Float32" begin
			A = strang_matrix(2, Float32)
			@test A == Float32[-2.0 1.0; 1.0 -2.0]
		end
	end
	println("Benchmarking strang_matrix function:")
	println("N = 5, default type:")
	@btime strang_matrix(5)
	println("N = 5, type = Int32:")
	@btime strang_matrix(5, Int32)
	println("N = 5, type = Float32:")
	@btime strang_matrix(5, Float32)
	println("N = 100, default type:")
	@btime strang_matrix(100)
	println("N = 100, type = Int32:")
	@btime strang_matrix(100, Int32)
	println("N = 100, type = Float32:")
	@btime strang_matrix(100, Float32)
end
