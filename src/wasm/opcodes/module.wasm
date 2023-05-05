(module
  ;; Define the linear memory for the program
  (memory (export "memory") 1)

  ;; Define the start function for the program
  (start $start)

  ;; Define the import for the "log" function
  (import "env" "log" (func $log (param i32) (param i32)))

  ;; Define the function to add two numbers
  (func $add (param $a i32) (param $b i32) (result i32)
    (i32.add (get_local $a) (get_local $b)))

  ;; Define the function to subtract two numbers
  (func $subtract (param $a i32) (param $b i32) (result i32)
    (i32.sub (get_local $a) (get_local $b)))

  ;; Define the function to multiply two numbers
  (func $multiply (param $a i32) (param $b i32) (result i32)
    (i32.mul (get_local $a) (get_local $b)))

  ;; Define the function to divide two numbers
  (func $divide (param $a i32) (param $b i32) (result i32)
    (i32.div_s (get_local $a) (get_local $b)))

  ;; Define the function to log a message to the console
  (func $log_message (param $message_ptr i32) (param $message_len i32)
    (call $log (get_local $message_ptr) (get_local $message_len)))

  ;; Define the function to print a string to the console
  (func $print_string (param $string_ptr i32) (param $string_len i32)
    (i32.store8 (get_global $print_buffer_ptr) $string_len)
    (i32.store (i32.add (get_global $print_buffer_ptr) 1) (get_local $string_ptr))
    (call $log (get_global $print_buffer_ptr) (i32.add (get_local $string_len) 1)))

  ;; Define the start function for the program
  (func $start
    ;; Call the "main" function
    (call $main)
    (drop))

  ;; Define the global variable to hold the buffer for printing strings
  (global $print_buffer (mut i32) (i32.const 0))
  (global $print_buffer_ptr (mut i32) (i32.const 0))
  
  ;; Define the export for the functions
  (export "add" (func $add))
  (export "subtract" (func $subtract))
  (export "multiply" (func $multiply))
  (export "divide" (func $divide))
  (export "log_message" (func $log_message))
  (export "print_string" (func $print_string))
  (export "start" (func $start)))
