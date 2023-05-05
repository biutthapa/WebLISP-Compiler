(module
  ;; Constants
  (global $i32_0 (export "i32_0") (mut i32) (i32.const 0))
  (global $i32_1 (export "i32_1") (mut i32) (i32.const 1))
  (global $i32_2 (export "i32_2") (mut i32) (i32.const 2))
  (global $f32_0 (export "f32_0") (mut f32) (f32.const 0))
  (global $f32_1 (export "f32_1") (mut f32) (f32.const 1))
  (global $f32_2 (export "f32_2") (mut f32) (f32.const 2))

  ;; Arithmetic instructions
  (func $add_i32 (export "add_i32") (param $a i32) (param $b i32) (result i32)
    (i32.add (get_local $a) (get_local $b)))
  (func $sub_i32 (export "sub_i32") (param $a i32) (param $b i32) (result i32)
    (i32.sub (get_local $a) (get_local $b)))
  (func $mul_i32 (export "mul_i32") (param $a i32) (param $b i32) (result i32)
    (i32.mul (get_local $a) (get_local $b)))
  (func $div_s_i32 (export "div_s_i32") (param $a i32) (param $b i32) (result i32)
    (i32.div_s (get_local $a) (get_local $b)))
  (func $div_u_i32 (export "div_u_i32") (param $a i32) (param $b i32) (result i32)
    (i32.div_u (get_local $a) (get_local $b)))
  (func $rem_s_i32 (export "rem_s_i32") (param $a i32) (param $b i32) (result i32)
    (i32.rem_s (get_local $a) (get_local $b)))
  (func $rem_u_i32 (export "rem_u_i32") (param $a i32) (param $b i32) (result i32)
    (i32.rem_u (get_local $a) (get_local $b)))
  (func $add_f32 (export "add_f32") (param $a f32) (param $b f32) (result f32)
    (f32.add (get_local $a) (get_local $b)))
  (func $sub_f32 (export "sub_f32") (param $a f32) (param $b f32) (result f32)
    (f32.sub (get_local $a) (get_local $b)))
  (func $mul_f32 (export "mul_f32") (param $a f32) (param $b f32) (result f32)
    (f32.mul (get_local $a) (get_local $b)))
  ;; Floating-point comparisons
  (func $eq_f32 (export "eq_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.eq (get_local $a) (get_local $b))))
  (func $ne_f32 (export "ne_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.ne (get_local $a) (get_local $b))))
  (func $lt_f32 (export "lt_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.lt (get_local $a) (get_local $b))))
  (func $le_f32 (export "le_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.le (get_local $a) (get_local $b))))
  (func $gt_f32 (export "gt_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.gt (get_local $a) (get_local $b))))
  (func $ge_f32 (export "ge_f32") (param $a f32) (param $b f32) (result i32)
    (i32.wrap/i64 (f32.ge (get_local $a) (get_local $b))))

  ;; Conversion instructions
  (func $i32_to_f32 (export "i32_to_f32") (param $a i32) (result f32)
    (f32.convert_s/i32 (get_local $a)))
  (func $f32_to_i32_s (export "f32_to_i32_s") (param $a f32) (result i32)
    (i32.wrap/i64 (f32.convert_s/i32 (get_local $a))))
  (func $f32_to_i32_u (export "f32_to_i32_u") (param $a f32) (result i32)
    (i32.wrap/i64 (f32.convert_u/i32 (get_local $a))))

  ;; Logical instructions
  (func $and_i32 (export "and_i32") (param $a i32) (param $b i32) (result i32)
    (i32.and (get_local $a) (get_local $b)))
  (func $or_i32 (export "or_i32") (param $a i32) (param $b i32) (result i32)
    (i32.or (get_local $a) (get_local $b)))
  (func $xor_i32 (export "xor_i32") (param $a i32) (param $b i32) (result i32)
    (i32.xor (get_local $a) (get_local $b)))
  (func $not_i32 (export "not_i32") (param $a i32) (result i32)
    (i32.xor (get_local $a) (i32.const -1)))

  ;; Control instructions
  (func $unreachable (export "unreachable") (unreachable))
  (func $nop (export "nop"))
  (func $block (export "block") (param $result i32) (result i32)
  (block
    (result (get_local $result))
    (i32.const 42)))
  (func $loop (export "loop") (result i32)
    (loop
      (br_if 0 (i32.const 0))
      (br 1))
    (i32.const 42))
  (func $if_then (export "if_then") (param $cond i32) (result i32)
    (if (get_local $cond)
      (then
        (i32.const 42))))
  
  (func $if_else (export "if_else") (param $cond i32) (result i32)
    (if (get_local $cond)
      (then
        (i32.const 42))
      (else
        (i32.const 0)))))

    
    
    
    
    
    
    
    
    
    
