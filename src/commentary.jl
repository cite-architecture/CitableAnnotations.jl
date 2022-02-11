"Annotatoions by one text on another text."
struct CitableCommentary <: AbstractAnnotationSet
    urn::Cite2Urn
    label::AbstractString
    commentary::Vector{Tuple{CtsUrn, CtsUrn}}
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

"""Find unique set of annotated objects.
$(SIGNATURES)
"""
function annotated(comm::CitableCommentary)
    map(t -> droppassage(t[2]), comm.commentary) |> Set
end

"""Find unique set of annotating sources.
$(SIGNATURES)
"""
function annotators(comm::CitableCommentary)
    map(t -> droppassage(t[1]), comm.commentary) |> Set
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


"Singleton type for value of `CexTrait`"
struct CommentaryCex <: CexTrait end
"""Set value of `CexTrait` for `CitableCommentary`
$(SIGNATURES)
"""
function cextrait(::Type{CitableCommentary})
    CommentaryCex()
end



"""Format a `CitableCommentary` as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(comm::CitableCommentary; delimiter = "|")
    lines = ["#!citerelationset",
        "urn$(delimiter)$(urn(comm))",
        "label$(delimiter)$(label(comm))",
        "",
        "annotator$(delimiter)annotated"
    ]
    for pr in comm.commentary
        push!(lines, string(pr[1]) * delimiter * string(pr[2]))
    end
    join(lines, "\n")
end




"""Parse a delimited-text string into a `CitableCommentary`.
$(SIGNATURES)

`cexsrc` should be a single `citerelationset` block.
"""
function fromcex(trait::CommentaryCex, cexsrc::AbstractString, ::Type{CitableCommentary}; 
    delimiter = "|", configuration = nothing, strict = true)
    (coll_urn, coll_label) = headerinfo(cexsrc, delimiter = delimiter)

    datapairs = []
    datalines = data(cexsrc, "citerelationset", delimiter = delimiter)
    for ln in datalines
        columns = split(ln, delimiter)
        push!(datapairs, (CtsUrn(columns[1]), CtsUrn(columns[2]))) 
    end
    CitableCommentary(coll_urn, coll_label, datapairs)
end




"""Number of annotatoins in `ms`.
$(SIGNATURES)
"""
function length(c::CitableCommentary)
    length(c.commentary)
end


	
"""A `Codex` is a collection of `MSPage`s.
$(SIGNATURES)
"""
function eltype(c::CitableCommentary)
    Tuple{CtsUrn, CtsUrn}
end

"""Initial state of iterator for a `Codex`.
$(SIGNATURES)
"""
function iterate(c::CitableCommentary)
    isempty(c.commentary) ? nothing : (c.commentary[1], 2)
end

"""Iterate a `Codex` with array index at `state`.
$(SIGNATURES)
"""
function iterate(c::CitableCommentary, state)
    state > length(c.commentary) ? nothing : (c.commentary[state], state + 1)
end

"""Filter the list of pages in a `Codex`.
$(SIGNATURES)
"""
function filter(f, c::CitableCommentary)
     Iterators.filter(f, collect(c))
end

"""Reverse the order of pages in a `Codex`.
$(SIGNATURES)
I don't know, maybe you need to page through backwards
for some reason.
"""
function reverse(c::CitableCommentary)
    reverse(c.commentary)
end
