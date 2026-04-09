extends MeshInstance3D

func _process(_delta: float) -> void:
	$".".global_position = $"../SpringArmFL".global_position
	print($RayCast3D.get_collider())
