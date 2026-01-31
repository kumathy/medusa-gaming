extends Area2D

@onready var sprite := $Sprite2D
@onready var area := $pickup_area
var item_type: String

func setup(type: String):
	item_type = type
	
	match type:
		"redmask":
			sprite.texture = preload("res://assets/items/Red_Oni_Mask-1.png2.png")
		"bluemask":
			sprite.texture = preload("res://assets/items/Red_Oni_Mask-1.png2.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
