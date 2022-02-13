module CitableAnnotations
using Documenter, DocStringExtensions
using Test

import Base: show
import Base: ==


using Base.Iterators
import Base: length
import Base: eltype
import Base: iterate
import Base: filter
import Base: reverse


using CiteEXchange
using CitableObject
using CitableText

using CitableBase
import CitableBase: citabletrait
import CitableBase: urntype
import CitableBase: urn
import CitableBase: label


import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

export AbstractAnnotationSet
export annotatedtype, annotatingtype 
export annotated, annotators

export CitableCommentary
export TextOnPage

include("constants.jl")
include("abstract.jl")
include("commentary.jl")
include("textonpage.jl")
include("utils.jl")
end # module
