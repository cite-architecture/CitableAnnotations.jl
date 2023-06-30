"Index of named entities in a text."
struct NamedEntityIndex <: AbstractAnnotationSet
    urn::Cite2Urn
    label::AbstractString
    index::Vector{Tuple{CtsUrn, Cite2Urn}}
end



"""Override `show` for `NamedEntityIndex`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, idx::NamedEntityIndex)
    print(io, idx.urn, " ", idx.label)
end

"""Override `==` for `CitableCommentary`
$(SIGNATURES)
"""
function ==(idx1::NamedEntityIndex, idx2::NamedEntityIndex)
    idx1.urn.urn == idx2.urn.urn && idx1.label == idx2.label && idx1.index == idx2.index
end



"Define singleton type to use as value of `CitableTrait` on `NamedEntityIndex`."
struct NamedEntity <: CitableTrait end
"""Set value of `CitableTrait` for `NamedEntityIndex`.
$(SIGNATURES)
"""
function citabletrait(::Type{NamedEntityIndex})
    NamedEntity()
end



"""Type of URN identifying `idx`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(idx::NamedEntityIndex)
    Cite2Urn
end


"""URN identifying `idx`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(idx::NamedEntityIndex)
    idx.urn
end

"""Label for `idx`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(idx::NamedEntityIndex)
    idx.label
end



"Singleton type for value of `CexTrait`"
struct NamedEntityCex <: CexTrait end
"""Set value of `CexTrait` for `NamedEntityIndex`
$(SIGNATURES)
"""
function cextrait(::Type{NamedEntityIndex})
    NamedEntityCex()
end




"""Format a `CitableCommentary` as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(idx::NamedEntityIndex; delimiter = "|")
    lines = ["#!citerelationset",
        "urn$(delimiter)$(urn(idx))",
        "label$(delimiter)$(label(idx))",
        "",
        "passage$(delimiter)person"
    ]
    for pr in idx.index
        push!(lines, string(pr[1]) * delimiter * string(pr[2]))
    end
    join(lines, "\n")
end





"""Parse a delimited-text string into a (possibly empty) list of `NamedEntityIndex`s.
$(SIGNATURES)
"""
function fromcex(trait::NamedEntityCex, cexsrc::AbstractString, ::Type{NamedEntityIndex}; 
    delimiter = "|", configuration = nothing, strict = true)

    indexsets = []
    modelblocks = blocks(cexsrc, "datamodels")
    for mb in modelblocks
        for ln in mb.lines[2:end]
            cols = split(ln, delimiter)
            collurn =  Cite2Urn(cols[1])
            modelurn = Cite2Urn(cols[2])
            if modelurn == NAMED_ENTITY_INDEX_MODEL
                push!(indexsets,collurn)
            else
                @debug("$(modelurn) != $(NAMED_ENTITY_INDEX_MODEL)")
            end
        end
    end

    crblocks = blocks(cexsrc, "citerelationset")
    indexblocks = []
    crurns = map(crblocks) do blk
        split(blk.lines[1], delimiter)[2] |> Cite2Urn
    end
    for commseturn in indexsets
        blockindices = findall(u -> u == commseturn, crurns)
        for idx in blockindices
            push!(indexblocks, crblocks[idx])
        end
    end
    

    indices = []
    for blk in indexblocks
        datapairs = []
        (coll_urn, coll_label) = headerinfo(blk, delimiter = delimiter)
        for ln in blk.lines
            columns = split(ln, delimiter)
            try
                push!(datapairs, (CtsUrn(columns[1]), Cite2Urn(columns[2]))) 
            catch 
                @warn("Skipping line $(ln)")
            end
        end

        push!(indices, NamedEntityIndex(coll_urn, coll_label, datapairs))
    end
    indices
end


