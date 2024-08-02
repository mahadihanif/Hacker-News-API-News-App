import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:remote_kitchen_news_app/models/comment_model.dart';
import 'dart:convert';
import '../models/news_model.dart';

class ItemController extends GetxController {
  var items = <ItemModel>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var comments = <CommentModel>[].obs;
  var isLoadingComments = false.obs;
  var currentPage = 0;
  final int pageSize = 10; // Number of news to load per page

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  void fetchItems({bool loadMore = false}) async {
    if (loadMore) {
      isLoadingMore(true);
    } else {
      isLoading(true);
    }

    try {
      final response = await http.get(
          Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json'));
      if (response.statusCode == 200) {
        List<dynamic> ids = json.decode(response.body);
        int start = currentPage * pageSize;
        int end = start + pageSize;
        List<dynamic> pageIds = ids.sublist(start, end);

        for (var id in pageIds) {
          final itemResponse = await http.get(
              Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json'));
          if (itemResponse.statusCode == 200) {
            items.add(ItemModel.fromJson(json.decode(itemResponse.body)));
          }
        }
        currentPage++;
      }
    } finally {
      if (loadMore) {
        isLoadingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

// Fetch Comments list with ids

 void fetchComments(List<int> commentIds) async {
    isLoadingComments(true);
    comments.clear();
    try {
      for (var id in commentIds) {
        final commentResponse = await http.get(Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json'));
        if (commentResponse.statusCode == 200) {
          comments.add(CommentModel.fromJson(json.decode(commentResponse.body)));
        }
      }
    } finally {
      isLoadingComments(false);
    }
  }


}
