extends Control

#@export var main_menu_scene: PackedScene
@export_file("*.tscn") var main_menu_path: String = "res://features/hud/main_menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuContainer/RestartButton.pressed.connect(_on_restart_pressed)
	$MenuContainer/MenuButton.pressed.connect(_on_menu_pressed)

	hide() # Hide the HUD initially

func show_game_over():
	show()
	get_tree().paused = true
	
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_pressed():
	get_tree().paused = false
	
	if main_menu_path:
		get_tree().change_scene_to_file(main_menu_path)
	else:
		print("Main menu scene not assigned")
		
