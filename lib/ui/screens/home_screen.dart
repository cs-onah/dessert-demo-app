import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_dessert_app/core/constants/url_config.dart';
import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/ui/providers/dessert_list_provider.dart';
import 'package:demo_dessert_app/ui/widgets/base_state_widget.dart';
import 'package:demo_dessert_app/ui/widgets/dessert_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(dessertListProvider.notifier).getDesserts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: const [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dessert App",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Learn to prepare desserts from our amazing recipes.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      UrlConfig.defaultMemojiImage,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                onChanged: (value) =>
                    ref.read(dessertListProvider.notifier).filter(value),
                decoration: InputDecoration(
                  hintText: "Search desserts",
                  suffixIcon: const Icon(Icons.search, size: 30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // State Machine:
            Expanded(
              child: Consumer(
                builder: (_, ref, __) {
                  final state = ref.watch(dessertListProvider);
                  return switch (state) {
                    InitialAppState() => const BaseStateWidget(),
                    LoadingAppState() => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    FailureAppState() => BaseStateWidget(message: state.error),
                    SuccessAppState<List<Dessert>>() => GridView.count(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(20),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                        childAspectRatio: 1 / 1.15,
                        crossAxisCount: 2,
                        children: state.data.map((e) {
                          return DessertCard(dessert: e);
                        }).toList(),
                      ),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
