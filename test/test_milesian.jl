
@testset "Test parsing integer values" begin
    @test_broken milesian("Ο$(NUMERIC_TICK)") == 0
    @test_broken milesian("α$(NUMERIC_TICK)") == 1
    @test_broken milesian("ρα$(NUMERIC_TICK)") == 101
    @test_broken milesian("ρια$(NUMERIC_TICK)") == 111
    @test_broken milesian("α,$(NUMERIC_TICK)") == 1000
    @test_broken milesian("α,α$(NUMERIC_TICK)") == 1001

    @test_broken milesian("θ,ϡϙθ$(NUMERIC_TICK)") == 9999
    @test_broken milesian("Μ$(NUMERIC_TICK)") == 10000
    
    @test_broken milesian("Μ$(NUMERIC_TICK) α$(NUMERIC_TICK)") == 10001
    @test_broken milesian("Μ$(NUMERIC_TICK) θ,ϡϙθ$(NUMERIC_TICK)") == 19999
    @test_broken milesian("Μ^β^") == 20000
    @test_broken milesian("Μ^β^ α,$(NUMERIC_TICK)") == 21001
end