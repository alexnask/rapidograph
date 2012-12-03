import io/File
import Paper

LocalPaper: class extends Paper {
    base: File

    init: func(path: String) {
        base = File new(path)
        if(!base exists?()) base mkdir()
    }

    add: func(path, contents: String) {
        file := File new(base getAbsolutePath() + '/' + path)
        while(!file parent() exists?()) {
            file parent() mkdir()
            file = file parent()
        }

        File new(base getAbsolutePath() + '/' + path) write(contents)
    }
}
