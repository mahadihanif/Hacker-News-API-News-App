import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remote_kitchen_news_app/controller/storiesController.dart';
import '../models/comment_model.dart';
import '../models/news_model.dart';
import 'package:get/get.dart';

class DetailedNewsPage extends StatefulWidget {
  final ItemModel item;

  const DetailedNewsPage({super.key, required this.item});

  @override
  State<DetailedNewsPage> createState() => _DetailedNewsPageState();
}

class _DetailedNewsPageState extends State<DetailedNewsPage> {
  final ItemController itemController = Get.find();

  @override
  void initState() {
    super.initState();
    itemController.fetchComments(widget.item.kids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),

      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Showing story attributes here
            Text(widget.item.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.person),
                Text(': ${widget.item.author}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.thumbs_up_down_sharp),
                Text(': ${widget.item.score}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 10),
            Text('Url: ${widget.item.url}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('text: ${widget.item.text}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Comments: ${widget.item.descendants}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              'Time: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.item.time * 1000).toUtc())}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text('Comments:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: Obx(() {
                if (itemController.isLoadingComments.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: itemController.comments.length,
                    itemBuilder: (context, index) {
                      CommentModel comment = itemController.comments[index];
                      return ListTile(
                        title: Text('By: ${comment.by}'),
                        subtitle: Text(comment.text),
                        trailing: Text(
                            '${DateTime.fromMillisecondsSinceEpoch(comment.time * 1000)}'),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
