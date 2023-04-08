# CitableAnnotations

The `CitableAnnotationSet` is an abstraction for a citable set of relations among pairs of URNs.  In each pair, one URN is said to *annotate* the other.


Concrete subtypes of `CitableAnnotationSet` implement:

- metadata functions 
- the `CitableTrait` functions (from `CitableBase`)
- the `CexTrait` functions  (from `CitableBase`)
- dozens of Julia's iterator and collection functions (see a partial list in the [documentation for `CitableBase`](https://cite-architecture.github.io/CitableBase.jl/stable/collections2/))


## Metadata functions

- `annotatingtype`: the type of URN used to identify annotating content
- `annotatedtype`: the type of URN used to identify the annotated content
- `annotators`:  a set of URNs identifying annotating objects 
- `annotated`: the type of URN identifying the annotating content

For example, the `CitableCommentary` models one text commenting on another. Both its `annotatingtype` and `annotatedtype` are therefore `CtsUrn`s.  Both its `annotators` and its `annotated` objects are sets of texts identified by CTS URNs (without individual passage references).

## Concrete subtypes

```@contents
Pages = ["commentary.md"]
Depth = 5
```
