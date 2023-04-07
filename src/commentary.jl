"Annotations by one text on another text."
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

"""Find unique set of texts commented on.
$(SIGNATURES)
URNs identify versions or exemplars of texts without passage references.
"""
function annotated(comm::CitableCommentary)
    map(t -> droppassage(t[2]), comm.commentary) |> Set
end

"""Find unique set of texts commenting on other texts.
$(SIGNATURES)
URNs identify versions or exemplars of texts without passage references.
"""
function annotators(comm::CitableCommentary)
    map(t -> droppassage(t[1]), comm.commentary) |> Set
end

"""In a `CitableCommentary`, commenting texts are identifed by `CtsUrn`.
$(SIGNATURES)
"""
function annotatingtype(comm::CitableCommentary)
    CtsUrn
end

"""In a `CitableCommentary`, texts commented on are identifed by `CtsUrn`.
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




"""Parse a delimited-text string into a (possibly empty) list of `CitableCommentary`s.
$(SIGNATURES)
"""
function fromcex(trait::CommentaryCex, cexsrc::AbstractString, ::Type{CitableCommentary}; 
    delimiter = "|", configuration = nothing, strict = true)

    commentarysets = []
    modelblocks = blocks(cexsrc, "datamodels")
    for mb in modelblocks
        for ln in mb.lines[2:end]
            cols = split(ln, delimiter)
            collurn =  Cite2Urn(cols[1])
            modelurn = Cite2Urn(cols[2])
            if modelurn == COMMENTARY_MODEL
                push!(commentarysets,collurn)
            else
                @debug("$(modelurn) != $(COMMENTARY_MODEL)")
            end
        end
    end

    crblocks = blocks(cexsrc, "citerelationset")
    commblocks = []
    crurns = map(crblocks) do blk
        split(blk.lines[1], delimiter)[2] |> Cite2Urn
    end
    for commseturn in commentarysets
        blockindices = findall(u -> u == commseturn, crurns)
        for idx in blockindices
            push!(commblocks, crblocks[idx])
        end
    end
    

    commentaries = []
    for blk in commblocks
        datapairs = []
        (coll_urn, coll_label) = headerinfo(blk, delimiter = delimiter)
        for ln in blk.lines
            columns = split(ln, delimiter)
            try
                push!(datapairs, (CtsUrn(columns[1]), CtsUrn(columns[2]))) 
            catch 
                @warn("Skipping line $(ln)")
            end
        end

        push!(commentaries, CitableCommentary(coll_urn, coll_label, datapairs))
    end
    commentaries
end




"""Number of annotations in `c`.
$(SIGNATURES)
"""
function length(c::CitableCommentary)
    length(c.commentary)
end


	
"""Commentaries index text passage to text passage.
$(SIGNATURES)
"""
function eltype(c::CitableCommentary)
    Tuple{CtsUrn, CtsUrn}
end

"""Initial state of iterator for a `CitableCommentary`.
$(SIGNATURES)
"""
function iterate(c::CitableCommentary)
    isempty(c.commentary) ? nothing : (c.commentary[1], 2)
end

"""Iterate a `CitableCommentary` with array index at `state`.
$(SIGNATURES)
"""
function iterate(c::CitableCommentary, state)
    state > length(c.commentary) ? nothing : (c.commentary[state], state + 1)
end

"""Filter the annotations in a `CitableCommentary`.
$(SIGNATURES)
"""
function filter(f, c::CitableCommentary)
     Iterators.filter(f, collect(c))
end

"""Reverse the order of annotations in a `CitableCommentary`.
$(SIGNATURES)
I don't know, maybe you need to page through backwards
for some reason.
"""
function reverse(c::CitableCommentary)
    reverse(c.commentary)
end
