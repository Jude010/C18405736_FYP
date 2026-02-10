extends Node3D

@export var speed:float = 100
@export var speed_r:int = 3
@export var step_dist:float =45
@export var leg_len:float = 1

func walk(delta:float , body:CharacterBody3D) -> void:
	var left_target:Vector3 = $SpringArmLeft/Left_target.global_position
	var right_target:Vector3 = $SpringArmRight/Right_target.global_position
	var left_shoulder:Vector3 = $body/biped/Armature/LeftSoulder.global_position
	var right_shoulder:Vector3 = $body/biped/Armature/RightSoulder.global_position
	
	if left_target.distance_to(left_shoulder) > leg_len and left_target.distance_to(left_shoulder) > left_shoulder.distance_to(left_shoulder + body.velocity):
		var move_dir:Vector3 = body.velocity
		move_dir.y = 0
		move_dir = move_dir.normalized()
		$SpringArmLeft.global_position =left_shoulder+move_dir*step_dist*delta
		
	if right_target.distance_to(right_shoulder) > leg_len and right_target.distance_to(right_shoulder) > right_shoulder.distance_to(right_shoulder + body.velocity):
		var move_dir:Vector3 = body.velocity
		move_dir.y = 0
		move_dir = move_dir.normalized()
		$SpringArmRight.global_position = right_shoulder+move_dir*step_dist*delta
		
		

func _physics_process(delta: float) -> void:
	
	var dir:Vector3 = Vector3.ZERO
	var rot:int = 0
	var body:CharacterBody3D = $body
	
	if Input.is_action_pressed("forward"):
		dir = Vector3.FORWARD + dir
		
	if Input.is_action_pressed("back"):
		dir = Vector3.BACK + dir
		
	if Input.is_action_pressed("left"):
		dir = dir + Vector3.LEFT
	
	if Input.is_action_pressed("right"):
		dir = dir + Vector3.RIGHT
	
	if Input.is_action_pressed("rot_clockwise"):
		rot = rot + 1 
	
	if Input.is_action_pressed("rot_anti_clockwise"):
		rot = rot - 1
	
	if Input.is_action_pressed("shift"):
		dir = dir + Vector3.DOWN
		
	if Input.is_action_pressed("space"):
		dir = dir + Vector3.UP
		
	
	body.rotate_y(speed_r * rot * delta)
	
	body.velocity = body.global_transform.basis * dir.normalized() * speed * delta
	
	walk(delta , body)
	
	body.move_and_slide()
