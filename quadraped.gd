extends Node3D

@export var speed:float = 100
@export var speed_r:int = 3

func _process(_delta: float) -> void:
	$Body/quadraped/Armature/Skeleton3D/FABRIK3D/FrontLeft_target.position = $Body/springs/SpringArmFrontLeft/Front_left_spring.position
	$Body/quadraped/Armature/Skeleton3D/FABRIK3D/FrontRight_target.position = $Body/springs/SpringArmFrontRight/Front_right_spring.position
	$Body/quadraped/Armature/Skeleton3D/FABRIK3D/BackLeft_target.position = $Body/springs/SpringArmBackLeft/Back_left_spring.position
	$Body/quadraped/Armature/Skeleton3D/FABRIK3D/BackRight_target.position = $Body/springs/SpringArmBackRight/Back_right_spring.position

func _physics_process(delta: float) -> void:
	var dir:Vector3 = Vector3.ZERO
	var rot:int = 0
	var body:CharacterBody3D = $Body
	
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
	
	body.move_and_slide()
