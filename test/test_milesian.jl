
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
    @test milesian("Μ^β^ α,$(NUMERIC_TICK)") == 21000
    @test milesian("Μ^β^ α,α$(NUMERIC_TICK)") == 21001
end


@testset "Test parsing fractional values" begin
    @test milesian("𐅵$(FRACTION_TICK)") == 0.5
    @test milesian("𐅷$(FRACTION_TICK)") == (2 / 3)
    @test milesian("𐅸$(FRACTION_TICK)") == 0.75


    @test milesian("β$(FRACTION_TICK)") == 0.5
    @test milesian("ιβ$(FRACTION_TICK)") ==  (1 / 12)

end
