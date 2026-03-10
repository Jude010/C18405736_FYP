extends Node3D

func _process(delta: float) -> void:
	$Armature/Skeleton3D/FABRIK3D/FrontLeft_target.position = $SpringArmFrontLeft/Front_left_spring.position
	$Armature/Skeleton3D/FABRIK3D/FrontRight_target.position = $SpringArmFrontRight/Front_right_spring.position
	$Armature/Skeleton3D/FABRIK3D/BackLeft_target.position = $SpringArmBackLeft/Back_left_spring.position
	$Armature/Skeleton3D/FABRIK3D/BackRight_target.position = $SpringArmBackRight/Back_right_spring.position
