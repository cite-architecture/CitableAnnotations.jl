# This should be in `CiteEXchange`?

"""Parse header of `cexsrc` into URN and label for DSE collection.
$(SIGNATURES)
`cexsrc` should be a single `citerelationset` block.
"""
function headerinfo(cexsrc::AbstractString; delimiter = "|")
    cexblocks = blocks(cexsrc, "citerelationset")
    if length(cexblocks) == 1  
        headerinfo(cexblocks[1], delimiter = delimiter) 
    else
        @error("headerinfo: CEX source had $(length(cexblocks)) blocks for citerelationset.")
    end
end


function headerinfo(blk::Block; delimiter = "|")
    urnkv = split(blk.lines[1], delimiter)
    labelkv = split(blk.lines[2], delimiter)
    (Cite2Urn(urnkv[2]), labelkv[2])
end
