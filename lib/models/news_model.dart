class ItemModel {
  final String title;
  final String? author;
  final String? text;
  final String? url;
  final List<int> kids;
  final int? score;
  final int? descendants;
  final int time;
 

  ItemModel({
    required this.title,
    required this.score,
    required this.descendants,
    this.author,
    this.text,
    this.url,
    required this.time,
    required this.kids,
    
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      author: json['by'],
      text: json['text'],
      url: json['url'],
      score: json['score'],
      descendants: json['descendants'],
      time: json['time'],
      kids: List<int>.from(json['kids'] ?? []),
      
    );
  }
}

class Comment {
  final int id;
  final String text;
  final String? by;
  final int? time;

  const Comment(this.id, this.text, this.by, this.time);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(json["id"], json["text"], json["by"], json["time"]);
  }
}
