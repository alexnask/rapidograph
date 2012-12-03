use rapidograph
import rapidograph/[FileSource, Ruler, DummyInk, LocalPaper]

// Set up a file source
// This source will send the ruler orders for the files found in the directory 'dir'
source := FileSource new("source")

ruler := Ruler new(source)
// Add a dummy ink to our ruler
ruler registerInk(DummyInk new()) // ruler inks add(DummyInk new())
// This indicates files that come from our source's 'images' directory are not to be processeced by an Ink but rather passed as-is to the paper
ruler staticLink("images/.*")
// Set up a simple link, uses PCRE patterns
ruler link(".*?/?([A-Za-z]+)\.html", "templates/<1>.html")
// Publish the whole thing locally! o/
ruler trace(LocalPaper new("deployed"))

