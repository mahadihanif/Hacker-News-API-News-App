class CommentModel {
  final String by;
  final int id;
  final int parent;
  final String text;
  final int time;
  final String type;

  CommentModel({
    required this.by,
    required this.id,
    required this.parent,
    required this.text,
    required this.time,
    required this.type,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      by: json['by'],
      id: json['id'],
      parent: json['parent'],
      text: json['text'],
      time: json['time'],
      type: json['type'],
    );
  }
}