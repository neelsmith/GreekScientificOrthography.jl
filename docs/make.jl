# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build", port=8000)'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using GreekScientificOrthography


makedocs(
    sitename="GreekScientificOrthography.jl",
    pages = [
        "Home" => Any[
    
            "Documentation" => "index.md",

        ],  
    ],
    )

deploydocs(
    repo = "github.com/neelsmith/GreekScientificOrthography.jl.git",
)