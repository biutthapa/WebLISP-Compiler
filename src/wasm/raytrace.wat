(module
  ;; Define memory section with initial and maximum sizes
  (memory 1 1)

  ;; Define global variables for the scene
  (global $camera (mut f32))
  (global $objects (mut i32))
  (global $lights (mut i32))

  ;; Define function for raytracing a single pixel
  (func $trace_pixel (param $x i32) (param $y i32)
    (result i32)

    ;; Calculate ray direction from camera position and pixel coordinates
    local.get $camera
    f32.const 0
    f32.load offset=0
    local.get $camera
    f32.const 4
    f32.load offset=0
    f32.const 0
    f32.load offset=0
    f32.sub
    f32.sub
    f32.const 2
    f32.div
    local.get $camera
    f32.const 8
    f32.load offset=0
    f32.const 0
    f32.load offset=0
    f32.const 0
    f32.load offset=0
    f32.sub
    f32.sub
    f32.const 2
    f32.div

    ;; Iterate over objects in the scene to find closest intersection
    local.get $objects
    i32.const 0
    i32.load offset=0
    local.set $closest_distance
    local.set $closest_object
    local.get $objects
    i32.const 4
    i32.load offset=0
    i32.const 0
    i32.add
    local.set $num_objects
    i32.const 0
    local.set $i
    block $loop
      local.get $i
      local.get $num_objects
      i32.lt_u
      br_if 1
      local.get $i
      i32.const 4
      i32.mul
      local.get $objects
      i32.const 8
      i32.add
      i32.load offset=0
      local.get $camera
      local.get $ray_direction
      call $intersect_object
      local.get $result
      f32.const 0
      f32.gt
      br_if 1
      local.get $result
      local.get $closest_distance
      f32.lt
      br_if 1
      local.get $result
      local.set $closest_distance
      local.get $i
      i32.const 4
      i32.mul
      local.get $objects
      i32.const 8
      i32.add
      i32.load offset=0
      local.set $closest_object
      local.get $result
      local.set $intersection
      local.get $ray_direction
      call $shade_pixel
      local.get $result
      return
      local.get $i
      i32.const 1
      i32.add
      local.set $i
      br $loop
    end)

  ;; Define function for intersecting a ray with an object
  (func $intersect_object (param $object i32) (param $ray_direction f32) (result f32)
    (f32.const 0))

  ;; Define function for shading a pixel based on intersection data
  (func $shade_pixel (param $object i32) (param $ray_direction f32) (param $intersection f32) (result i32)
    (i32.const 0))

;; default color is black

;; Compute normal vector at intersection point
(local $normal f32)
(local $normal_x f32)
(local $normal_y f32)
(local $normal_z f32)
(call $compute_normal (get_global $objects) (get_local $object) (get_local $intersection) (set_local $normal_x) (set_local $normal_y) (set_local $normal_z))
(f32.sqrt (f32.add (f32.add (f32.mul $normal_x $normal_x) (f32.mul $normal_y $normal_y)) (f32.mul $normal_z $normal_z))) ;; get length of normal vector
(set_local $normal (f32.div (f32.sub (f32.const 1) (f32.mul (f32.const 2) (f32.mul $normal_x $ray_direction))) (get_local $normal)))

;; Compute lighting contribution
(local $light f32)
(local $light_x f32)
(local $light_y f32)
(local $light_z f32)
(call $compute_lighting (get_global $lights) (get_local $objects) (get_local $object) (get_local $intersection) (set_local $light_x) (set_local $light_y) (set_local $light_z))
(f32.add (f32.add (f32.mul (get_local $light_x) (f32.const 0.8)) (f32.mul (get_local $light_y) (f32.const 0.8))) (f32.mul (get_local $light_z) (f32.const 0.4))) ;; scale and sum RGB values

;; Combine color and lighting
(i32.or
(i32.shl (i32.trunc_s/f32 (f32.mul (f32.const 255) (get_local $light))) 16)
(i32.shl (i32.trunc_s/f32 (f32.mul (f32.const 255) (get_local $light))) 8)
(i32.trunc_s/f32 (f32.mul (f32.const 255) (get_local $light)))))


