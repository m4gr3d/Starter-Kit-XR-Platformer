extends StartXR

const PanelSwitcherLayerScene = preload("res://scenes/panel_switcher_layer.tscn")
const PanelSwitcherLayer = preload("res://scripts/panel_switcher_layer.gd")
const PanelSwitcherScene = preload("res://scenes/panel_switcher.tscn")
const PanelSwitcher = preload("res://scripts/panel_switcher.gd")

var panel_switcher: PanelSwitcher
var panel_switcher_layer: PanelSwitcherLayer
var pointer_pressed := false

@onready var left_xr_controller := $XROrigin3D/LeftXRController3D
@onready var right_xr_controller := $XROrigin3D/RightXRController3D
@onready var panel_switcher_holder := $XROrigin3D/LeftXRController3D/PanelSwitcherHolder
@onready var player := $Main/Player

func _ready() -> void:
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		# Immersive mode
		# Only call StartXR._ready() when we know that OpenXR is initialized,
		# because it'll quit the whole app if it isn't.
		super._ready()

		player.left_xr_controller = left_xr_controller
		player.right_xr_controller = right_xr_controller

		panel_switcher_layer = PanelSwitcherLayerScene.instantiate()
		add_child(panel_switcher_layer)
		panel_switcher = panel_switcher_layer.get_panel_switcher()
	else:
		# Panel mode
		player.left_xr_controller = null
		player.right_xr_controller = null

		panel_switcher = PanelSwitcherScene.instantiate()
		add_child(panel_switcher)

	print("Is hybrid app: ", OpenXRHybridApp.is_hybrid_app())
	print("Hybrid App mode: ", OpenXRHybridApp.get_mode())

func _process(_delta: float) -> void:
	if panel_switcher_layer:
		panel_switcher_layer.global_transform = panel_switcher_holder.global_transform
		var controller_transform : Transform3D = right_xr_controller.global_transform
		panel_switcher_layer.update_pointer(controller_transform.origin, -controller_transform.basis.z, pointer_pressed)


func _on_left_xr_controller_3d_button_pressed(button_name: String) -> void:
	if button_name == "menu_button" and panel_switcher:
		panel_switcher.switch_mode(player.player_data)
