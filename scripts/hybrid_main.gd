extends StartXR

func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		# Immersive mode
		# Only call StartXR._ready() when we know that OpenXR is initialized,
		# because it'll quit the whole app if it isn't.
		super._ready()
	else:
		# Panel mode
		pass
	
	print("Is hybrid app: ", OpenXRHybridApp.is_hybrid_app())
	print("Hybrid App mode: ", OpenXRHybridApp.get_mode())
