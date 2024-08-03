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
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListTile(
        // Assigne the onTap function
        onTap: () => onTap(),

        // Assigne the Title text
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // Assigne the upVotes value
        subtitle: Text("$upVotes votes"),

        // Assigne the total no. of Comments value
        trailing: Column(children: [
          const Icon(Icons.comment_outlined),
          Text("$noOfComments"),
        ]),
      ),
    );
  }
}
