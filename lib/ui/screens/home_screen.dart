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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dessert App"),
          const SizedBox(height: 8),
          Text("Learn to prepare desserts from our amazing recipes."),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(200),
                borderSide: BorderSide(color: Colors.grey),
              ),
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          // State Machine:
          Consumer(
            builder: (_, ref, __) {
              final state = ref.watch(dessertListProvider);
              return switch (state) {
                InitialAppState() => const BaseStateWidget(),
                LoadingAppState() =>
                  const Center(child: CupertinoActivityIndicator()),
                FailureAppState() => BaseStateWidget(message: state.error),
                SuccessAppState<List<Dessert>>() => GridView.count(
                    crossAxisCount: 2,
                    children: state.data.map((e) {
                      return DessertCard(dessert: e);
                    }).toList(),
                  ),
              };
            },
          )
        ],
      ),
    );
  }
}
