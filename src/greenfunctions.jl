function testSingularity3D(field_point::Vector{AbstractFloat}, source_point::Vector{AbstractFloat}; order = 1)
    r = norm(field_point - source_point)
    return 1 / (r^order)
end

testSingularity3D(field_point::Vector{AbstractFloat}, source_point::AbstractPoint; order = 1) = testSingularity3D(field_point, get_coordinates(source_point); order = order)