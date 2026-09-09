extends Node3D

const DIMENSION_SCALE_RATIO = 15
@onready var xr_origin: XROrigin3D = $XROrigin3D

func _ready() -> void:
	var xr_interface = XRServer.find_interface('OpenXR')
	if xr_interface == null or not xr_interface.is_initialized():
		printerr("Unable to access xr interface...")
		return
	
	var spatial_container_ext = OpenXRSpatialContainerExtension
	if spatial_container_ext:
		spatial_container_ext.spatial_container_bounds_changed.connect(_on_spatial_container_bounds_changed)
		
		var volume_bounds = spatial_container_ext.get_spatial_container_bounds()
		_update_scale(volume_bounds)
	else:
		printerr("Unable to access volume extension.")

func _on_spatial_container_bounds_changed(_spatial_container_rid: RID, _infinite_bounds: bool, _bounds_mode: OpenXRSpatialContainerState.BoundsMode, updated_bounds: Vector3):
	print("Spatial container bounds changed...")
	_update_scale(updated_bounds)

func _update_scale(bounds: Vector3):
	# Use the smallest dimension to update the scale, so we keep the gltf with
	# a constant aspect ratio within the spatial container bounds
	var min_dimension: float = min(bounds.x, min(bounds.y, bounds.z))
	xr_origin.world_scale = DIMENSION_SCALE_RATIO / min_dimension
	print("Updated world_scale to ", xr_origin.world_scale)
