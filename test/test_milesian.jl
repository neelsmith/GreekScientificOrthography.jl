
@testset "Test parsing integer values" begin
    @test milesian("Ο$(NUMERIC_TICK)") == 0
    @test milesian("α$(NUMERIC_TICK)") == 1
    @test milesian("ρα$(NUMERIC_TICK)") == 101
    @test milesian("ρια$(NUMERIC_TICK)") == 111
    @test milesian("α,$(NUMERIC_TICK)") == 1000
    @test milesian("α,α$(NUMERIC_TICK)") == 1001

    @test milesian("θ,ϡϙθ$(NUMERIC_TICK)") == 9999
    @test milesian("Μ$(NUMERIC_TICK)") == 10000
    
    @test milesian("Μ$(NUMERIC_TICK) α$(NUMERIC_TICK)") == 10001
    @test milesian("Μ$(NUMERIC_TICK) θ,ϡϙθ$(NUMERIC_TICK)") == 19999
    @test milesian("Μ^β^") == 20000
    @test milesian("Μ^β^ α,$(NUMERIC_TICK)") == 21001
end