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
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => onTap() ,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text("$upVotes votes"),
        trailing: Column(children: [
          const Icon(Icons.comment),
          Text("$noOfComments"),
        ]),
      ),
    );
  }
}
