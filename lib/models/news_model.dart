class ItemModel {
  final String title;
  final String? author;
  final String? url;
  final int? score;
  final int? descendants;
  // final int time;
 

  ItemModel({
    required this.title,
    required this.author,
    required this.score,
    required this.descendants,
    this.url,
    // required this.time,
    
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      author: json['author'],
      url: json['url'],
      score: json['score'],
      descendants: json['descendants'],
      // time: json['time'],
      
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
