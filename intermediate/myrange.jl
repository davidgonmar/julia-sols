using Test


struct MyRange
	start::Int
	stop::Int
	step::Int
end

function myrange(start::Int, stop::Int; step::Int = 1)
	if step == 0
		throw(ArgumentError("step cannot be zero"))
	end
	MyRange(start, stop, step)
end

function _getval(r::MyRange, i::Int)
	r.start + (i - 1) * r.step
end

# INTERFACE IMPLEMENTATIONS

Base.IteratorSize(::Type{MyRange}) = Base.SizeUnknown()

Base.iterate(r::MyRange, state::Int = 1) = state > length(r) ? nothing : (_getval(r, state), state + 1)

Base.length(r::MyRange) = max(0, div(r.stop - r.start, r.step) + 1)

Base.getindex(r::MyRange, I::Vararg{Int, N}) where {N} = _getval(r, I...)


macro test_myrange(start, stop, step, indices_to_try)
	return quote
		r = myrange($(esc(start)), $(esc(stop)), step = $(esc(step)))
		rr = range($(esc(start)), $(esc(stop)), step = $(esc(step)))
		@test length(r) == length(rr)
		@test collect(r) == collect(rr)
		for i in $indices_to_try
			@test r[i] == rr[i]
		end
	end
end

@testset "MyRange tests" begin
	@test_myrange 1 5 1 [1, 2, 3, 4, 5]
	@test_myrange 1 5 2 [1, 2, 3]
	@test_myrange 5 1 -1 [1, 2, 3, 4, 5]
end

