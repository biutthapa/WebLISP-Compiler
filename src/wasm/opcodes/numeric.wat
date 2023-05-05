(module
  (func $f32_add (param $a f32) (param $b f32) (result f32)
    (f32.add (get_local $a) (get_local $b)))
  (func $f32_sub (param $a f32) (param $b f32) (result f32)
    (f32.sub (get_local $a) (get_local $b)))
  (func $f32_mul (param $a f32) (param $b f32) (result f32)
    (f32.mul (get_local $a) (get_local $b)))
  (func $f32_div (param $a f32) (param $b f32) (result f32)
    (f32.div (get_local $a) (get_local $b))))

