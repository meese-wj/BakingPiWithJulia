### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ cdf2d5ca-4c26-11ee-2a6d-c1c5d956051a
using Pkg

# ╔═╡ 6d270528-2c3f-4f0a-a114-8a3cb57f97ca
Pkg.activate(@__DIR__)

# ╔═╡ 97c36208-d842-40ec-9418-abe3bd761476
using PlutoUI

# ╔═╡ 93cbd4a6-36d7-42ed-b5b2-1a7414b27768
using LaTeXStrings

# ╔═╡ 63e5c816-31c2-4c74-a2b4-a25d843defb5
using Plots

# ╔═╡ 425783bc-6e18-4374-9b7e-f6db5b73aa3a
using Random

# ╔═╡ 62da9665-2b2a-4cdc-a114-4043a15d0853
TableOfContents()

# ╔═╡ 61c95dc0-7edd-4b0b-96ae-e86193844a7c
md"""
# Baking ``\pi`` with Julia
"""

# ╔═╡ cf83bcf2-a9a1-4af8-b939-9b4dee20614a
md"""
## Plant our _random_ seed

Since we're scientists (allegedly), we want reproducibility!
"""

# ╔═╡ f12c93f7-7eb4-4eef-82dc-c34912574c1f
Random.seed!(42)

# ╔═╡ df026034-7f7b-45c7-abe1-cede1b2bb217
md"""
## Example Plot

Everything but the kitchen `sinc`.
"""

# ╔═╡ 59258075-c630-466c-859c-cde7ae664f25
let
	x = -π:0.001:π
	plot(x, sinc.(x); xlabel = L"$x$", ylabel = L"$f(x)$", label = false)
end

# ╔═╡ 193e05d5-9ae2-496a-8b23-fb790d33ae17
md"""
# Monte Carlo Stuff
"""

# ╔═╡ 8d1c38c8-dcd4-49bd-8b96-5ee1b4588f56
struct Point
	x::Float64
	y::Float64
end

# ╔═╡ 831bc646-2b58-4877-a287-8dcf35a40dbb
norm(p) = hypot(p.x, p.y)

# ╔═╡ 504b5fa6-7ad6-4d1f-ba4c-3b5046450e16
random_point() = Point(rand(), rand())

# ╔═╡ d7300e13-6544-444b-bcdc-9efd85d132c5
function inside_circle(p, radius = 1.0)
	if norm(p) ≤ radius
		return 1
	end
	return 0
end

# ╔═╡ 28ed6067-a408-4d9f-aaf1-aadfe0e5f1c9
inside_circle(random_point())

# ╔═╡ 1a4420de-d5d1-4703-aa92-369c91577ed4
let
	Random.seed!(42)
	
	Ncounts = 1000
	mypoints = [ random_point() for vitor in 1:Ncounts ]
	output = map( inside_circle, mypoints )
	
	ratio = sum(output) / Ncounts

	xvals = map( p -> p.x, mypoints )
	yvals = map( p -> p.y, mypoints )
	colors = map( b -> b == 1 ? :orange : :blue, output )

	scatter(xvals, yvals; label = false, color = colors, xlabel = L"$x$", ylabel = L"$y$")
	xrange = 0:0.001:1
	plot!( xrange, sqrt.(1 .- xrange.^2); color = :turquoise, aspect_ratio = :equal, lw = 4, label = false, title = L"$\pi \approx %$(4ratio)$" )
end

# ╔═╡ Cell order:
# ╠═cdf2d5ca-4c26-11ee-2a6d-c1c5d956051a
# ╠═6d270528-2c3f-4f0a-a114-8a3cb57f97ca
# ╠═97c36208-d842-40ec-9418-abe3bd761476
# ╠═93cbd4a6-36d7-42ed-b5b2-1a7414b27768
# ╠═63e5c816-31c2-4c74-a2b4-a25d843defb5
# ╠═425783bc-6e18-4374-9b7e-f6db5b73aa3a
# ╠═62da9665-2b2a-4cdc-a114-4043a15d0853
# ╟─61c95dc0-7edd-4b0b-96ae-e86193844a7c
# ╟─cf83bcf2-a9a1-4af8-b939-9b4dee20614a
# ╠═f12c93f7-7eb4-4eef-82dc-c34912574c1f
# ╟─df026034-7f7b-45c7-abe1-cede1b2bb217
# ╠═59258075-c630-466c-859c-cde7ae664f25
# ╟─193e05d5-9ae2-496a-8b23-fb790d33ae17
# ╠═8d1c38c8-dcd4-49bd-8b96-5ee1b4588f56
# ╠═831bc646-2b58-4877-a287-8dcf35a40dbb
# ╠═504b5fa6-7ad6-4d1f-ba4c-3b5046450e16
# ╠═d7300e13-6544-444b-bcdc-9efd85d132c5
# ╠═28ed6067-a408-4d9f-aaf1-aadfe0e5f1c9
# ╠═1a4420de-d5d1-4703-aa92-369c91577ed4
