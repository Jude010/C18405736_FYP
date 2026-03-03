extends FABRIK3D

@export var stepping:bool = false
@export var step_len:float = 1

func step()-> void :
	var IK_target: Marker3D = $IK_Target
	var step_target: Marker3D =	$SpringArm/Step_target
	var dist_to_target = IK_target.global_position.distance_to(step_target.global_position)
	if dist_to_target > step_len && !stepping :
		stepping = true
		var arc_top = IK_target.global_position + (dist_to_target/2)* IK_target.global_position.direction_to(step_target.global_position)
		var tween:Tween = create_tween()
		tween.tween_property(IK_target, "global_position", arc_top , .02 )
		tween.tween_property(IK_target, "global_position", step_target.global_position, .01)
		tween.tween_callback(func():stepping = false)
		
		 
	
