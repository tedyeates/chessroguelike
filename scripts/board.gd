extends Node2D

@onready var squares: Array[Array]

@onready var square_scene = preload("res://scenes/square.tscn")
@onready var white_background_texture = preload("res://assets/backwhite.png")
@onready var black_background_texture = preload("res://assets/backblack.png")

@onready var DEFAULT_SCALE_VECTOR = Vector2(7, 7)
@onready var DEFAULT_SPACING = 16

func create_squares():
	squares = []
	for row in range(8):
		squares.append([])
		
		for column in range(8):
			squares[row].append(square_scene.instantiate())


func set_background_colour(row: int, column: int, current_square: Node):
	var is_row_odd = row % 2
	var is_column_odd = column % 2
	var odd_row_odd_column = is_row_odd and is_column_odd
	var even_row_even_column = not is_row_odd and not is_column_odd

	var background = current_square.get_node('BackgroundSprite') as Sprite2D

	if odd_row_odd_column or even_row_even_column:
		background.texture = black_background_texture
	


func add_square_to_scene(row: int, column: int, current_square: Node):
	$Squares.add_child(current_square)
	current_square.position = Vector2(DEFAULT_SPACING * row, DEFAULT_SPACING * column)


func render_squares():
	for row in range(8):
		for column in range(8):
			var current_square = squares[row][column]
			add_square_to_scene(row, column, current_square)
			set_background_colour(row, column, current_square)
			
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = DEFAULT_SCALE_VECTOR
	create_squares()
	render_squares()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
