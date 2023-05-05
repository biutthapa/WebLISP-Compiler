package wasm_module

import (
    "syscall/js"
)

type Module struct {
    instance js.Value
}

func NewModule(wasmBytes []byte) (*Module, error) {
    // Load the WebAssembly module
    wasmModule, err := js.Global().Get("WebAssembly").Call("instantiate", wasmBytes)
    if err != nil {
        return nil, err
    }

    // Create a Go wrapper around the WebAssembly instance
    module := &Module{
        instance: wasmModule.Get("instance"),
    }

    return module, nil
}

func (m *Module) CallExportedFunction(name string, args ...interface{}) (interface{}, error) {
    // Get the exported function from the module
    fn := m.instance.Get(name)

    // Call the function with the provided arguments
    result := fn.Invoke(args...)

    // Convert the result to a Go value
    value, err := jsToGo(result)
    if err != nil {
        return nil, err
    }

    return value, nil
}

func jsToGo(jsValue js.Value) (interface{}, error) {
    // TODO: Implement conversion from JavaScript values to Go values
    return nil, nil
}
