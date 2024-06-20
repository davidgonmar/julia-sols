using Plots

"""
	logistic_map(r, b0, n)

Compute the logistic map with parameters `r` and `b`.

# Arguments
- `r::Float64`: Parameter `r`.
- `b0::Float64`: Initial value.
- `warmup_iters::Int`: Number of iterations to stabilize the logistic map.
- `iters::Int`: Number of iterations to run the logistic map after stabilization.
"""
function logistic_map(r::Float64, b0::Float64, warmup_iters::Int, iters::Int)
	total_iters = warmup_iters + iters
	b = zeros(total_iters)
	b[1] = b0
	for i in 2:total_iters
		b[i] = r * b[i-1] * (1 - b[i-1])
	end
	return b[warmup_iters+1:end]
end

"""
	plot_bifurcation_diag(rmin, rmax, n, m)

Plot the bifurcation diagram of the logistic map.

# Arguments
- `rmin::Float64`: Minimum value of `r`.
- `rmax::Float64`: Maximum value of `r`.
- `r_length::Int`: Number of points in the `r` axis.
- `warmup_iters::Int`: Number of iterations to stabilize the logistic map.
- `iters::Int`: Number of iterations to run the logistic map after stabilization.
- `b0::Float64`: Initial value.

# Returns
- `p::Plots.Plot`: Plot object.
"""
function plot_bifurcation_diag(rmin::Float64, rmax::Float64, r_length::Int, warmup_iters::Int, iters::Int, b0::Float64)

	rs = range(rmin, rmax, length = r_length)
	b = zeros(r_length, iters) # Each row corresponds to a different `r` value
	for (i, r) in enumerate(rs)
		b[i, :] = logistic_map(r, b0, warmup_iters, iters)
	end
	p = plot(xlabel = "r", ylabel = "b", title = "Bifurcation diagram of the logistic map")
	# For every point in the `b` axis, plot the corresponding `r` values
	for i in 1:iters
		plot!(p, rs, b[:, i], seriestype = :scatter, color = :black, legend = false, markersize = 0.1)
	end
	return p
end

p = plot_bifurcation_diag(2.9, 4.0, 1000, 1000, 150, 0.25)

display(p)
