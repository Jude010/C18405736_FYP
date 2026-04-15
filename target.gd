extends Marker3D

var is_stepping:bool = false

func step(target:Node3D) -> void:
	var t = get_tree().create_tween()
	var half = (global_position + target.global_position)/2
	var dist = global_position.distance_to(target.global_position)
	is_stepping = true
	t.tween_property(self, "global_position", half + basis.y*dist*.1,.1)
	t.tween_property(self, "global_position", target.global_position,.1)
	t.tween_callback(func(): is_stepping = false)
		
