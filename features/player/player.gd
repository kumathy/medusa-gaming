extends CharacterBody2D

@export var speed = 400
var screen_size
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) # Prevent player from leaving screen.
	
func die():
	hide()
	died.emit()
	set_process(false)

func _on_mask_item_body_entered(body: Node2D) -> void:
	pass # Replace multiplier for item pickup
