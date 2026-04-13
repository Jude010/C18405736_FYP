extends Node3D

@export var speed:float = 100
@export var speed_r:int = 3
@export var step_dist:float =45
@export var leg_len:float = 1

var dir:Vector3 = Vector3.ZERO
var rot:float = 0
var rot_x:float = 0

func walk(delta:float , body:CharacterBody3D) -> void:
	var fltarget = $Body/quadraped/Armature/Skeleton3D/LegFL/target
	var frtarget = $Body/quadraped/Armature/Skeleton3D/LegFR/target	
	var bltarget = $Body/quadraped/Armature/Skeleton3D/LegBL/target	
	var brtarget = $Body/quadraped/Armature/Skeleton3D/LegBR/target	
	
	var flshoulder = $Body/quadraped/Armature/Skeleton3D/LegFL/shoulder
	var frshoulder = $Body/quadraped/Armature/Skeleton3D/LegFR/shoulder	
	var blshoulder = $Body/quadraped/Armature/Skeleton3D/LegBL/shoulder	
	var brshoulder = $Body/quadraped/Armature/Skeleton3D/LegBR/shoulder	
	
	var flspring = $SpringArmFL
	var frspring = $SpringArmFR
	var blspring = $SpringArmBL
	var brspring = $SpringArmBR
	
	$Body/quadraped/Armature/Skeleton3D/LegFL/target.global_position = $SpringArmFL/Spring.global_position
	$Body/quadraped/Armature/Skeleton3D/LegFR/target.global_position = $SpringArmFR/Spring.global_position
	$Body/quadraped/Armature/Skeleton3D/LegBL/target.global_position = $SpringArmBL/Spring.global_position
	$Body/quadraped/Armature/Skeleton3D/LegBR/target.global_position = $SpringArmBR/Spring.global_position
	
	
	step(delta , body ,fltarget , flshoulder , flspring)
	step(delta , body ,frtarget , frshoulder , frspring)
	step(delta , body ,bltarget , blshoulder , blspring)
	step(delta , body ,brtarget , brshoulder , brspring)
		
func step(delta:float , body:CharacterBody3D , target:Marker3D ,shoulder:Marker3D , spring:SpringArm3D) ->void:
	var dist = target.global_position.distance_to(shoulder.global_position)
	if dist > leg_len and dist > body.velocity.abs().length():
		var move_dir:Vector3 = body.velocity
		move_dir.y = 0
		move_dir = move_dir.normalized()
		spring.global_position = shoulder.global_position+(move_dir*step_dist*delta)
		


	
func _physics_process(delta: float) -> void:
	
	var body:CharacterBody3D = $Body
	
	
	##if Input.is_action_pressed("forward"):
	##	dir = Vector3.FORWARD + dir
		
	##if Input.is_action_pressed("back"):
	##	dir = Vector3.BACK + dir
		
	##if Input.is_action_pressed("left"):
	##	dir = dir + Vector3.LEFT
	
	##if Input.is_action_pressed("right"):
	##	dir = dir + Vector3.RIGHT
	
	##if Input.is_action_pressed("rot_clockwise"):
	##	rot = rot + 1 
	
	##if Input.is_action_pressed("rot_anti_clockwise"):
	##	rot = rot - 1
	
	##if Input.is_action_pressed("shift"):
	##	dir = dir + Vector3.DOWN

	##if Input.is_action_pressed("space"):
	##	dir = dir + Vector3.UP
	
	body.rotate_y(speed_r * rot * delta)
	body.rotate_object_local(Vector3.RIGHT , rot_x * delta* speed_r)
	
	if body.global_position.y - global_position.y > 0.099 :
		dir = dir * Vector3.UP
	
	if (body.global_position.y - global_position.y) + (dir.y * delta) > 0.5 :
		dir.y = 0
	
	body.velocity = body.global_transform.basis * dir * speed * delta
	
	walk(delta , body)
		
	body.move_and_slide()
	
	#print(body.global_position)
	#print(global_position)
	

## movement X/Z
func _on_right_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	if name == "primary":
		dir = Vector3(value[0],dir[1],-value[1])
	 
## movement Y
func _on_right_hand_input_float_changed(name: String, value: float) -> void:
	if name == "trigger" :
		dir.y = value
	if name == "grip" :
		dir.y = -value		
		

func _on_right_hand_button_released(name: String) -> void:
	dir.y =0


func _on_right_hand_button_pressed(name: String) -> void:
	if name == "trigger_click":
		dir.y = 1
	if name == "grip_click":
		dir.y = -1
	if name == "ax_button":
		print($Body.global_position.y - global_position.y)
		$Body.global_position.y = global_position.y
	
		
## movement rotation
func _on_left_hand_input_vector_2_changed(name: String, value: Vector2) -> void:
	rot = -value[0]
	rot_x = value[1]
