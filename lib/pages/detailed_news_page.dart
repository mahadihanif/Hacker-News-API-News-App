import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remote_kitchen_news_app/controller/storiesController.dart';
import '../models/comment_model.dart';
import '../models/news_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'commentsPage.dart';


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



  void showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: CommentWidget(
                commentIds: widget.item.kids,
                scrollController: scrollController,
              ),
            );
          },
        );
      },
    );
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
                Text('by: ${widget.item.author}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.thumbs_up_down_sharp),
                Text(' upvote: ${widget.item.score}',
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
            IconButton(
            icon: Icon(Icons.comment),
            onPressed: showComments,
            
          ),
            const Text('Comments:', style: TextStyle(fontSize: 20)),
            // Expanded(
            //   child: Obx(() {
            //     if (itemController.isLoadingComments.value) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else {
            //       return ListView.builder(
            //         itemCount: itemController.comments.length,
            //         itemBuilder: (context, index) {
            //           CommentModel comment = itemController.comments[index];
            //           String commentText = comment.text.replaceAll(
            //             '&#x27;',
            //             "'",
            //           );
            //           commentText.replaceAll('&#x2F;', "/");
            //           commentText.replaceAll('<p>', '\n\n');
            //           commentText.replaceAll('</p>', '');

            //           return ListTile(
            //             title: Text('By: ${comment.by}'),
            //             subtitle: Text(commentText),
            //             trailing: Text(
            //                 '${DateTime.fromMillisecondsSinceEpoch(comment.time * 1000)}'),
            //           );
            //         },
            //       );
            //     }
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
