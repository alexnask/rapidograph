import structs/[ArrayList, HashMap]
import io/FileReader
import text/Regexp
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
        while(source hasOrder?()) {
            (path, vars, contents) := source getOrder()

            maxMatches := 0
            maxPattern: String
            data := HashMap<String, Match> new(links getSize())

            // Find the best match of the path of the order in our links
            links each(|pattern, template|
                matches := Regexp compile(pattern, RegexpOption ANCHORED | RegexpOption DOLLAR_ENDONLY) matches(path)
                data[pattern] = matches
                if(matches && maxMatches < matches groupCount) {
                    maxMatches = matches groupCount
                    maxPattern = pattern
                }
            )

            // If we do have a match
            if(maxMatches > 0) {
                if(!links[maxPattern] empty?()) {
                    // Find out what template to use
                    matches := data[maxPattern]
                    template := links[maxPattern]
                    for(i in 1 .. matches groupCount) {
                        template = template replaceAll("<%d>" format(i), matches group(i))
                    }

                    // Now search for an ink that can handle this template
                    for(ink in inks) {
                        if(ink valid?(template)) {
                            reader := FileReader new(template)
                            templateData := reader readAll()
                            reader close()

                            contents = ink draw(templateData, vars)
                            break
                        }
                    }
                }
                // Give our paper the result!
                paper add(path, contents)
            }
        }
    }
}

