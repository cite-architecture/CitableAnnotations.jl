@testset "Test basic functions on commentary" begin
    u = Cite2Urn("urn:cite2:annotations:testdata.v1:test1")
    commentary = CitableCommentary(u, "Empty test set", [])
    
    #@test annotated(commentary) == CtsUrn
    #@test annotators(commentary) == CtsUrn
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