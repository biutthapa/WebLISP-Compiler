package main

import (
    "syscall/js"
    "fmt"
    "io/ioutil"
    "wasm_module"
)

func main() {
    // Read the WebAssembly module file
    wasmBytes, err := ioutil.ReadFile("path/to/module.wasm")
    if err != nil {
        fmt.Printf("Error reading module file: %s\n", err)
        return
    }

    // Load the module into memory
    module, err := wasm_module.NewModule(wasmBytes)
    if err != nil {
        fmt.Printf("Error loading module: %s\n", err)
        return
    }

    // Call an exported function from the module
    result, err := module.CallExportedFunction("add", 2, 3)
    if err != nil {
        fmt.Printf("Error calling exported function: %s\n", err)
        return
    }

    fmt.Printf("Result: %d\n", result)
}
