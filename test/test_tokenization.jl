@testset "Test tokenization and classification of tokens" begin
    ortho = stemortho()
    @test ortho isa GreekSciOrthography


    astro = tokenize("♋", ortho)[1]
    @test tokencategory(astro) isa AstronomicalSymbol


    milint = tokenize("αʹ", ortho)[1]


end

@testset "Test validation"  begin
    ortho = stemortho()
    @test validstring("♋", ortho)
end