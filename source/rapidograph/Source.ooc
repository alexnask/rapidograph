import structs/HashBag

Source: abstract class {
    hasOrder?: abstract func -> Bool
                              //path, vars, contents
    getOrder: abstract func -> (String, HashBag, String)
}
