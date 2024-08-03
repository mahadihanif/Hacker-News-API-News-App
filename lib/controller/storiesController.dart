import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:remote_kitchen_news_app/models/comment_model.dart';
import 'dart:convert';
import '../models/news_model.dart';
import '../resources/urlHelper.dart';

class ItemController extends GetxController {
  var items = <TopStoryModel>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var comments = <CommentModel>[].obs;
  var isLoadingComments = false.obs;
  var currentPage = 0;
  final int pageSize = 10; // Number of news to load per page
  final _topStoryUrl = Uri.parse(UrlHelper.urlForTopStories());

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
      final response =
          await http.get(_topStoryUrl); // Getting top Stories ID list
      if (response.statusCode == 200) {
        List<dynamic> ids = json.decode(response.body);
        int start = currentPage * pageSize;
        int end = start + pageSize;
        List<dynamic> pageIds = ids.sublist(start, end);

        for (var id in pageIds) {
          final storyUrl = Uri.parse(UrlHelper.urlForStory(id));
          final itemResponse = await http.get(storyUrl); // Getting Story by ID
          if (itemResponse.statusCode == 200) {
            items.add(TopStoryModel.fromJson(json.decode(itemResponse.body)));
          }
        }
        currentPage++;
      } else {
        throw Exception('Failed to load top stories');
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
        final CommentsUrl = Uri.parse(UrlHelper.urlForCommentById(id));
        final commentResponse = await http.get(CommentsUrl);
        if (commentResponse.statusCode == 200) {
          comments
              .add(CommentModel.fromJson(json.decode(commentResponse.body)));
        } else {
          throw Exception('Failed to load comments');
        }
      }
    } finally {
      isLoadingComments(false);
    }
  }
}
