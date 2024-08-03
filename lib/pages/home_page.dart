import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_news_app/widget/news_listTile.dart';
import '../controller/storiesController.dart';
import '../models/news_model.dart';
import '../widget/my_appBar.dart';
import 'detailed_news_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemController itemController = Get.put(ItemController());

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        itemController.fetchItems(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title:'Hacker News Top Stories'),
      body: Obx(() {
        if (itemController.isLoading.value && itemController.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: scrollController,
            itemCount: itemController.items.length +
                (itemController.isLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == itemController.items.length) {
                return const Center(child: CircularProgressIndicator());
              }
              TopStoryModel item = itemController.items[index];


              return NewsListTile(
                title: item.title,
                noOfComments: item.descendants,
                upVotes: item.score,
                onTap: () {
                  Get.to(() => DetailedNewsPage(item: item));
                },
              );

            },
          );
        }
      }),
    );
  }
}
