extends Node2D

@onready var squares: Array[Array]

@onready var square_scene = preload("res://scenes/square.tscn")
@onready var white_background_texture = preload("res://assets/backwhite.png")
@onready var black_background_texture = preload("res://assets/backblack.png")

@onready var DEFAULT_SCALE_VECTOR = Vector2(7, 7)
@onready var DEFAULT_SPACING = 17

@onready var player_1_pieces = [
    [Vector2(0,7), Types.Piece.ROOK],
    [Vector2(1,7), Types.Piece.KNIGHT],
    [Vector2(2,7), Types.Piece.BISHOP],
    [Vector2(3,7), Types.Piece.QUEEN],
    [Vector2(4,7), Types.Piece.KING],
    [Vector2(5,7), Types.Piece.BISHOP],
    [Vector2(6,7), Types.Piece.KNIGHT],
    [Vector2(7,7), Types.Piece.ROOK],
    [Vector2(0,6), Types.Piece.PAWN],
    [Vector2(1,6), Types.Piece.PAWN],
    [Vector2(2,6), Types.Piece.PAWN],
    [Vector2(3,6), Types.Piece.PAWN],
    [Vector2(4,6), Types.Piece.PAWN],
    [Vector2(5,6), Types.Piece.PAWN],
    [Vector2(6,6), Types.Piece.PAWN],
    [Vector2(7,6), Types.Piece.PAWN],
]

@onready var player_2_pieces = [
    [Vector2(0,0), Types.Piece.ROOK],
    [Vector2(1,0), Types.Piece.KNIGHT],
    [Vector2(2,0), Types.Piece.BISHOP],
    [Vector2(3,0), Types.Piece.QUEEN],
    [Vector2(4,0), Types.Piece.KING],
    [Vector2(5,0), Types.Piece.BISHOP],
    [Vector2(6,0), Types.Piece.KNIGHT],
    [Vector2(7,0), Types.Piece.ROOK],
    [Vector2(0,1), Types.Piece.PAWN],
    [Vector2(1,1), Types.Piece.PAWN],
    [Vector2(2,1), Types.Piece.PAWN],
    [Vector2(3,1), Types.Piece.PAWN],
    [Vector2(4,1), Types.Piece.PAWN],
    [Vector2(5,1), Types.Piece.PAWN],
    [Vector2(6,1), Types.Piece.PAWN],
    [Vector2(7,1), Types.Piece.PAWN],
]


func set_background_color(row: int, column: int, current_square: Square):
    if (row + column) % 2 == 0:
        current_square.set_background_color(Types.Backgrounds.BLACK)
    else:
        current_square.set_background_color(Types.Backgrounds.WHITE)
    
func add_square_to_scene(row: int, column: int, current_square: Node):
    $Squares.add_child(current_square)
    current_square.position = Vector2(DEFAULT_SPACING * row, DEFAULT_SPACING * column)
    

func render_squares():
    for row in range(8):
        for column in range(8):
            var current_square = squares[row][column]
            add_square_to_scene(row, column, current_square)
            set_background_color(row, column, current_square)


func add_piece(
    x:int, y:int, 
    movement: Array, attack: Array, 
    piece: Types.Piece, color: Types.PieceColor
):
    var square_to_add_piece = squares[x][y]
    square_to_add_piece.set_piece(movement, attack, piece, color)

func add_player_pieces(player_pieces: Array, color: Types.PieceColor):
    for piece in player_pieces:
        var piece_attack = PieceDatabase.piece_movement[piece[1]].call()
        if piece[1] in PieceDatabase.piece_attack:
            piece_attack = PieceDatabase.piece_attack[piece[1]].call()

        add_piece(
            piece[0].x, piece[0].y,
            PieceDatabase.piece_movement[piece[1]].call(),
            piece_attack,
            piece[1],
            color
        )

func add_pieces():
    add_player_pieces(player_1_pieces, Types.PieceColor.WHITE)
    add_player_pieces(player_2_pieces, Types.PieceColor.BLACK)

func create_squares():
    squares = []
    for row in range(8):
        squares.append([])
        
        for column in range(8):
            var square = square_scene.instantiate()
            squares[row].append(square)
            square.connect("square_piece_clicked", _on_piece_clicked)
            square.board_position = Vector2(row, column)

func highlight_squares(_highlight_squares: Array, is_selected: bool, is_attack: bool):
    print(is_selected)
    for square in _highlight_squares:
        squares[square.x][square.y].highlight(is_selected, is_attack)

func find_movement_squares(
    board_position: Vector2, movement: Array, 
    is_selected: bool, is_attack: bool
):
    for move in movement:
        move = move as Movement
        var movement_squares = move.get_movement_squares(
            board_position, 7, 7
        )

        print(move.movement_vector)
        print(board_position)

        highlight_squares(movement_squares, is_selected, is_attack)


func _on_piece_clicked(
    board_position: Vector2,
    _movement: Array, _attack: Array,
    is_selected: bool
):
    # TODO: FIX HIGHLIGHTING
    find_movement_squares(board_position, _attack, is_selected, true)
    find_movement_squares(board_position, _movement, is_selected, false)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    scale = DEFAULT_SCALE_VECTOR

    create_squares()
    render_squares()
    add_pieces()
    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
