class_name Movement extends Resource

var movement_vector: Vector2
var movement_type: Types.MovementType

func _init(x: int, y:int, _movement_type: Types.MovementType = Types.MovementType.SINGLE_SQUARE) -> void:
    movement_vector = Vector2(x, y)
    movement_type = _movement_type


func is_position_inside_bounds(position: Vector2, max_x: int, max_y: int):
    if position.x > max_x or position.y > max_y or position.x < 0 or position.y < 0 or position < Vector2(0,0):
        return false

    return true


func get_single_movement_square(current_position: Vector2, max_x: int, max_y: int, direction: int):
    var new_square = current_position + movement_vector * direction

    if not is_position_inside_bounds(new_square, max_x, max_y):
        return []

    return [new_square]


func get_straight_line_movement_squares(current_position: Vector2, max_x: int, max_y: int, direction: int):
    var new_square = current_position + movement_vector * direction
    var new_squares = []

    while is_position_inside_bounds(new_square, max_x, max_y):
        new_squares.append(new_square)
        new_square += movement_vector

    return new_squares


func get_movement_squares(current_position: Vector2, max_x: int, max_y: int, direction: int = 1):

    var movement_types = {
        Types.MovementType.SINGLE_SQUARE: get_single_movement_square,
        Types.MovementType.STRAIGHT_LINE: get_straight_line_movement_squares 
    }

    return movement_types[movement_type].call(current_position, max_x, max_y, direction)
