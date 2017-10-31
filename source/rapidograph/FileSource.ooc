import io/File
import structs/[ArrayList, HashBag]
import text/json
import Source

// get the path difference of l and r
operator - (l, r: File) -> String {
    if(!l || !r) return ""
    else if(l getAbsolutePath() == r getAbsolutePath()) return ""

    ret := (l - r parent()) + '/' + r name()
    if(ret startsWith?("/")) ret = ret substring(1)
    ret
}

FileSource: class extends Source {
    file: File
    index := 0
    files := 0

    init: func(path: String) {
        file = File new(path)
        if(file exists?() && file dir?()) {
            file walk(|_|
                files += 1
                true
            )
        } else files += 1
    }

    hasOrder?: func -> Bool {
        !file && file exists?() && index < files
    }

    getOrder: func -> (String, HashBag, String) {
        // See rock#499
        (a, b, c) := getFileOrder(file)
        (a, b, c)
    }

    getFileOrder: func (f: File, acc: SSizeT = 0) -> (String, HashBag, String) {
        if(!hasOrder?()) return (null, null, null)

        if(!f dir?()) {
            vars: HashBag = null
            path := file - f
            contents := f read()

            if(path endsWith?(".order")) {
                vars = JSON parse(contents)
                path = path[0 .. -7]
            }

            index += 1
            return (path, vars, contents)
        }

        children := f getChildren()
        for(i in 0 .. children getSize()) {
            if(acc + i >= index) {
                (a, b, c) := getFileOrder(children[i], acc + i)
                if(a != null) return (a, b, c)
            }
        }
        return (null, null, null)
    }
}
