function rmaccents(s::AbstractString, ortho::GreekSciOrthography)
end

function addacute(s::AbstractString)
    PolytonicGreek.addacute(s)
end

function addcircumflex(s::AbstractString)
    PolytonicGreek.addcircumflex(s)
end

function accentsyllable(s::AbstractString, syll, ortho::GreekSciOrthography)  
    accentsyllable(s,syll,literaryGreek())
end

function augment(s::AbstractString, ortho::GreekSciOrthography)
    augment(s, literaryGreek())
end

#=
function augment(ortho::GreekSciOrthography; s::AbstractString = "")
    PolytonicGreek.augment(literaryGreek(); s = s)
end
=#
function augment_initial(ortho::GreekSciOrthography)
    PolytonicGreek.nfkc("ἐ")
end


function augment_medial(ortho::GreekSciOrthography)
    "ε"
end