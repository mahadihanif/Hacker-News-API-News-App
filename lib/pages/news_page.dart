import 'package:flutter/material.dart';
import '../models/news_model.dart';

class DetailPage extends StatelessWidget {
  final ItemModel item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Showing story attributes here
            Text('Title: ${item.title}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Author: ${item.author}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Upvotes: ${item.score}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Url: ${item.url}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Comments: ${item.descendants}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
