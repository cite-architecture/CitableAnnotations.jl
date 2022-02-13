"Passages of text annotating (appearing) on a physical surface like a page."
struct TextOnPage <: AbstractAnnotationSet
    urn::Cite2Urn
    label::AbstractString
    data::Vector{Tuple{CtsUrn, Cite2Urn}}
end

"""Override `show` for `TextOnPage`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, idx::TextOnPage)
    print(io, idx.urn, " ", idx.label)
end

"""Override `==` for `CitableCommentary`
$(SIGNATURES)
"""
function ==( idx1::TextOnPage,  idx2::TextOnPage)
    idx1.urn.urn == idx2.urn.urn && 
    idx1.label == idx2.label && 
    idx1.data == idx2.data
end

"""Find unique set of pages.
$(SIGNATURES)
"""
function annotated(idx::TextOnPage)
    map(t -> (t[2]), idx.data) |> Set
end

"""Find unique set of texts appearing on pages.
$(SIGNATURES)
URNs identify versions or exemplars of texts without passage references.
"""
function annotators(idx::TextOnPage)
    map(t -> droppassage(t[1]), idx.data) |> Set
end

"""In `TextOnPage` annotations, texts are identifed by `CtsUrn`.
$(SIGNATURES)
"""
function annotatingtype(idx::TextOnPage)
    CtsUrn
end

"""In `TextOnPage` annotations`, annotated pages are identifed by `Cite2Urn`.
$(SIGNATURES)
"""
function annotatedtype(idx::TextOnPage)
    Cite2Urn
end

"Define singleton type to use as value of `CitableTrait` on `CitableCommentary`."
struct TextOnPageCitation <: CitableTrait end
"""Set value of `CitableTrait` for `TextOnPage`.
$(SIGNATURES)
"""
function citabletrait(::Type{TextOnPage})
    TextOnPageCitation()
end

"""Type of URN identifying `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(idx::TextOnPage)
    Cite2Urn
end


"""URN identifying `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(idx::TextOnPage)
    idx.urn
end

"""Label for `comm`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(idx::TextOnPage)
    idx.label
end


"Singleton type for value of `CexTrait`"
struct TextOnPageCex <: CexTrait end
"""Set value of `CexTrait` for `TextOnPage`
$(SIGNATURES)
"""
function cextrait(::Type{TextOnPage})
    TextOnPageCex()
end



"""Format `TextOnPage` annotations as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(idx::TextOnPage; delimiter = "|")
    dmlines = [
        "#!datamodels",
    "Collection$(delimiter)Model$(delimiter)Label$(delimiter)Description",
    "$(urn(idx))$(delimiter)$(string(TEXT_ON_PAGE_MODEL))$(delimiter)$(idx.label)"
    ]

    lines = ["#!citerelationset",
        "urn$(delimiter)$(urn(idx))",
        "label$(delimiter)$(label(idx))",
        "",
        "annotator$(delimiter)annotated"
    ]
    for pr in idx.data
        push!(lines, string(pr[1]) * delimiter * string(pr[2]))
    end
    join(dmlines, "\n") * "\n\n" * join(lines, "\n")
end




"""Parse a delimited-text string into `TextOnPage` annotations.
$(SIGNATURES)

`cexsrc` should be a single `citerelationset` block.
"""
function fromcex(trait::TextOnPageCex, cexsrc::AbstractString, ::Type{TextOnPage}; 
    delimiter = "|", configuration = nothing, strict = true)
    if strict
        @warn("Parse CEX for TextOnPage strictly")
        parsetextonpagecex(cexsrc, delimiter = delimiter)
    else
        (coll_urn, coll_label) = headerinfo(cexsrc, delimiter = delimiter)
        [readtextpageblock(cexsrc, coll_urn, coll_label, delimiter = delimiter)]
    end
end


"""Create instances of `TextOnPage` relation from `cexsrc` by consulting the
`datamodels` blocks of the CEX data and filtering content 
of `citedata` blocks for matching collections.
$(SIGNATURES)
"""
function parsetextonpagecex(cexsrc::AbstractString; delimiter = "|")
    dms = data(cexsrc, "datamodels")
    @warn("DMs in CEX", length(dms))
    relationseturns = Cite2Urn[]
    for dm in dms
        @warn("data model", dm)
        cols = split(dm, delimiter)
        if Cite2Urn(cols[2]) == TEXT_ON_PAGE_MODEL
            push!(relationseturns, Cite2Urn(cols[1]))
        end
    end
    @warn("Relation set urns", relationseturns)
    datablocks = blocks(cexsrc, "citerelationset")
    relationsets = TextOnPage[]
    for db in datablocks
        @warn("Relatoin urn",relationurn(db))
        try
            refurn = Cite2Urn(relationurn(db))
            @warn("check refurn/relationseturns", refurn, relationseturns)
            if refurn in relationseturns
                @debug("Woot! save block with URN ", refurn)
                textonpage = readtextpageblock(db)
                @debug("Parsing yielded", textonpage)
                push!(relationsets, textonpage)
            else
                @warn("$(refurn) not in $(relationseturns)")
            end
            
        catch e
            @warn(e)
            # Collection not in configured list
        end
    end
    relationsets
end


function readtextpageblock(cexsrc::AbstractString, curn::Cite2Urn, clabel::AbstractString; delimiter = "|")
    readtextpageblock(blocks(cexsrc, "citerelationset")[1], curn, clabel, delimiter = delimiter)
end


"""Parse a single `citedata` block into a =`TextOnPage` relation set.
$(SIGNATURES)
"""
function readtextpageblock(b::Block, curn::Cite2Urn, clabel::AbstractString; delimiter = "|")
    datapairs = []
    for ln in b.lines[4:end]
        columns = split(ln, delimiter)
        push!(datapairs, (CtsUrn(columns[1]), Cite2Urn(columns[2]))) 
    end
    TextOnPage(curn, clabel, datapairs)
end




"""Number of annotations in `idx`.
$(SIGNATURES)
"""
function length(idx::TextOnPage)
    length(idx.data)
end


	
"""A `TextOnPage` annotation joins a `CtsUrn` and a `Cite2Urn`.
$(SIGNATURES)
"""
function eltype(idx::TextOnPage)
    Tuple{CtsUrn, Cite2Urn}
end

"""Initial state of iterator for `TextOnPage` annotations.
$(SIGNATURES)
"""
function iterate(idx::TextOnPage)
    isempty(idx.data) ? nothing : (idx.data[1], 2)
end

"""Iterate a `Codex` with array index at `state`.
$(SIGNATURES)
"""
function iterate(idx::TextOnPage, state)
    state > length(idx.data) ? nothing : (idx.data[state], state + 1)
end

"""Filter the entries in a `TextOnPage` annotation.
$(SIGNATURES)
"""
function filter(f, idx::TextOnPage)
     Iterators.filter(f, collect(idx))
end

"""Reverse the order of `TextOnPage` annotations.
$(SIGNATURES)
"""
function reverse(idx::TextOnPage)
    reverse(idx.data)
end




###

function relationurn(relationblock::Block; delimiter = "|")
    cols = split(relationblock.lines[1], delimiter)
    cols[2]
end

"""Map column labels to column numbers
$(SIGNATURES)
"""
function columndict(b::Block; delimiter = "|")
    hdr = b.lines[1]
    cols = split(hdr, delimiter)
    orderdict = Dict()
    for i in 1:length(cols)
        orderdict[lowercase(cols[i])] = i
    end
    orderdict
end
