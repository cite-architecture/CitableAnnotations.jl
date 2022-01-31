"Annotatoions by one text on another text."
struct CitableCommentary <: AbstractAnnotationSet
    urn::Cite2Urn
    label::AbstractString
    commentary
end

"""Override `show` for `DSECollection`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, comm::CitableCommentary)
    print(io, comm.urn, " ", comm.label)
end

"""Override `==` for `CitableCommentary`
$(SIGNATURES)
"""
function ==(comm1::CitableCommentary, comm2::CitableCommentary)
    comm1.urn.urn == comm2.urn.urn && comm1.label == comm2.label && comm1.data == comm2.data
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



"Define singleton type to use as value of `CitableTrait` on `CitableCommentary`."
struct CommentaryCitation <: CitableTrait end
"""Set value of `CitableTrait` for `CitableCommentary`.
$(SIGNATURES)
"""
function citabletrait(::Type{CitableCommentary})
    CommentaryCitation()
end

"""Type of URN identifying `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(comm::CitableCommentary)
    Cite2Urn
end


"""URN identifying `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(comm::CitableCommentary)
    comm.urn
end

"""Label for `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(comm::CitableCommentary)
    comm.label
end