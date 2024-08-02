import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_news_app/widget/news_listTile.dart';
import '../controller/storiesController.dart';
import '../models/news_model.dart';
import 'news_page.dart';

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
      appBar: AppBar(
        title: const Text('Hacker News Top Stories'),
        titleTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
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
              ItemModel item = itemController.items[index];
              return NewsListTile(
                title: item.title,
                noOfComments: item.descendants,
                upVotes: item.score,
                onTap: () {
                  Get.to(() => DetailPage(item: item));
                },
              );

              // ListTile(
              //   title: Text(item.title),
              //   subtitle: Text('Comments: ${item.descendants}'),  //No. of Comments refer to Descendants
              //   trailing: Text('Score: ${item.score}'),   //No. of UpVotes refer to Score
              //   onTap: () {
              //     Get.to(() => DetailPage(item: item));
              //   },

              // );
            },
          );
        }
      }),
    );
  }
}
