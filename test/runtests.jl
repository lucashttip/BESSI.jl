using Bemto
using Test

@testset "Bemto.jl" begin
    # Write your tests here.
    # @test Bemto.Lagrange_func(-1.0;order=1,dim=1) == [1.0,0.0]
end

@testset "Points" begin

    p2D = Bemto.Point([1.0, 2.0], 1)
    p3D = Bemto.Point([1.0, 2.0, 3.0], 2)
    @test get_coordinates(p2D) == [1.0, 2.0]
    @test get_coordinates(p3D) == [1.0, 2.0, 3.0]
    @test get_eltype(p2D) == Float64
    @test get_eltype(p3D) == Float64
    @test get_idx(p2D) == 1
    @test get_idx(p3D) == 2

    n2D = Bemto.Node([1.0, 2.0], 1)
    n3D = Bemto.Node([1.0, 2.0, 3.0], 2)
    @test get_coordinates(n2D) == [1.0, 2.0]
    @test get_coordinates(n3D) == [1.0, 2.0, 3.0]
    @test get_eltype(n2D) == Float64
    @test get_eltype(n3D) == Float64
    @test get_idx(n2D) == 1
    @test get_idx(n3D) == 2

end

@testset "Elements" begin

    # Test the creation of a 2D element

    Nodes = [
        Bemto.Node([1.0, 1.0, 0.0], 5),
        Bemto.Node([2.5, 1.0, 0.0], 6),
        Bemto.Node([2.5, 2.5, 0.0], 7),
        Bemto.Node([1.0, 2.5, 0.0], 8)
    ]
    e2D = Bemto.QuadrilateralContinuousElement(Nodes, 3)
    @test get_nodes(e2D) == Nodes
    @test get_coordinates(e2D) == Bemto.SMatrix{4,3}([1.0 1.0 0.0; 2.5 1.0 0.0; 2.5 2.5 0.0; 1.0 2.5 0.0])
    @test get_global_incidence(e2D) == [5, 6, 7, 8]
    @test get_local_incidence(e2D) == [1, 2, 3, 4]
    @test get_eltype(e2D) == Bemto.QuadrilateralContinuousElement{4,Float64}
    @test get_idx(e2D) == 3


end

@testset "1D Geometry" begin
    # Write your tests here.
end

@testset "2D Geometry" begin
    # Write your tests here.
end

# This testset is for testing the different possible interpolations in the package, in 3D and in 2D
@testset "Interpolations" begin
    
    # Let's also add the serendipidy function interpolations
    # TODO: For 1D we will only implement the basic lagrange interpolations. Let's define lagrange interpolations for orders 0, 1, and 2 manually
    # For all orders above 2, Lagrange interpolations will be automatic
    # Let's consider descontinuous interpolations as well
    # TODO: For 2D interpolations, let's start by considering two possible cases, the triangle and the quadrilteral
    # For each one let's implement the larange and the serendipity functions as well

    ip_LagrangeQuadrilateralContinuous = Bemto.LagrangeInterpolationQuadrilateral(1)

    @test get_ip_order(ip_LagrangeQuadrilateralContinuous) == 1
    @test get_ip_positions(ip_LagrangeQuadrilateralContinuous) == Bemto.SVector{2}([-1.0, 1.0])

    @test shapefunctions(ip_LagrangeQuadrilateralContinuous, 0.0, 0.0) == [0.25 0.25 0.25 0.25]
    @test shapefunctions(ip_LagrangeQuadrilateralContinuous, -1.0, -1.0) == [1.0 0.0 0.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralContinuous, 1.0, -1.0) == [0.0 1.0 0.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralContinuous, 1.0, 1.0) == [0.0 0.0 1.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralContinuous, -1.0, 1.0) == [0.0 0.0 0.0 1.0]

    Nodes = [
        Bemto.Node([1.0, 1.0, 0.0], 5),
        Bemto.Node([2.5, 1.0, 0.0], 6),
        Bemto.Node([2.5, 2.5, 0.0], 7),
        Bemto.Node([1.0, 2.5, 0.0], 8)
    ]
    e2D = Bemto.QuadrilateralContinuousElement(Nodes, 3)
    @test interpolate(ip_LagrangeQuadrilateralContinuous, e2D, 0.0, 0.0) == [1.75, 1.75, 0.0]

    ip_LagrangeQuadrilateralDiscontinuous = Bemto.LagrangeInterpolationQuadrilateral(1, 0.2)

    @test get_ip_order(ip_LagrangeQuadrilateralDiscontinuous) == 1
    @test get_ip_positions(ip_LagrangeQuadrilateralDiscontinuous) == Bemto.SVector{2}([-0.8, 0.8])

    @test shapefunctions(ip_LagrangeQuadrilateralDiscontinuous, 0.0, 0.0) == [0.25 0.25 0.25 0.25]
    @test shapefunctions(ip_LagrangeQuadrilateralDiscontinuous, -0.8, -0.8) == [1.0 0.0 0.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralDiscontinuous, 0.8, -0.8) == [0.0 1.0 0.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralDiscontinuous, 0.8, 0.8) == [0.0 0.0 1.0 0.0]
    @test shapefunctions(ip_LagrangeQuadrilateralDiscontinuous, -0.8, 0.8) == [0.0 0.0 0.0 1.0]


end

@testset "Numerical Integration" begin

    qr_GaussLegendre = GaussLegendreQuadrature(4)

    @test get_qr_order(qr_GaussLegendre) == 4
    @test get_qr_points_and_weights(qr_GaussLegendre) == (
        Bemto.SVector{4, Float64}([-0.8611363115940526, -0.3399810435848563, 0.3399810435848563, 0.8611363115940526]),
        Bemto.SVector{4, Float64}([0.34785484513745385, 0.6521451548625462, 0.6521451548625462, 0.34785484513745385])
    )

    Nodes = [
        Bemto.Node([1.0, 1.0, 0.0], 5),
        Bemto.Node([2.5, 1.0, 0.0], 6),
        Bemto.Node([2.5, 2.5, 0.0], 7),
        Bemto.Node([1.0, 2.5, 0.0], 8)
    ]
    e2D = Bemto.QuadrilateralContinuousElement(Nodes, 3)

    @test get_quadrature_points_and_weights(qr_GaussLegendre, e2D) == (
        ([1.1041477663044603 1.1041477663044605 0.0; 1.1041477663044603 1.4950142173113576 0.0; 1.1041477663044605 2.004985782688642 0.0; 1.1041477663044605 2.395852233695539 0.0; 1.4950142173113579 1.1041477663044605 0.0; 1.4950142173113579 1.4950142173113579 0.0; 1.4950142173113579 2.0049857826886424 0.0; 1.4950142173113576 2.395852233695539 0.0; 2.004985782688642 1.1041477663044605 0.0; 2.0049857826886424 1.4950142173113576 0.0; 2.0049857826886424 2.0049857826886424 0.0; 2.004985782688642 2.3958522336955395 0.0; 2.395852233695539 1.1041477663044603 0.0; 2.395852233695539 1.4950142173113579 0.0; 2.395852233695539 2.004985782688642 0.0; 2.395852233695539 2.395852233695539 0.0], [0.121002993285602, 0.22685185185185186, 0.22685185185185186, 0.121002993285602, 0.22685185185185186, 0.42529330301069435, 0.42529330301069435, 0.22685185185185186, 0.22685185185185186, 0.42529330301069435, 0.42529330301069435, 0.22685185185185186, 0.121002993285602, 0.22685185185185186, 0.22685185185185186, 0.121002993285602])
    )

    

end