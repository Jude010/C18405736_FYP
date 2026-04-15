extends RayCast3D

func _physics_process(_delta: float) -> void:
	global_position = $"../Body".global_position
