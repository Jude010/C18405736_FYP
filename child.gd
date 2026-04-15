extends Node3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == 'Body' or body.name.contains('Hand'):
		$Label3D.text= ':)'
