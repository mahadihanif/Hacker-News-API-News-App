class TopStoryModel {
  final String title;
  final String? author;
  final String? text;
  final String? url;
  final List<int> kids;
  final int? score;
  final int? descendants;
  final int time;

  TopStoryModel({
    required this.title,
    required this.score,
    required this.descendants,
    this.author,
    this.text,
    this.url,
    required this.time,
    required this.kids,
  });

  factory TopStoryModel.fromJson(Map<String, dynamic> json) {
    return TopStoryModel(
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
