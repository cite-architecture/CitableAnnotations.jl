module CitableAnnotations
using Documenter, DocStringExtensions
using Test

import Base: show
import Base: ==

using CiteEXchange
using CitableObject
using CitableText

using CitableBase
import CitableBase: citabletrait
import CitableBase: urntype
import CitableBase: urn
import CitableBase: label

#=
urncomparisontrait
urnequals
urncontains
urnsimilar
=#

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

export AbstractAnnotationSet
export annotatedtype, annotatingtype 
export annotated, annotators

export CitableCommentary

include("abstract.jl")
include("commentary.jl")
include("utils.jl")
end # module
