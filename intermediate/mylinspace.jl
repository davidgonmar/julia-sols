using Test


struct MyLinspace
	start::Float64
	stop::Float64
	N::Int
end

function mylinspace(start::Float64, stop::Float64; length::Int = 50)
	if length < 2
		throw(ArgumentError("length must be at least 2"))
	end
	MyLinspace(start, stop, length)
end


function _getval(r::MyLinspace, i::Int)
	(1 <= i <= r.N) || throw(BoundsError(r, i))
	r.start + (i - 1) / (r.N - 1) * (r.stop - r.start)
end

# INTERFACE IMPLEMENTATIONS

Base.IteratorSize(::Type{MyLinspace}) = Base.SizeUnknown()

Base.iterate(r::MyLinspace, state::Int = 1) = state > length(r) ? nothing : (_getval(r, state), state + 1)

Base.length(r::MyLinspace) = r.N

Base.getindex(r::MyLinspace, i::Int) = _getval(r, i)


macro test_mylinspace(start, stop, N, indices_to_try)
	return quote
		r = mylinspace($(esc(start)), $(esc(stop)), length = $(esc(N)))
		rr = range($(esc(start)), $(esc(stop)), length = $(esc(N)))
		@test length(r) == length(rr)
		@test collect(r) ≈ collect(rr)
		for i in $indices_to_try
			@test r[i] ≈ rr[i]
		end
	end
end

@testset "MyLinspace tests" begin
	@test_mylinspace 1.0 5.0 5 [1, 2, 3, 4, 5]
	@test_mylinspace 1.0 5.0 3 [1, 2, 3]
	@test_mylinspace 5.0 1.0 5 [1, 2, 3, 4, 5]
end

