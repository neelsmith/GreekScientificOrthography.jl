function rmaccents(s::AbstractString, ortho::GreekMathOrthography)
end

function addacute(s::AbstractString)
    PolytonicGreek.addacute(s)
end

function addcircumflex(s::AbstractString)
    PolytonicGreek.addcircumflex(s)
end

function accentsyllable(s::AbstractString, syll, ortho::GreekMathOrthography)  
    accentsyllable(s,syll,literaryGreek())
end

function augment(s::AbstractString, ortho::GreekMathOrthography)
    augment(s, literaryGreek())
end

#=
function augment(ortho::GreekMathOrthography; s::AbstractString = "")
    PolytonicGreek.augment(literaryGreek(); s = s)
end
=#
function augment_initial(ortho::GreekMathOrthography)
    PolytonicGreek.nfkc("ἐ")
end


function augment_medial(ortho::GreekMathOrthography)
    "ε"
end