import structs/HashBag

Ink: abstract class {
    draw: abstract func (template: String, variables: HashBag) -> String
    valid?: abstract func (path: String) -> Bool
}
