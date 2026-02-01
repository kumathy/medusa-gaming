extends CharacterBody2D

@export var speed = 100
@export var tail_whip_scene: PackedScene
@export var stats := {
	"max_health": 100,
	"health": 100,
	"attack": 10,
	"attack_speed": 10,
	"speed": 400
}
@export var mask_multiplier := {
	"red_mask_A": 1,
	"red_mask_B": 1,
}

signal died

var screen_size
var attack_timer: float = 0.0
var attack_interval: float = 1.0

var facing_right: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	
	input_vector = input_vector.normalized()
	velocity = input_vector * stats.speed
		
	if velocity.x > 0:
		facing_right = false
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		facing_right = true
		$AnimatedSprite2D.flip_h = false
		
	move_and_slide()
	
	# Weapon attack timer
	attack_timer += delta
	if attack_timer >= attack_interval:
		attack_timer = 0.0
		spawn_tail_whip()
	
func spawn_tail_whip():
	if tail_whip_scene == null:
		return
	
	var whip = tail_whip_scene.instantiate()
	
	var whip_offset: Vector2
	
	if facing_right:
		whip_offset = Vector2(80, 0)
	else:
		whip_offset = Vector2(-80, 0)
		
	whip.position = whip_offset
	
	if whip.has_node("AnimatedSprite2D"):
		whip.get_node("AnimatedSprite2D").flip_h = not facing_right
		
	add_child(whip)
	
func die():
	hide()
	died.emit()
	set_process(false)

func _on_mask_item_body_entered(body: Node2D) -> void:
	pass # Replace multiplier for item pickup
