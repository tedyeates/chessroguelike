extends Node2D
@export var defaultsquare: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SquareSprite.texture = defaultsquare

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
