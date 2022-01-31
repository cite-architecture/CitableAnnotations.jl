@testset "Test basic functions on commentary" begin
    commentary = CitableCommentary([])
    
    #@test annotated(commentary) == CtsUrn
    #@test annotators(commentary) == CtsUrn
    @test annotatedtype(commentary) == CtsUrn
    @test annotatingtype(commentary) == CtsUrn
end
