@testset "Test tokenization and classification of tokens" begin
    ortho = stemortho()
    @test ortho isa GreekSciOrthography
end