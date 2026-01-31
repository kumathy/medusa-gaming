extends Control

@export var game_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuContainer/Button.pressed.connect(_on_start_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed():
	# Change to game scene
	if game_scene:
		get_tree().change_scene_to_packed(game_scene)
	else:
		print("Game scene not assigned!")
