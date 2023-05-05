(module
  ;; Push a value onto the stack
  (func $push (param $value i32)
    (local $sp i32)
    (set_local $sp (i32.load (i32.const 0)))
    (i32.store (get_local $sp) (get_local $value))
    (i32.store (i32.const 0) (i32.add (get_local $sp) 4)))

  ;; Pop a value from the stack
  (func $pop (result i32)
    (local $sp i32)
    (set_local $sp (i32.load (i32.const 0)))
    (i32.store (i32.const 0) (i32.sub (get_local $sp) 4))
    (i32.load (get_local $sp))))


;; (push (param i32) (export "push"))
;; (pop (result i32) (export "pop"))
