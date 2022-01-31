# This should be in `CiteEXchange`

"""Parse header of `cexsrc` into URN and label for DSE collection.
$(SIGNATURES)
`cexsrc` should be a single `citerelationset` block.
"""
function headerinfo(cexsrc::AbstractString; delimiter = "|")
    cexblock = blocks(cexsrc, "citerelationset")[1]
    urnkv = split(cexblock.lines[1], delimiter)
    labelkv = split(cexblock.lines[2], delimiter)
    (Cite2Urn(urnkv[2]), labelkv[2])
end