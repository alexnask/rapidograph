import structs/HashBag
import Ink

DummyInk: class extends Ink {
    valid?: func -> Bool { true }
    draw: func (template: String, vars: HashBag) -> String { template }
}
