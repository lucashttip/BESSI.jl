module Bemto


# using GeometryBasics:
#     Vec
using LinearAlgebra
using StaticArrays:
    SVector, SMatrix, @SVector, @SMatrix
using FastGaussQuadrature:
    gausslegendre

# Write your package code here.

# include("shapefunctions.jl")

include("geometricdefinitions.jl")
export get_coordinates, get_eltype, get_idx, get_nodes, get_global_incidence, get_local_incidence

include("greenfunctions.jl")
export testSingularity3D

include("interpolations.jl")
export get_ip_order, get_ip_positions, shapefunctions, LagrangeInterpolationQuadrilateral, interpolate

include("quadratures.jl")
export GaussLegendreQuadrature, get_qr_order, get_qr_points_and_weights, get_quadrature_points_and_weights, integrate_element

end
