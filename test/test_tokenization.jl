@testset "Test tokenization and classification of tokens" begin
    ortho = stemortho()
    @test ortho isa GreekSciOrthography


    astro = tokenize("♋", ortho)[1]
    @test tokencategory(astro) isa AstronomicalSymbol


    milint = tokenize("αʹ", ortho)[1]


end

@testset "Test validation"  begin
    ortho = stemortho()
    cancer = "♋"
    @test validstring(cancer, ortho)
    cancertkn = tokenize(cancer, ortho)[1]
    @test tokencategory(cancertkn) isa AstronomicalSymbol

    archim = "ἡ ΓΕ πρὸς ΓΗ μείζονα λόγον ἔχει ἤπερ φοαʹ πρὸς ρνγʹ."
    @test validstring(archim, ortho)
    tkns = tokenize(archim, ortho)
    @test length(tkns) == 12
    @test tokencategory(tkns[1]) isa LexicalToken
    @test tokencategory(tkns[2]) isa FigureLabelToken
    @test tokencategory(tkns[12]) isa PunctuationToken
    @test tokencategory(tkns[11]) isa MilesianIntegerToken
end