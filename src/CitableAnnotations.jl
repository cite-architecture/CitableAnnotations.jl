module CitableAnnotations
using Documenter, DocStringExtensions
using Test

using CitableBase
using CitableObject
using CitableText


export AbstractAnnotationSet
export annotatedtype, annotatingtype 
export annotated, annotators

include("abstract.jl")
include("commentary.jl")
end # module
