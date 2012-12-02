import io/File
import Paper

LocalPaper: class extends Paper {
    base: File

    init: func(path: String) {
        base = File new(path)
        if(!base exists?()) base mkdir()
    }

    add: func(path, contents: String) {
        File new(base getAbsolutePath() + '/' + path) write(contents)
    }
}
