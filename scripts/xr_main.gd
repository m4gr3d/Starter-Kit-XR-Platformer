extends Node3D

const DIMENSION_SCALE_RATIO = 15
@onready var xr_origin: XROrigin3D = $XROrigin3D

func _ready() -> void:
	var xr_interface = XRServer.find_interface('OpenXR')
	if xr_interface == null or not xr_interface.is_initialized():
		printerr("FHK - Unable to access xr interface...")
		return
	
	var volume_ext = OpenXRSpatialContainerExtension
	if volume_ext:
		volume_ext.spatial_container_bounds_changed.connect(_on_volume_bounds_changed)
		
		var volume_bounds = volume_ext.get_spatial_container_bounds()
		_update_scale(volume_bounds)
	else:
		printerr("FHK - Unable to access volume extension.")

func _on_volume_bounds_changed(_volume_rid: RID, _volume_infinite_bounds: bool, updated_bounds: Vector3):
	print("FHK - On volume bounds changed...")
	_update_scale(updated_bounds)

func _update_scale(bounds: Vector3):
	# Use the smallest dimension to update the scale, so we keep the gltf with
	# a constant aspect ratio within the spatial container bounds
	var min_dimension: float = min(bounds.x, min(bounds.y, bounds.z))
	xr_origin.world_scale = DIMENSION_SCALE_RATIO / min_dimension
	print("FHK - Updated world_scale to ", xr_origin.world_scale)
