import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:remote_kitchen_news_app/controller/storiesController.dart';
import '../models/comment_model.dart';
import '../models/news_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/custom_row.dart';
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
            widget.item.text != null && widget.item.text!.isNotEmpty
                ? Text('text: ${widget.item.text}',
                    style: const TextStyle(fontSize: 18))
                : Text('Url: ${widget.item.url}',
                    style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            DataRowWidget(
                icon: Icons.person, label: 'By', value: widget.item.author!),

            const SizedBox(height: 10),

            Text(
              'Published at: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.item.time * 1000).toUtc())}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                onPressed: showComments,
                icon: const Icon(Icons.comment),
                label: Text('${widget.item.descendants} comments', style: const TextStyle(fontSize: 18),),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black, // Foreground color
                ),
              ),


                DataRowWidget(
                    icon: Icons.thumbs_up_down_sharp,
                    label: 'Upvote',
                    value: widget.item.score.toString()),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
