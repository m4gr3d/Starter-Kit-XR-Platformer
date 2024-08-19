extends XROrigin3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.initialize():
		# Enable XR on the viewport
		var viewport = get_viewport()
		viewport.use_xr = true
		
		# Disable vsync
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
