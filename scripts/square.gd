class_name Square extends Node2D

@export var defaultsquare: Texture2D

@onready var piece_scene = preload("res://scenes/piece.tscn")

var dark_square_color = Color("#964B00")
var light_square_color = Color("#F5F5DC")
var highlight_color = Color("#ADD8E6")
var attack_highlight_color = Color("#FF3737")

var piece: Node
var board_position: Vector2
var last_background_type: Types.Backgrounds

var backgrounds = {
	Types.Backgrounds.BLACK: dark_square_color,
	Types.Backgrounds.WHITE: light_square_color,
	Types.Backgrounds.HIGHLIGHT: highlight_color,
	Types.Backgrounds.ATTACK_HIGHLIGHT: attack_highlight_color,
}

func change_background_color(background: Types.Backgrounds):
	$BackgroundSprite.modulate = backgrounds[background]	

func set_background_color(background: Types.Backgrounds):
	change_background_color(background)
	last_background_type = background

func set_piece(movement: Array, attack: Array, _piece: Types.Piece, color: Types.PieceColor):
	piece = piece_scene.instantiate()
	$Piece.add_child(piece)
	piece.initialize_piece(movement, attack, _piece, color)
	piece.connect("piece_clicked", _on_piece_clicked)


func get_background_color(should_highlight: bool, is_attack: bool):
	if should_highlight and is_attack:
		return Types.Backgrounds.ATTACK_HIGHLIGHT
	
	if should_highlight:
		return Types.Backgrounds.HIGHLIGHT

	return last_background_type

func highlight(should_highlight: bool, is_attack: bool):
	var background_type = get_background_color(should_highlight, is_attack)
	change_background_color(background_type)


signal square_piece_clicked(
	board_position: Vector2, _movement: Array, 
	_attack: Array, is_selected: bool
)

func _on_piece_clicked(_movement: Array, _attack: Array, is_selected: bool):
	print("square piece clicked")
	square_piece_clicked.emit(board_position, _movement, _attack, is_selected)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_background_type = Types.Backgrounds.WHITE
	$SquareSprite.texture = defaultsquare
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


