@testset "Test basic functions on commentary" begin
    u = Cite2Urn("urn:cite2:annotations:testdata.v1:test1")
    commentary = CitableCommentary(u, "Empty test set", [])

    @test annotatedtype(commentary) == CtsUrn
    @test annotatingtype(commentary) == CtsUrn
end


@testset "Test citable trait on commentary" begin
    u = Cite2Urn("urn:cite2:annotations:testdata.v1:test1")
    commentary = CitableCommentary(u, "Empty test set", [])

    @test citabletrait(typeof(commentary)) == CitableAnnotations.CommentaryCitation()
    @test citable(commentary)
    @test urn(commentary) == u
    @test label(commentary) == "Empty test set"
    @test urntype(commentary) == Cite2Urn
    
end

@testset "Test Julia collection functions on commentary" begin
    f = joinpath(pwd(), "data", "sample-commentary.cex") 
    c = fromcex(f, CitableCommentary, FileReader)
    @test length(c) == 9
    @test eltype(c) == Tuple{CtsUrn, CtsUrn}
    @test typeof(collect(c))  <: Vector
    @test filter(pr -> CitableText.isrange(pr[2]), c) |> collect |> length == 4
    @test reverse(c)[1][1] == CtsUrn("urn:cts:greekLit:tlg5026.msAint.hmt:1.57")
   

end