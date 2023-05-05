(module
  (func $i32_add (param $a i32) (param $b i32) (result i32)
    (i32.add (get_local $a) (get_local $b)))
  (func $i32_sub (param $a i32) (param $b i32) (result i32)
    (i32.sub (get_local $a) (get_local $b)))
  (func $i32_mul (param $a i32) (param $b i32) (result i32)
    (i32.mul (get_local $a) (get_local $b)))
  (func $i32_div (param $a i32) (param $b i32) (result i32)
    (i32.div_s (get_local $a) (get_local $b))))

