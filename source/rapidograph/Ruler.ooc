import structs/[ArrayList, HashMap]
import Source, Ink, Paper

Ruler: class {
    source: Source
    inks := ArrayList<Ink> new()
    links := HashMap<String, String> new()

    init: func (=source)

    registerInk: func(ink: Ink) {
        inks add(ink)
    }

    link: func(sourcePath, templatePath: String) {
        links[sourcePath] = templatePath
    }

    staticLink: func(path: String) {
        link(path, "")
    }

    trace: func(paper: Paper) {
    }
}

