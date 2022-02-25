@testset "Test basic functions on text on page" begin
    f = joinpath(pwd(), "data", "sample-texttopage.cex")
    indexes = fromcex(f, TextOnPage, FileReader)
    idx = indexes[1]
   

    
    @test annotatingtype(idx) == CtsUrn
    @test annotators(idx) == Set([CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msB:")])
    @test annotatedtype(idx) == Cite2Urn
    @test_broken annotated(idx) == Set(Cite2Urn("urn:cite2:hmt:msB.v1:1r"))
end


@testset "Test citable trait on commentary" begin
    f = joinpath(pwd(), "data", "sample-texttopage.cex")
    indexes = fromcex(f, TextOnPage, FileReader)
    idx = indexes[1]
   
    @test citabletrait(typeof(idx)) == CitableAnnotations.TextOnPageCitation()
    @test citable(idx)
    @test urn(idx) == Cite2Urn("urn:cite2:hmt:iliadindex.v1:all")
    @test label(idx) == "Index of *Iliad* lines to pages where they appear"
    @test urntype(idx) == Cite2Urn
    
end

@testset "Test Julia collection functions on commentary" begin
    f = joinpath(pwd(), "data", "sample-texttopage.cex")
    indexes = fromcex(f, TextOnPage, FileReader)
    idx = indexes[1]
   

    @test length(idx) == 10
    @test eltype(idx) == Tuple{CtsUrn, Cite2Urn}
    @test typeof(collect(idx))  <: Vector

    @test filter(pr -> pr[1] == CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msB:1.7"), idx) |> collect |> length == 1
    @test reverse(idx)[1][1] == CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msB:1.10")
   

end
