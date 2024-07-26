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



@testset "Test difficult numeric tokens"  begin

    #=
    This is the a good stress test:

    From Archimedes, *Dim.Circ* prop. 3:

    Ὡς ἄρα συναμφότερος ἡ ΖΕ, ΕΓ πρὸς ΖΓ, ἡ ΕΓ πρὸς ΓΗ: ὥστε ἡ ΓΕ πρὸς ΓΗ μείζονα λόγον ἔχει ἤπερ φοαʹ πρὸς ρνγʹ. Ἡ ΕΗ ἄρα πρὸς ΗΓ δυνάμει λόγον ἔχει, ὃν Μ^λδ^ ,θυνʹ πρὸς Μ^β^ ,γυθʹ:  μήκει ἄρα, ὃν φϙαʹ  η″ πρὸς ρνγʹ.

    =#

    ortho = stemortho()
    thousands = ",γυθʹ" # = 3,409
    @test validstring(thousands, ortho) 
    thousands_tkns = tokenize(thousands, ortho)
    @test length(thousands_tkns) == 1
    @test tokencategory(thousands_tkns[1]) isa MilesianIntegerToken

    hundreds = "φϙαʹ" # == 591
    @test validstring(hundreds, ortho) 
    hundreds_tkns = tokenize(hundreds, ortho)
    @test length(hundreds_tkns) == 1
    @test tokencategory(hundreds_tkns[1]) isa MilesianIntegerToken

    myriads = "Μ^β^"
    @test validstring(myriads, ortho) # == 20,000
    myriads_tkns = tokenize(myriads, ortho)
    @test length(myriads_tkns) == 1
    @test tokencategory(myriads_tkns[1]) isa MilesianIntegerToken


    fraction = "η″"
    @test validstring(fraction, ortho) # == 1/8
    fraction_tkns = tokenize(fraction, ortho)
    @test length(fraction_tkns) == 1
    @test tokencategory(fraction_tkns[1]) isa MilesianFractionToken


    ouden = "Οʹ"
    @test validstring(ouden, ortho)
    ouden_tkns = tokenize(ouden, ortho)
    @test length(ouden_tkns) == 1
    @test tokencategory(ouden_tkns[1]) isa MilesianIntegerToken

end
