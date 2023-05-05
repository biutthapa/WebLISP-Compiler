(module
  (memory $memory 1)
  (func $mem_read (param $offset i32) (result i32)
    (i32.load (get_local $offset)))
  (func $mem_write (param $offset i32) (param $value i32)
    (i32.store (get_local $offset) (get_local $value))))

