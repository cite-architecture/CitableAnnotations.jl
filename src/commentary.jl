"Annotatoions by one text on another text."
struct CitableCommentary <: AbstractAnnotationSet
    commentary
end

"""Find unique list of annotated objects.
$(SIGNATURES)
"""
function annotated(comm::CitableCommentary)
    throw(ArgumentError("`annotated` not implemented for $(typeof(anns))."))
end

"""Find unique list of annotating sources.
$(SIGNATURES)
"""
function annotators(comm::CitableCommentary)
    throw(ArgumentError("`annotators` not implemented for $(typeof(anns))."))
end

"""Find Julia type of annotating source.
$(SIGNATURES)
"""
function annotatingtype(comm::CitableCommentary)
    CtsUrn
end

"""Find Julia type of annotated objects.
$(SIGNATURES)
"""
function annotatedtype(comm::CitableCommentary)
    CtsUrn
end