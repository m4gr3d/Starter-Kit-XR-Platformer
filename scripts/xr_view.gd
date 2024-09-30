extends XRCamera3D

@export_group("Properties")
@export var game_world: Node3D

@export_group("Rotation")
@export var rotation_speed = 60

var game_rotation: Vector3
var game_scale: Vector3
var right_xr_controller: XRController3D = null

func _ready():
	right_xr_controller = get_node_or_null("/root/Main/XROrigin3D/RightXRController")
	game_rotation = game_world.rotation_degrees
	game_scale = game_world.scale

func _physics_process(delta):
	
	# Update game world rotation and scaling
	game_world.rotation_degrees = game_world.rotation_degrees.lerp(game_rotation, delta * 6)
	game_world.scale = game_world.scale.lerp(game_scale, delta * 6)
	
	handle_input(delta)

# Handle input

func handle_input(delta):
	if right_xr_controller == null:
		return
	
	var joystick_value = right_xr_controller.get_vector2("primary")
	
	# Rotation
	var rotation := Vector3.ZERO
	rotation.y = joystick_value.x
	game_rotation += rotation.limit_length(1.0) * rotation_speed * delta
	
	# Scaling
	var scale := Vector3(joystick_value.y, joystick_value.y, joystick_value.y)
	game_scale += scale.limit_length(1.0) * delta
	
