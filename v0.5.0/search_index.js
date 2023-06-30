var documenterSearchIndex = {"docs":
[{"location":"apis/#API-Documentation","page":"API documentation","title":"API Documentation","text":"","category":"section"},{"location":"apis/#Type-hierarchy","page":"API documentation","title":"Type hierarchy","text":"","category":"section"},{"location":"apis/","page":"API documentation","title":"API documentation","text":"AbstractAnnotationSet\nCitableCommentary","category":"page"},{"location":"apis/#CitableAnnotations.AbstractAnnotationSet","page":"API documentation","title":"CitableAnnotations.AbstractAnnotationSet","text":"Abstract type for a citable annotation.\n\n\n\n\n\n","category":"type"},{"location":"apis/#CitableAnnotations.CitableCommentary","page":"API documentation","title":"CitableAnnotations.CitableCommentary","text":"Annotations by one text on another text.\n\n\n\n\n\n","category":"type"},{"location":"apis/#Metadata-about-annotation-sets","page":"API documentation","title":"Metadata about annotation sets","text":"","category":"section"},{"location":"apis/","page":"API documentation","title":"API documentation","text":"annotatedtype\nannotatingtype \nannotated\nannotators","category":"page"},{"location":"apis/#CitableAnnotations.annotatedtype","page":"API documentation","title":"CitableAnnotations.annotatedtype","text":"Find Julia type of annotated objects.\n\nannotatedtype(anns)\n\n\n\n\n\n\nIn a CitableCommentary, texts commented on are identifed by CtsUrn.\n\nannotatedtype(comm)\n\n\n\n\n\n\nIn TextOnPage annotations, annotated pages are identifed byCite2Urn`.\n\nannotatedtype(idx)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitableAnnotations.annotatingtype","page":"API documentation","title":"CitableAnnotations.annotatingtype","text":"Find Julia type of annotating source.\n\nannotatingtype(anns)\n\n\n\n\n\n\nIn a CitableCommentary, commenting texts are identifed by CtsUrn.\n\nannotatingtype(comm)\n\n\n\n\n\n\nIn TextOnPage annotations, texts are identifed by CtsUrn.\n\nannotatingtype(idx)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitableAnnotations.annotated","page":"API documentation","title":"CitableAnnotations.annotated","text":"Find unique list of annotated objects.\n\nannotated(anns)\n\n\n\n\n\n\nFind unique set of texts commented on.\n\nannotated(comm)\n\n\nURNs identify versions or exemplars of texts without passage references.\n\n\n\n\n\nFind unique set of pages.\n\nannotated(idx)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitableAnnotations.annotators","page":"API documentation","title":"CitableAnnotations.annotators","text":"Find unique list of annotating sources.\n\nannotators(anns)\n\n\n\n\n\n\nFind unique set of texts commenting on other texts.\n\nannotators(comm)\n\n\nURNs identify versions or exemplars of texts without passage references.\n\n\n\n\n\nFind unique set of texts appearing on pages.\n\nannotators(idx)\n\n\nURNs identify versions or exemplars of texts without passage references.\n\n\n\n\n\n","category":"function"},{"location":"commentary/#The-CitableCommentary","page":"Commentary","title":"The CitableCommentary","text":"","category":"section"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"A CitableCommentary records annotations by one text on another text. Each text is identified by a CtsUrn.  In general, therefore, when you use CitableAnnotations you'll  also want to include both the CitableBase and CitableText package, where the Urn abstraction and CtsUrn type are defined.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"using CitableBase, CitableText, CitableAnnotations","category":"page"},{"location":"commentary/#Loading-a-commentary-from-CEX","page":"Commentary","title":"Loading a commentary from CEX","text":"","category":"section"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"A CitableCommentary can be serialized to and instantiated from CEX source that includes a citerelationset block and declares a data model for it.  Here is an example:","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"cexdata = \"\"\"\n#!datamodels\nCollection|Model|Label|Description\nurn:cite2:hmt:commentary.v1:all|urn:cite2:cite:datamodels.v1:commentarymodel|Relation of commentary to text passages commented on.\n\n\n#!citerelationset\nurn|urn:cite2:hmt:commentary.v1:all\nlabel|Index of scholia to *Iliad* passages they comment on\nscholion|iliad\n\nurn:cts:greekLit:tlg5026.msAint.hmt:1.27|urn:cts:greekLit:tlg0012.tlg001.msA:1.8\nurn:cts:greekLit:tlg5026.msAint.hmt:1.28|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.16\nurn:cts:greekLit:tlg5026.msAint.hmt:1.29|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14\nurn:cts:greekLit:tlg5026.msAint.hmt:1.30|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14\nurn:cts:greekLit:tlg5026.msAint.hmt:1.31|urn:cts:greekLit:tlg0012.tlg001.msA:1.13-1.14\nurn:cts:greekLit:tlg5026.msAint.hmt:1.32|urn:cts:greekLit:tlg0012.tlg001.msA:1.20\nurn:cts:greekLit:tlg5026.msAint.hmt:1.55|urn:cts:greekLit:tlg0012.tlg001.msA:1.30\nurn:cts:greekLit:tlg5026.msAint.hmt:1.56|urn:cts:greekLit:tlg0012.tlg001.msA:1.39\nurn:cts:greekLit:tlg5026.msAint.hmt:1.57|urn:cts:greekLit:tlg0012.tlg001.msA:1.41\n\"\"\"","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Use the fromcex function (from CitableBase) to create a Vector of CitableCommentary objects.  In this example, we already know our CEX only has one commentary, so we'll take the first element from the Vector.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"citcomm = fromcex(cexdata, CitableCommentary)[1]","category":"page"},{"location":"commentary/#A-citable-object","page":"Commentary","title":"A citable object","text":"","category":"section"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"A commentary satisfies the definition of a citable object in CitableBase, as you can verify with the citable function:","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"citable(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"This means it has a human-readable label, and is identified by a URN of a specified type.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"label(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"urntype(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"urn(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"note: Note\nNote that the URN identifies the set of relations as a group, not individual annotations within the set.","category":"page"},{"location":"commentary/#Metadata-about-a-commentary","page":"Commentary","title":"Metadata about a commentary","text":"","category":"section"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Use the generic functions applicable to any CitableAnnotation to see the structure of the commentary.  We can see that it consists of CtsUrns commenting on other CtsUrns.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"annotatingtype(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"annotatedtype(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Find what texts annotate other texts and what texts are annotated (that is, find the unique sets of CTS URNs, without their passage references, on each side of the relation).  In this small example, a single annotating document (interior scholia from the Venetus A manuscript, urn:cts:greekLit:tlg5026.msAint.hmt:) comments on a single annotated document (the Iliad, urn:cts:greekLit:tlg0012.tlg001.msA:).","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"annotators(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"annotated(citcomm)","category":"page"},{"location":"commentary/#Working-with-a-commentary","page":"Commentary","title":"Working with a commentary","text":"","category":"section"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"You can use the CitableCommentary type with dozens of generic Julia functions.  Here are examples of a few commonly used functions.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"note: For more information\nThe documentation for CitableBase includes a list of several dozen functions that are available to use with citable collections, including CitableCommentary.  ","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"The number of annotations in your commentary:","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"length(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"The structure in Julia for an individual comment is a Tuple of CtsUrns:","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"eltype(citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Find what Iliad passages are annotated with the map function.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"map(pr -> passagecomponent(pr[2]), citcomm)","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Find what annotations that comment on a range of Iliad with the filter function.  Filtering a commentary returns an iterator; we'll collect the results here.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"filter(pr -> isrange(pr[2]), citcomm) |> collect","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"Iterate through the commentary to pair scholia commenting on a range of Iliad lines with the first line they comment on.","category":"page"},{"location":"commentary/","page":"Commentary","title":"Commentary","text":"rangecomments = []\nfor comment in citcomm\n    if isrange(comment[2])\n        push!(rangecomments, (comment[1], range_begin(comment[2])))\n    end\nend\nrangecomments","category":"page"},{"location":"#CitableAnnotations","page":"Home","title":"CitableAnnotations","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The CitableAnnotationSet is an abstraction for a citable set of relations among pairs of URNs.  In each pair, one URN is said to annotate the other.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Concrete subtypes of CitableAnnotationSet implement:","category":"page"},{"location":"","page":"Home","title":"Home","text":"metadata functions \nthe CitableTrait functions (from CitableBase)\nthe CexTrait functions  (from CitableBase)\ndozens of Julia's iterator and collection functions (see a partial list in the documentation for CitableBase)","category":"page"},{"location":"#Metadata-functions","page":"Home","title":"Metadata functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"annotatingtype: the type of URN used to identify annotating content\nannotatedtype: the type of URN used to identify the annotated content\nannotators:  a set of URNs identifying annotating objects \nannotated: the type of URN identifying the annotating content","category":"page"},{"location":"","page":"Home","title":"Home","text":"For example, the CitableCommentary models one text commenting on another. Both its annotatingtype and annotatedtype are therefore CtsUrns.  Both its annotators and its annotated objects are sets of texts identified by CTS URNs (without individual passage references).","category":"page"},{"location":"#Concrete-subtypes","page":"Home","title":"Concrete subtypes","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"commentary.md\"]\nDepth = 5","category":"page"}]
}
