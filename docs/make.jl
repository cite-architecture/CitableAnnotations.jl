# Use this from root directory of repository, e.g.,
#
#   julia --project=docs/ docs/make.jl
#
# Serve docs from repository root:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CitableAnnotations

makedocs(
    sitename = "CitableAnnotations.jl",
    pages = [
        "Home" => "index.md"
   
    ]
    )

deploydocs(
    repo = "github.com/cite-architecture/CitableAnnotations.jl.git",
) 