(func $trace_ray
  (param $ray_ptr i32)
  (result i32)
  (local $min_dist f32)
  (local $hit_id i32)
  (set_local $min_dist 1.0e+30)
  (set_local $hit_id -1)
  
  ;; Iterate over all objects in the scene
  (loop $objects_loop
    (br_if $end_objects_loop (i32.eqz (get_local $objects)))
    (set_local $object_ptr (get_local $objects))
    (set_local $objects (i32.add (get_local $objects) 4))
    
    ;; Compute the distance from the ray to the object
    (set_local $dist (call $compute_dist $ray_ptr $object_ptr))
    
    ;; Check if this is the closest object so far
    (if (f32.lt (get_local $dist) (get_local $min_dist))
      (then
        (set_local $min_dist (get_local $dist))
        (set_local $hit_id (get_local $object_ptr)))
      (nop))
    
    ;; Continue to the next object
    (br $objects_loop))
  
  ;; Return the ID of the closest object that the ray intersects with
  (get_local $hit_id))

(func $compute_dist
  (param $ray_ptr i32)
  (param $object_ptr i32)
  (result f32)
  (local $t0 f32)
  (local $t1 f32)
  (local $t2 f32)
  (local $t3 f32)
  (local $t4 f32)
  (local $t5 f32)
  (local $t6 f32)
  (local $t7 f32)
  (local $t8 f32)
  (local $t9 f32)
  
  ;; Compute the ray's direction vector and position
  (set_local $ray_origin (get_local $ray_ptr))
  (set_local $ray_dir (i32.add (get_local $ray_ptr) 12))
  (set_local $ray_dir_x (f32.load (get_local $ray_dir)))
  (set_local $ray_dir_y (f32.load (i32.add (get_local $ray_dir) 4)))
  (set_local $ray_dir_z (f32.load (i32.add (get_local $ray_dir) 8)))
  (set_local $ray_pos_x (f32.load (get_local $ray_origin)))
  (set_local $ray_pos_y (f32.load (i32.add (get_local $ray_origin) 4)))
  (set_local $ray_pos_z (f32.load (i32.add (get_local $ray_origin) 8)))
  
  ;; Compute the object's position and radius
  (set_local $object_pos (get_local $object_ptr))
  (set_local $object_radius (f32.load (i32.add (get_local $object_ptr) 12)))
  (set_local $object_pos_x (f32.load (get_local $object_pos)))
  (set_local $object_pos_y (f32.load (i32.add (get_local $object_pos) 4)))
  (set_local $object_pos_z (f32.load (i32.add (get_local $object_pos) 8)))
  
  ;; Compute the vector from the ray's position to the object's position
  (set_local $object_pos (get_local $object_ptr))
  (set_local $object_radius (f32.load (i32.add (get_local $object_ptr) 12)))
  (set_local $object_pos_x (f32.load (get_local $object_pos)))
  (set_local $object_pos_y (f32.load (i32.add (get_local $object_pos) 4)))
  (set_local $object_pos_z (f32.load (i32.add (get_local $object_pos) 8)))

  ;; Compute the vector from the ray's position to the object's position
  (set_local $to_object_x (f32.sub $object_pos_x (get_local $ray_pos_x)))
  (set_local $to_object_y (f32.sub $object_pos_y (get_local $ray_pos_y)))
  (set_local $to_object_z (f32.sub $object_pos_z (get_local $ray_pos_z)))

  ;; Compute the dot product of the to-object vector with the ray direction vector
  (set_local $dot_product (f32.add (f32.add (f32.mul $ray_dir_x $to_object_x) (f32.mul $ray_dir_y $to_object_y)) (f32.mul $ray_dir_z $to_object_z)))

  ;; Compute the length of the to-object vector
  (set_local $to_object_length (f32.sqrt (f32.add (f32.add (f32.mul $to_object_x $to_object_x) (f32.mul $to_object_y $to_object_y)) (f32.mul $to_object_z $to_object_z))))

  ;; Compute the distance to the intersection point
  (set_local $intersection_dist (f32.sub (f32.sqrt (f32.add (f32.mul $to_object_length $to_object_length) (f32.mul (f32.sub 1 (f32.mul $dot_product $dot_product)) (f32.mul $object_radius $object_radius)))) $dot_product))

  ;; If the distance is negative, the intersection is behind the ray's position
  (if (f32.le $intersection_dist 0)
  (return (i32.const -1)))

  ;; Otherwise, return the intersection distance as the result
  (return (i32.trunc_s/f32 $intersection_dist)))
