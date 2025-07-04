# This file contains all the shape functions used in Bemto.jl
# Created by: Lucas Agatti Pacheco
# Last modified: 21/05/2024


# function map_k2d(k;deg=1)

#     if deg == 1
#         aux = [(1,1),(2,1),(2,2),(1,2)]
#     elseif deg == 2
#         aux = [(1,1),(2,1),(3,1),
#         (1,2),(2,2),(3,2),
#         (1,3),(2,3),(3,3)]
#     end

#     return aux[k]

# end


# """
#     Lagrange_func(csi;ep=0.0,dim=2,deg=1)

# Computes the value of Lagrange polynomials of dimension `dim` and degree `deg` on point `csi` with local coordinate system [-1,1] 
# """
# function Lagrange_func(csi::Float64,eta::Float64=0.0;ep=0.0,dim=2,deg=1)

#     csis = range(-1+ep,1-ep,length=deg+1)

#     nnodes = (deg+1)^dim

#     N = ones(nnodes)

#     if dim == 1

#         for i in 1:nnodes
#             for l in eachindex(csis)
#                 if l != i
#                     N[i] = N[i]*(csi-csis[l])/(csis[i]-csis[l])
#                 end
#             end
#         end

#     elseif dim == 2

#         for k in 1:nnodes
#             i,j = map_k2d(k;deg=deg)

#             for l in eachindex(csis)
#                 if l != i
#                     N[k] = N[k]*(csi-csis[l])/(csis[i]-csis[l])
#                 end
#             end
#             for l in eachindex(csis)
#                 if l != j
#                     N[k] = N[k]*(eta-csis[l])/(csis[j]-csis[l])
#                 end
#             end
#         end
#     end

#     return N
# end

# function Lagrange_func(csi::Vector{Float64};ep=0.0,dim=2,deg=1)
#     Lagrange_func(csi[1],csi[2];ep=ep,dim=2,deg=deg)
# end


# """
# TODO WIP
# Lagrange_deriv(csi;ep=0.0,dim=2,order=1)

# Computes the value of derivative of the Lagrange polynomials of dimension `dim` and order `order` on point `csi` with local coordinate system [-1,1] 
# """
# function Lagrange_deriv(csi::Float64, order::Int64=0,eta::Float64=0.0;ep=0.0,dim=2,deg=1)

#     csis = range(-1+ep,1-ep,length=deg+1)

#     nnodes = (deg+1)^dim

#     N = ones(nnodes)

#     if dim == 1

#         for i in 1:nnodes
#             for l in eachindex(csis)
#                 if l != i
#                     N[i] = N[i]*(csi-csis[l])/(csis[i]-csis[l])
#                 end
#             end
#         end

#     elseif dim == 2

#         for k in 1:nnodes
#             i,j = map_k2d(k;deg=deg)

#             for l in eachindex(csis)
#                 if l != i
#                     N[k] = N[k]*(csi-csis[l])/(csis[i]-csis[l])
#                 end
#             end
#             for l in eachindex(csis)
#                 if l != j
#                     N[k] = N[k]*(eta-csis[l])/(csis[j]-csis[l])
#                 end
#             end
#         end
#     end

#     return N
# end


# """
# TODO WIP
# normal_jacobian()

# Description
# """
# function normal_jacobian()

# end