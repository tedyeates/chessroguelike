class_name PieceDatabase extends Resource

enum MovementType {
    SINGLE_SQUARE,
    STRAIGHT_LINE
}

class Movement:
    var movement_vector: Vector2
    var movement_type: MovementType

    func _init(x: int, y:int, _movement_type: MovementType = MovementType.SINGLE_SQUARE) -> void:
        movement_vector = Vector2(x, y)
        movement_type = _movement_type


    func is_position_outside_bounds(position: Vector2, max_x: int, max_y: int):
        if position > Vector2(max_x, max_y) or position < Vector2(0,0):
            return false

        return true


    func get_single_movement_square(current_position: Vector2, max_x: int, max_y: int):
        var new_square = current_position + movement_vector

        if is_position_outside_bounds(new_square, max_x, max_y):
            return []

        return [new_square]


    func get_straight_line_movement_squares(current_position: Vector2, max_x: int, max_y: int):
        var new_square = current_position + movement_vector
        var new_squares = []

        while not is_position_outside_bounds(new_square, max_x, max_y):
            new_squares.append(new_square)
            new_square += movement_vector

        return new_squares


    func get_movement_squares(current_position: Vector2, max_x: int, max_y: int):

        var movement_types = {
            MovementType.SINGLE_SQUARE: get_single_movement_square,
            MovementType.STRAIGHT_LINE: get_straight_line_movement_squares 
        }

        return movement_types[movement_type].call(current_position, max_x, max_y)
        


func king_movement():
    return [
        Movement.new(0,1), Movement.new(1,0), Movement.new(1,1), 
        Movement.new(-1,0), Movement.new(0,-1), Movement.new(-1,-1)
    ]

func queen_movement():
    return [
        Movement.new(0,1, MovementType.STRAIGHT_LINE), Movement.new(1,0, MovementType.STRAIGHT_LINE), 
        Movement.new(1,1, MovementType.STRAIGHT_LINE), Movement.new(-1,0, MovementType.STRAIGHT_LINE), 
        Movement.new(0,-1, MovementType.STRAIGHT_LINE), Movement.new(-1,-1, MovementType.STRAIGHT_LINE)
    ]

var piece_movement = {
    "King": king_movement(),

}