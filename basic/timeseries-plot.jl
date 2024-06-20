using Plots

"""
	get_ar1_data(T, ε, α)

Generate an AR(1) time series of length `T` with parameters `α` and innovations `ε`.

# Arguments
- `T::Int`: Length of the time series.
- `α::Float64`: Autoregressive parameter.

# Returns
- `x::Vector`: The generated AR(1) time series.
"""
function get_ar1_data(T::Int, α::Float64)
	ε = randn(T)
	x = zeros(T)
	x[1] = ε[1]
	for t in 2:T
		x[t] = α * x[t-1] + ε[t]
	end
	return x
end


T = 100
α = 0.9

x = get_ar1_data(T, α)
plot(x, label = "AR1 time series", xlabel = "t", ylabel = "x", legend = :topleft, show = true)
