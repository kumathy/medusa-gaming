extends Area2D

@export var damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
	# Wait for the animation to finish, then remove the whip
	if $AnimatedSprite2D:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished() -> void:
	queue_free() # Remove the whip after its lifetime

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("mobs"):
		# Deal damage to the mob
		if area.has_method("take_damage"):
			area.take_damage(damage)
