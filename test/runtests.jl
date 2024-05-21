using BESSI
using Test

@testset "BESSI.jl" begin
    # Write your tests here.
    @test BESSI.Lagrange_func(-1.0;order=1,dim=1) == [1.0,0.0]
end

@testset "Shape functions" begin
    # Write your tests here.
    @test BESSI.Lagrange_func(-1.0;order=1,dim=1) == [1.0,0.0]
    @test BESSI.Lagrange_func(0.5;ep=0.5,order=2,dim=1) == [0.0,0.0,1.0]
    @test BESSI.Lagrange_func(0.4,0.4;ep=0.5,order=2,dim=2) == [0.006399999999999998,
    -0.028799999999999992,
    -0.05759999999999999,
    -0.028799999999999992,
     0.12959999999999997,
     0.2592,
    -0.0576,
     0.2592,
     0.5184000000000001]
end
