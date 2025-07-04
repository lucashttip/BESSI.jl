abstract type AbstractInterpolation end
abstract type AbstractLagrangeInterpolation <: AbstractInterpolation end

struct LagrangeInterpolationQuadrilateral <: AbstractLagrangeInterpolation
    order::Int
    offset::Float64
    l::Vector{Float64}

    function LagrangeInterpolationQuadrilateral(order::Int, offset::Float64 = 0.0)
        l = collect(range(-1.0+offset, 1.0-offset,length=order+1))
        new(order, offset, l)
    end
end

get_ip_order(ip::LagrangeInterpolationQuadrilateral) = ip.order
get_ip_positions(ip::LagrangeInterpolationQuadrilateral) = ip.l
get_offset(ip::LagrangeInterpolationQuadrilateral) = ip.offset

function shapefunctions(ip::LagrangeInterpolationQuadrilateral, csi::Float64, eta::Float64)
    # Calculate the shape functions for a 2D Lagrange interpolation
    order = get_ip_order(ip)
    l = get_ip_positions(ip)
    offset = get_offset(ip)
    N = ones(1,(order+1)^2)

    if order == 0
        N[1] = 1.0
    elseif order == 1
        N[1] = (1/(4*(1-offset)^2)) * (1.0 - offset - csi)*(1.0 - offset - eta)
        N[2] = (1/(4*(1-offset)^2)) * (1.0 - offset + csi)*(1.0 - offset - eta)
        N[3] = (1/(4*(1-offset)^2)) * (1.0 - offset + csi)*(1.0 - offset + eta)
        N[4] = (1/(4*(1-offset)^2)) * (1.0 - offset - csi)*(1.0 - offset + eta)
    elseif order == 2
        # N[1] = 
        # N[2] = 
        # N[3] = 
        # N[4] = 
        # N[5] = 
        # N[6] = 
        # N[7] = 
        # N[8] = 
        # N[9] = 
    else
        error("Order $order not supported for Lagrange interpolation in 2D.")
    end

    return N
end

function interpolate(ip::AbstractLagrangeInterpolation, element::QuadrilateralContinuousElement, csi::Float64, eta::Float64)
    # 1D Lagrange interpolation

    nodes_coordinates = get_coordinates(element)

    N = shapefunctions(ip, csi, eta)

    point_coordinates = N*nodes_coordinates

    return vec(point_coordinates)
end

