"Abstract type for a citable annotation."
abstract type AbstractAnnotationSet <: Citable end


"""Find unique list of annotated objects.
$(SIGNATURES)
"""
function annotated(anns::T) where {T <: AbstractAnnotationSet}
    throw(ArgumentError("`annotated` not implemented for $(typeof(anns))."))
end


"""Find unique list of annotating sources.
$(SIGNATURES)
"""
function annotators(anns::T) where {T <: AbstractAnnotationSet}
    throw(ArgumentError("`annotators` not implemented for $(typeof(anns))."))
end




"""Find Julia type of annotating source.
$(SIGNATURES)
"""
function annotatingtype(anns::T) where {T <: AbstractAnnotationSet}
    throw(ArgumentError("`annotatingtype` not implemented for $(typeof(anns))."))
end

"""Find Julia type of annotated objects.
$(SIGNATURES)
"""
function annotatedtype(anns::T) where {T <: AbstractAnnotationSet}
    throw(ArgumentError("`annotatedtype` not implemented for $(typeof(anns))."))
end