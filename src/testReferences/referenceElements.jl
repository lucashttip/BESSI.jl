function referenceQuadrilateralElement()
    # Create a quadrilateral element with 4 nodes
    nodes = [
        Node([1.0, 1.0, 0.0], 1),
        Node([2.5, 1.0, 0.0], 2),
        Node([2.5, 2.5, 0.0], 3),
        Node([1.0, 2.5, 0.0], 4)
    ]

    element = QuadrilateralElement(nodes, 1)
    
    # Check the number of nodes
    @test length(element.nodes) == 4
    
    # Check the node IDs
    @test element.nodes == nodes
    
    return element
end