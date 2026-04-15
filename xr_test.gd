extends Node3D

var xr_interface: XRInterface

func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initalized successfully")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		XRServer.center_on_hmd(2 , true)
	
	else:
		print("ERROR: OpenXR not initalized - ensure headset plugged in")


func _on_left_hand_button_pressed(name: String) -> void:
	if name == "ax_button":
		XRServer.center_on_hmd(1 , true)
