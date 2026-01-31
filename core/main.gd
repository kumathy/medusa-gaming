# main.gd (or game.gd - attach this to your main/game scene root node)
extends Node2D

@export var mob_scene: PackedScene # Assign your mob scene in the inspector
@export var spawn_interval: float = 2.0 # Spawn a mob every 2 seconds
@export var spawn_distance: float = 600.0 # Distance from player to spawn mobs

var player: CharacterBody2D
var spawn_timer: float = 0.0

func _ready() -> void:
	# Get reference to player
	player = $Player # Adjust path if your player is named differently
	
func _process(delta: float) -> void:
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_mob()

func spawn_mob():
	if mob_scene == null or player == null:
		return
	
	# Create new mob instance
	var mob = mob_scene.instantiate()
	
	# Add to group
	mob.add_to_group("mobs")
	
	# Random angle around the player
	var angle = randf() * TAU # TAU = 2 * PI (full circle in radians)
	
	# Calculate spawn position outside camera view
	var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * spawn_distance
	
	# Set mob position
	mob.global_position = spawn_pos
	
	# Give mob reference to player so it can chase
	mob.set_player(player)
	
	# Add to scene
	add_child(mob)

func _on_player_died():
	# Stop spawning or restart game
	set_process(false)
	print("Game Over!")
	# You can add game over logic here
