# The CitableCommentary

A `CitableCommentary` records annotations by one text on another text. Each text is identified by a `CtsUrn`.  In general, therefore, when you use `CitableAnnotations` you'll  also want to include both the `CitableBase` and `CitableText` package, where the `Urn` abstraction and `CtsUrn` type are defined.

```@example comm
using CitableBase, CitableText, CitableAnnotations
```

## Loading a commentary from CEX

A `CitableCommentary` can be serialized to and instantiated from CEX source that includes a `citerelationset` block and declares a data model for it.  Here is an example:

```@example comm
cexdata = """
#!datamodels
Collection|Model|Label|Description
urn:cite2:hmt:commentary.v1:all|urn:cite2:cite:datamodels.v1:commentarymodel|Relation of commentary to text passages commented on.


#!citerelationset
urn|urn:cite2:hmt:commentary.v1:all
label|Index of scholia to *Iliad* passages they comment on
scholion|iliad

urn:cts:greekLit:tlg5026.msAint.hmt:1.27|urn:cts:greekLit:tlg0012.tlg001.msA:1.8
urn:cts:greekLit:tlg5026.msAint.hmt:1.28|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.16
urn:cts:greekLit:tlg5026.msAint.hmt:1.29|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14
urn:cts:greekLit:tlg5026.msAint.hmt:1.30|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14
urn:cts:greekLit:tlg5026.msAint.hmt:1.31|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14
urn:cts:greekLit:tlg5026.msAint.hmt:1.32|urn:cts:greekLit:tlg0012.tlg001.msA:1.20
urn:cts:greekLit:tlg5026.msAint.hmt:1.55|urn:cts:greekLit:tlg0012.tlg001.msA:1.30
urn:cts:greekLit:tlg5026.msAint.hmt:1.56|urn:cts:greekLit:tlg0012.tlg001.msA:1.39
urn:cts:greekLit:tlg5026.msAint.hmt:1.57|urn:cts:greekLit:tlg0012.tlg001.msA:1.41
"""
```

Use the `fromcex` function (from `CitableBase`) to create a Vector of `CitableCommentary` objects.  In this example, we already know our CEX only has one commentary, so we'll take the first element from the Vector.

```@example comm
citcomm = fromcex(cexdata, CitableCommentary)[1]
```


##  A citable object

A commentary satisfies the definition of a citable object in `CitableBase`, as you can verify with the `citable` function:

```@example comm
citable(citcomm)
```

This means it has a human-readable label, and is identified by a URN of a specified type.

```@example comm
label(citcomm)
```

```@example comm
urntype(citcomm)
```


```@example comm
urn(citcomm)
```

!!! note 

    Note that the URN identifies the *set of relations as a group*, not individual annotations within the set.

## Metadata about a commentary

Use the generic functions applicable to any `CitableAnnotation` to see the structure of the commentary.  We can see that it consists of `CtsUrn`s commenting on other `CtsUrn`s.

```@example comm
annotatingtype(citcomm)
```

```@example comm
annotatedtype(citcomm)
```

Find what texts annotate other texts and what texts are annotated (that is, find the unique sets of CTS URNs, without their passage references, on each side of the relation).  In this small example, a single annotating document (interior scholia from the Venetus A manuscript, `urn:cts:greekLit:tlg5026.msAint.hmt:`) comments on a single annotated document (the *Iliad*, `urn:cts:greekLit:tlg0012.tlg001.msA:`).


```@example comm
annotators(citcomm)
```

```@example comm
annotated(citcomm)
```



## Working with a commentary

You can use the `CitableCommentary` type with dozens of generic Julia functions.  Here are examples of a few commonly used functions.

!!! note "For more information"

    The documentation for `CitableBase` includes a [list of several dozen functions](https://cite-architecture.github.io/CitableBase.jl/stable/collections2/) that are available to use with citable collections, including `CitableCommentary`.  




The number of annotations in your commentary:

```@example comm
length(citcomm)
```

The structure in Julia for an individual comment is a `Tuple` of `CtsUrn`s:

```@example comm
eltype(citcomm)
```


Find what *Iliad* passages are annotated with the `map` function.

```@example comm
map(pr -> passagecomponent(pr[2]), citcomm)
```

Find what annotations that comment on a range of *Iliad* with the `filter` function.  Filtering a commentary returns an *iterator*; we'll collect the results here.

```@example comm
filter(pr -> isrange(pr[2]), citcomm) |> collect
```

Iterate through the commentary to pair scholia commenting on a range of *Iliad* lines with the first line they comment on.


```@example comm
rangecomments = []
for comment in citcomm
    if isrange(comment[2])
        push!(rangecomments, (comment[1], range_begin(comment[2])))
    end
end
rangecomments
```