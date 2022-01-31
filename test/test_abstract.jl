@testset "Test default for required functions" begin
    struct DummyAnnotationSet <: AbstractAnnotationSet end
    dummy = DummyAnnotationSet()

    @test_throws ArgumentError annotated(dummy)
    @test_throws ArgumentError annotators(dummy)
    @test_throws ArgumentError annotatedtype(dummy)
    @test_throws ArgumentError annotatingtype(dummy)
end