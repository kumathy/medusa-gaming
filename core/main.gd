extends Node2D

@export var mob_scenes: Array[PackedScene] = []
@export var spawn_interval: float = 2.0 # Spawn a mob every 2 seconds
@export var spawn_distance: float = 600.0 # Distance from player to spawn mobs

var player: CharacterBody2D
var spawn_timer: float = 0.0

func _ready() -> void:
	player = $Player
	player.died.connect(_on_player_died)
	var map = $Background
	
	var spawnpoint = map.get_node("spawn_point")
	player.global_position = spawnpoint.global_position
	
func _process(delta: float) -> void:
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_mob()

func spawn_mob():
	if mob_scenes.is_empty() or player == null:
		return
	
	var random_mob_scene = mob_scenes.pick_random()
	var mob = random_mob_scene.instantiate()
	
	mob.add_to_group("mobs")
	
	# Random angle around the player
	var angle = randf() * TAU # TAU = 2 * PI
	
	# Calculate spawn position outside camera view
	var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * spawn_distance
	
	# Set mob position
	mob.global_position = spawn_pos
	
	# Give mob reference to player so it can chase
	mob.set_player(player)
	
	# Add to scene
	add_child(mob)

func _on_player_died():
	set_process(false) # Stop spawning mobs
	$CanvasLayer/GameOverHUD.show_game_over()
