# CitableAnnotations

The abstraction `CitableAnnotationSet` is a citable set of relations among a pair of URNs.  In each pair, one URN is said to *annotate* the other.

Subtypes of `CitableAnnotationSet` should:

- implement its required functions
- implement the `CitableTrait` (from `CitableBase`)
- implement the `CexTrait`  (from `CitableBase`)
- implement Julia's iterators and tables traits on the set of annotations