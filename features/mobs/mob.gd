extends Area2D

@export var speed = 200
var player: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("mobs")
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null and is_instance_valid(player):
		var direction = (player.global_position - global_position).normalized()
		# Move towards player.
		global_position += direction * speed * delta

func set_player(p: CharacterBody2D):
	player = p
