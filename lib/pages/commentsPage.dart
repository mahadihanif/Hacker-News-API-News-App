// comment_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/storiesController.dart';
import '../models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final List<int> commentIds;
  final ScrollController scrollController;
  final ItemController itemController = Get.find();

  CommentWidget(
      {super.key, required this.commentIds, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    itemController.fetchComments(commentIds);

    return Obx(() {
      if (itemController.isLoadingComments.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          controller: scrollController,
          itemCount: itemController.comments.length,
          itemBuilder: (context, index) {
            CommentModel comment = itemController.comments[index];
            String commentText = comment.text.replaceAll('&#x27;', "'",);
            commentText.replaceAll('&#x2F;', "/");
            commentText.replaceAll('<p>', '\n\n');
            commentText.replaceAll('</p>', '');
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('By: ${comment.by}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      // Html(data: comment.text),
                      Text(commentText),
                      SizedBox(height: 5),
                      Text(
                          '${DateTime.fromMillisecondsSinceEpoch(comment.time * 1000)}',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
