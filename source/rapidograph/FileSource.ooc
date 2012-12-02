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
    childrenSize := 0

    init: func(path: String) {
        file = File new(path)
        if(file exists?() && file dir?()) {
            file walk(|_|
                childrenSize += 1
                true
            )
        }
    }

    hasOrder?: func -> Bool {
        file exists?() && match {
            case !file dir?() => index == 0
            case => index < childrenSize
        }
    }

    getOrder: func -> (String, HashBag, String) {
        getFileOrder(file)
    }

    getFileOrder: func (f: File, acc: SSizeT = 0) -> (String, HashBag, String) {
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
                index += 1
                (a, b, c) := getFileOrder(children[i], acc + i)
                if(a != null) return (a, b, c)
            }
        }
        return (null, null, null)
    }
}
