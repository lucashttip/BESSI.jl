# ABSTRACT TYPES AND STRUCTURES FOR GEOMETRIC DEFINITIONS
abstract type AbstractPoint{dim,T} end

abstract type AbstractElement end
abstract type AbstractElement2D <: AbstractElement end
abstract type AbstractElement3D <: AbstractElement end

abstract type AbstractMesh end

# ========== Point and Node Definitions and Methods ==========

struct Point{dim,T} <: AbstractPoint{dim,T}
    x::SVector{dim,T}
    idx::Int
    function Point(x::Array{T}, idx::Int) where T <: Real
        dim = length(x)
        if dim < 1 || dim > 3
            throw(ArgumentError("Point must have 2 or 3 coordinates."))
        end
        new{dim,T}(SVector(x...), idx)
    end
end

struct Node{dim,T} <: AbstractPoint{dim,T}
    x::SVector{dim,T}
    idx::Int
    function Node(x::Array{T}, idx::Int) where T <: Real
        dim = length(x)
        if dim < 1 || dim > 3
            throw(ArgumentError("Point must have 2 or 3 coordinates."))
        end
        if idx < 0
            throw(ArgumentError("Node index must be non-negative."))
        end
        new{dim,T}(SVector(x...), idx)
    end
end

get_coordinates(p::AbstractPoint) = p.x
get_eltype(::AbstractPoint{dim, T}) where {dim, T} = T
get_idx(p::AbstractPoint) = p.idx

# ========= Elements definitions and methods ==========

# struct ContinuousElement2D{T} <: AbstractElement2D
#     nodes::Vector{Node{1,T}}
#     idx::Int

#     function ContinuousElement1D(nodes::Vector{Node{2,T}},idx = 0) where T <: Number
#         if length(nodes) < 2
#             throw(ArgumentError("Element1D must have at least two nodes."))
#         end
#         incidence = [n.idx for n in nodes]
#         new{T}(nodes, idx)
#     end
# end

# struct DiscontinousElement2D{T} <: AbstractElement2D
#     points::Vector{Point{1,T}}
#     nodes::Vector{Node{1,T}}
#     idx::Int = 0


#     function DiscontinousElement1D(nodes::Vector{Node{2,T}}) where T <: Number
#         if length(nodes) < 2
#             throw(ArgumentError("Element1D must have at least two nodes."))
#         end
#         incidence = [n.idx for n in nodes]
#         new{T}(nodes, incidence)
#     end
# end


struct QuadrilateralContinuousElement{dim,T<:AbstractFloat} <: AbstractElement3D
    nodes::SVector{dim,Node{3,T}}
    idx::Int

    function QuadrilateralContinuousElement(nodes::Vector{Node{3,T}}, idx::Int = 0) where T <: Real
        dim = length(nodes)

        if dim ∉ [4, 8, 9]
            throw(ArgumentError("Quadrilateral element not supported, must have 4, 8, or 9 nodes."))
        end
        incidence = [n.idx for n in nodes]
        new{dim,T}(SVector{dim}(nodes), idx)
    end
end

# struct QuadrilateralDiscontinuousElement{dim,T<:AbstractFloat} <: AbstractElement3D
#     nodes::SVector{dim,Node{2,T}}
#     points::SVector{dim,Point{2,T}}
#     idx::Int

#     function QuadrilateralContinuousElement(nodes::Vector{Node{2,T}}, idx = 0) where T <: Real
#         dim = length(nodes)

#         if dim ∉ [4, 8, 9]
#             throw(ArgumentError("Quadrilateral element not supported, must have 4, 8, or 9 nodes."))
#         end
#         incidence = [n.idx for n in nodes]
#         new{dim,T}(nodes, idx)
#     end
# end

get_nodes(e::AbstractElement) = e.nodes
get_coordinates(e::AbstractElement) = vcat(get_coordinates.(e.nodes)'...)
get_global_incidence(e::AbstractElement) = [n.idx for n in e.nodes]
get_local_incidence(e::AbstractElement) = 1:length(e.nodes)
get_eltype(e::AbstractElement) = typeof(e)
get_idx(e::AbstractElement) = e.idx

# ========== Mesh definitions and methods ==========

# struct ContinuousMesh <: AbstractMesh 
#     nodes::Vector{Node}
#     elements::Vector{AbstractElement}
# end

# struct DiscontinuousMesh <: AbstractMesh
#     nodes::Vector{Node}
#     elements::Vector{AbstractElement}
#     points::Vector{Point}
# end    
