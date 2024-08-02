import 'package:flutter/material.dart';

class NewsListTile extends StatelessWidget {
  final String title;
  final int? noOfComments;
  final int? upVotes;
  final Function onTap;
  const NewsListTile({
    super.key,
    required this.onTap,
    required this.title,
    this.noOfComments,
    this.upVotes,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              "$upVotes votes",
              style: const TextStyle(fontSize: 9.0, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
