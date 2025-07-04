abstract type AbstractQuadratureRule{NGP} end

struct GaussLegendreQuadrature{NGP} <: AbstractQuadratureRule{NGP}
    points::SVector{NGP,Float64}
    weights::SVector{NGP,Float64}
    function GaussLegendreQuadrature(NGP::Int)
        # Generate Gauss-Legendre quadrature points and weights for 1D
        points, weights = gausslegendre(NGP)
        new{NGP}(SVector{NGP}(points), SVector{NGP}(weights))
    end
end

get_qr_order(::AbstractQuadratureRule{NGP}) where NGP = NGP
get_qr_points_and_weights(qr::AbstractQuadratureRule) = (qr.points, qr.weights)


function get_quadrature_points_and_weights(qr::GaussLegendreQuadrature, element::QuadrilateralContinuousElement, source::AbstractPoint = Point([0.0, 0.0, 0.0], 1))
    # Get quadrature points and weights for the given element and source point

    ip = LagrangeInterpolationQuadrilateral(1)
    
    NGP = get_qr_order(qr)
    (points, weights) = get_qr_points_and_weights(qr)

    qpoints = zeros(NGP^2, 3) # Initialize an empty vector for quadrature points
    qweights = zeros(NGP^2) # Initialize an empty vector for quadrature weights

    i = 1
    for (xi1, wi1) in zip(points, weights)
        for (xi2, wi2) in zip(points, weights)
            # Calculate the quadrature points in the element's local coordinates
            qpoints[i,:] = interpolate(ip, element, xi1, xi2)
            qweights[i] = wi1 * wi2
            i = i + 1
        end
    end

    return qpoints, qweights
end

function integrate_element(element::AbstractElement, source::AbstractPoint, f::Function, qr::AbstractQuadratureRule)
    # Integrate a function f over the domain defined by the quadrature rule qr
    result = 0.0

    qpoints, qweights = get_quadrature_points_and_weights(qr, element, source)

    for (xi, wi) in zip(qpoints, qweights)
        result += wi * f(xi, source)
    end
    return result
end 