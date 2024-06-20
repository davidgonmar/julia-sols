using Test


(r::StepRange)(i::T) where {T} = r.start + (i - one(T)) * r.step

@testset "StepRange tests" begin
	r = 1:1:10
	@test r(1.5) ≈ 1.5
	@test r(2) == 2
end
