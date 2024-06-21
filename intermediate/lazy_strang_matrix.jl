using LinearAlgebra
using Test
using BenchmarkTools
include("../basic/strang-matrix.jl")

struct StrangMatrix{N, T} <: AbstractMatrix{T}
	N::Int
	eltype::Type{T}
end

StrangMatrix(N::Int, T::Type = Float64) = StrangMatrix{N, T}(N, T)
Base.size(m::StrangMatrix) = (m.N, m.N)
Base.getindex(m::StrangMatrix, i::Int, j::Int) = begin
	if !(1 <= i <= m.N && 1 <= j <= m.N)
		throw(BoundsError(m, (i, j)))
	end
	if i == j
		return m.eltype(-2)
	elseif i == j - 1 || i == j + 1
		return m.eltype(1)
	else
		return m.eltype(0)
	end
end

function _strang_matrix_matmul!(res::AbstractArray, m::StrangMatrix, v::AbstractArray)
	length(v) == m.N || throw(ArgumentError("size mismatch, got $(length(v)), expected $(m.N)"))
	length(res) == m.N || throw(ArgumentError("size mismatch, got $(length(res)), expected $(m.N)"))
	fill!(res, 0)
	# compute the result
	for i in 1:m.N
		res[i] = -2 * v[i]
		if i < m.N
			res[i] += v[i+1]
		end
		if i > 1
			res[i] += v[i-1]
		end
	end
end

(m::StrangMatrix)(v::AbstractArray) = begin
	res = zeros(eltype(v), m.N)
	_strang_matrix_matmul!(res, m, v)
	res
end

LinearAlgebra.mul!(res::AbstractArray, m::StrangMatrix, v::AbstractArray) = _strang_matrix_matmul!(res, m, v)

LinearAlgebra.adjoint(m::StrangMatrix) = m

@testset "Strang Matrix Tests" begin
	@testset "Size $N" for N in [10, 100, 1000]
		m = StrangMatrix(N, Float64)
		v = rand(N)
		res = m(v)
		dense = strang_matrix(N)
		res_dense = dense * v
		@test res ≈ res_dense atol = 1e-14
	end
end

@testset "Strang Matrix Solver Tests" begin
	@testset "Size $N" for N in [10, 100, 1000]
		A = StrangMatrix(N, Float64)
		A_dense = strang_matrix(N)
		b = rand(N)
		x = A \ b
		x_dense = A_dense \ b
		@test x ≈ x_dense atol = 1e-14
	end
end

println("Benchmarking StrangMatrix function:")
for N in [10, 100, 1000]
	println("N = $N:")
	print("With Lazy StrangMatrix: ")
	@btime StrangMatrix($N, Float64) * rand($N)
	print("With Dense Matrix: ")
	@btime strang_matrix($N) * rand($N)
end




