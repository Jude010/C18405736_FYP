extends CharacterBody3D

@export var speed:float = 100
@export var speed_r:int = 3

func _physics_process(delta: float) -> void:
	
	var dir:Vector3 = Vector3.ZERO
	var rot:int = 0
	
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
	
	##if Input.is_action_pressed("shift"):
		
	
	rotate_y(speed_r * rot * delta)
	
	velocity = global_transform.basis * dir.normalized() * speed * delta
	
	move_and_slide()
