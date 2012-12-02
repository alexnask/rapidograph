import io/File
import structs/HashBag
import text/json
import Source

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
            path := f path
            contents := f read()

            if(file path endsWith?(".order")) {
                vars = JSON parse(contents)
                path = f path[0 .. -7]
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
