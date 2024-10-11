class Puzzle {
  final String id;
  final String pieceImage;
  final String puzzleImage;
  final double y;

  Puzzle({
    required this.id,
    required this.pieceImage,
    required this.puzzleImage,
    required this.y,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    return Puzzle(
        id: json['id'].toString(),
        pieceImage: json['piece_image'].toString(),
        puzzleImage: json['puzzle_image'].toString(),
        y: double.parse(json['y'].toString()));
  }

  static Future<Puzzle> dummy() {
    return Future.value(
        Puzzle(id: "1", pieceImage: '0', puzzleImage: '0', y: 0));
  }
}
