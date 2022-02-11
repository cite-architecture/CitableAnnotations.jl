# The CitableCommentary

A `CitableCommentary` records annotations by one text on another text in pairs of `CtsUrn`s.  In general, therefore, when you use `CitableAnnotations` you'll  also want to include both `CitableBase` and `CitableText`.

```@example comm
using CitableBase, CitableText, CitableAnnotations
```

## Loading a commentary from CEX

A `CitableCommentary` can be serialized to and instantiated from a `citerelationset` block, like this example:

```@example comm
cexdata = """
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

Use the `fromcex` function (from `CitableBase`) to create a commentary.

```@example comm
citcomm = fromcex(cexdata, CitableCommentary)
```

## Metadata about a commentary

Use the generic functions applicable to any `CitableAnnotation` to see the structure of the commentary.  We can see that it consists of `CtsUrn`s commenting on other `CtsUrn`s.

```@example comm
annotatingtype(citcomm)
```

```@example comm
annotatedtype(citcomm)
```

See what texts annotate other texts and what texts are annotated (that is, the unique sets of CTS URNs, without their passage references, on each side of the relation).


```@example comm
annotators(citcomm)
```

```@example comm
annotated(citcomm)
```