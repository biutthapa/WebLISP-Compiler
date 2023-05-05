(module
  ;; Memory size
  (func $memory_size (export "memory_size") (result i32)
    (memory.size))
  
  ;; Grow memory
  (func $memory_grow (export "memory_grow") (param $pages i32) (result i32)
    (memory.grow (get_local $pages)))
  
  ;; Current timestamp in milliseconds
  (func $current_time (export "current_time") (result i64)
    (i64.const 1000)        ;; Multiply by 1000 to get milliseconds
    (i64.mul
      (i64.const 0)         ;; This is the low 32 bits of the timestamp
      (i64.const 0)         ;; This is the high 32 bits of the timestamp
      (i64.extend_u/i32     ;; Extend the i32 memory address to i64
        (i32.const 0))))    ;; Get the memory address of the timestamp
  
  ;; Get global value by index
  (func $get_global (export "get_global") (param $index i32) (result i32)
    (global.get (get_global $index)))
  
  ;; Set global value by index
  (func $set_global (export "set_global") (param $index i32) (param $value i32)
    (global.set (get_global $index) (get_local $value))))
