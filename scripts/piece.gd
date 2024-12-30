class_name Piece extends Node2D

@onready var black_king_texture = preload("res://assets/pieces/black_king.png")
@onready var black_queen_texture = preload("res://assets/pieces/black_queen.svg")
@onready var black_rook_texture = preload("res://assets/pieces/black_rook.svg")
@onready var black_bishop_texture = preload("res://assets/pieces/black_bishop.svg")
@onready var black_knight_texture = preload("res://assets/pieces/black_knight.svg")
@onready var black_pawn_texture = preload("res://assets/pieces/black_pawn.svg")

@onready var white_king_texture = preload("res://assets/pieces/white_king.svg")
@onready var white_queen_texture = preload("res://assets/pieces/white_queen.svg")
@onready var white_rook_texture = preload("res://assets/pieces/white_rook.svg")
@onready var white_bishop_texture = preload("res://assets/pieces/white_bishop.svg")
@onready var white_knight_texture = preload("res://assets/pieces/white_knight.svg")
@onready var white_pawn_texture = preload("res://assets/pieces/white_pawn.svg")

var movement: Array
var attack: Array
var is_selected: bool

var pieces = {
	Types.PieceColor.BLACK: {
		Types.Piece.KING: func(): return black_king_texture,
		Types.Piece.QUEEN: func(): return black_queen_texture,
		Types.Piece.ROOK: func(): return black_rook_texture,
		Types.Piece.BISHOP: func(): return black_bishop_texture,
		Types.Piece.KNIGHT: func(): return black_knight_texture,
		Types.Piece.PAWN: func(): return black_pawn_texture,
	},
	Types.PieceColor.WHITE: {
		Types.Piece.KING: func(): return white_king_texture,
		Types.Piece.QUEEN: func(): return white_queen_texture,
		Types.Piece.ROOK: func(): return white_rook_texture,
		Types.Piece.BISHOP: func(): return white_bishop_texture,
		Types.Piece.KNIGHT: func(): return white_knight_texture,
		Types.Piece.PAWN: func(): return white_pawn_texture,
	},
}

func set_piece_texture(piece: Types.Piece, color: Types.PieceColor):
	$PieceSprite.texture = pieces[color][piece].call()

func set_direction(array: Array, direction: int):
	for _movement in array:
		_movement.movement_vector = _movement.movement_vector * Vector2(1,direction)


func initialize_piece(_movement: Array, _attack: Array, piece: Types.Piece, color: Types.PieceColor):
	var direction = 1
	if color == Types.PieceColor.WHITE:
		direction = -1

	print("init")
	print(piece)
	print(color)
	print(_movement[0].movement_vector)

	set_direction(_movement, direction)
	set_direction(_attack, direction)

	print(_movement[0].movement_vector)
	movement = _movement
	attack = _attack
	set_piece_texture(piece, color)

func add_movement(_movement: Movement):
	movement.append(_movement)

func add_attack(_attack: Movement):
	attack.append(_attack)

signal piece_clicked(_movement: Array, attack: Array, is_selected: bool)

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("piece clicked")
		is_selected = not is_selected
		piece_clicked.emit(movement, attack, is_selected)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movement = []
	attack = []
	is_selected = false
	$PieceArea.connect("input_event", _input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
