extends Camera3D

var target:Node3D

func _ready() -> void:
	target = $"../../quadraped/Camera_Marker"

func _process(delta:float) -> void:
	self.global_position = 	target.global_position
	self.global_basis = target.global_basis
	
