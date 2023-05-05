(module
  ;; Define global variable for storing memory
  (global $memory (mut i32) (i32.const 0))

  ;; Define function for allocating memory
  (func $allocate_memory (param $size i32) (result i32)
    (local $ptr i32)
    (set_local $ptr (global.get $memory))
    (global.set $memory (i32.add (get_local $ptr) (get_local $size)))
    (return (get_local $ptr)))

  ;; Define function for deallocating memory
  (func $deallocate_memory (param $ptr i32)
    (global.set $memory (get_local $ptr)))

  ;; Define function for performing integer addition
  (func $add (param $a i32) (param $b i32) (result i32)
    (i32.add (get_local $a) (get_local $b)))
)
