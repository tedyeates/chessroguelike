class_name PieceDatabase extends Resource

static var piece_movement = {
    Types.Piece.KING: king_movenment,
    Types.Piece.QUEEN: queen_movenment,
    Types.Piece.ROOK: rook_movenment,
    Types.Piece.BISHOP: bishop_movenment,
    Types.Piece.KNIGHT: knight_movenment,
    Types.Piece.PAWN: pawn_movenment
}

static func king_movenment():
    return [
        Movement.new(0,1), Movement.new(1,0), Movement.new(1,1), 
        Movement.new(-1,0), Movement.new(0,-1), Movement.new(-1,-1),
        Movement.new(1,-1), Movement.new(-1,1)
    ]

static func queen_movenment():
    return [
        Movement.new(0,1, Types.MovementType.STRAIGHT_LINE), Movement.new(1,0, Types.MovementType.STRAIGHT_LINE), 
        Movement.new(1,1, Types.MovementType.STRAIGHT_LINE), Movement.new(-1,0, Types.MovementType.STRAIGHT_LINE), 
        Movement.new(0,-1, Types.MovementType.STRAIGHT_LINE), Movement.new(-1,-1, Types.MovementType.STRAIGHT_LINE),
        Movement.new(1,-1, Types.MovementType.STRAIGHT_LINE), Movement.new(-1,1, Types.MovementType.STRAIGHT_LINE)
    ]


static func rook_movenment():
    return [
        Movement.new(0,1, Types.MovementType.STRAIGHT_LINE), Movement.new(1,0, Types.MovementType.STRAIGHT_LINE), 
        Movement.new(-1,0, Types.MovementType.STRAIGHT_LINE), Movement.new(0,-1, Types.MovementType.STRAIGHT_LINE)
    ]


static func bishop_movenment():
    return [
        Movement.new(1,1, Types.MovementType.STRAIGHT_LINE), Movement.new(-1,1, Types.MovementType.STRAIGHT_LINE), 
        Movement.new(1,-1, Types.MovementType.STRAIGHT_LINE), Movement.new(-1,-1, Types.MovementType.STRAIGHT_LINE)
    ]


static func knight_movenment():
    return [
        Movement.new(1,2), Movement.new(2,1), Movement.new(2,-1), 
        Movement.new(1,-2), Movement.new(-1,-2), Movement.new(-2,-1), 
        Movement.new(-2,1), Movement.new(-1,2)
    ]


static func pawn_movenment():
    return [
        Movement.new(0,1)
    ]

static func pawn_attack():
    return [
        Movement.new(1,1), Movement.new(-1,1)
    ]

static var piece_attack = {
    Types.Piece.PAWN: pawn_attack
}