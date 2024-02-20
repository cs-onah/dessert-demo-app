import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/ui/providers/dessert_detail_provider.dart';
import 'package:demo_dessert_app/core/utils/string_extension.dart';
import 'package:demo_dessert_app/ui/widgets/base_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class DessertDetailScreen extends ConsumerStatefulWidget {
  final Dessert dessert;
  const DessertDetailScreen({super.key, required this.dessert});
  @override
  ConsumerState<DessertDetailScreen> createState() =>
      _DessertDetailScreenState();
}

class _DessertDetailScreenState extends ConsumerState<DessertDetailScreen> {
  String get dessertId => widget.dessert.idMeal ?? "-1";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(dessertDetailProvider(dessertId).notifier).getDessert();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(dessertDetailProvider(dessertId));
    return Scaffold(
      body: switch (model) {
        InitialAppState() => BaseStateWidget(),
        LoadingAppState() => Column(
            children: [
              _DessertImageWidget(dessert: widget.dessert),
              Expanded(child: Center(child: CupertinoActivityIndicator())),
            ],
          ),
        FailureAppState() => Column(
            children: [
              _DessertImageWidget(dessert: widget.dessert),
              Expanded(
                child: Center(
                  child: BaseStateWidget(
                    message: "Failed to fetch product details",
                    isEmpty: false,
                  ),
                ),
              ),
            ],
          ),
        SuccessAppState() => Column(
            children: [
              _DessertImageWidget(dessert: model.data),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    if (!model.data.strInstructions.isNullOrEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            try {
                              launchUrl(Uri.parse(model.data.strYoutube!));
                            } catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Cannot launch video")),
                              );
                            }
                          },
                          icon: Icon(Icons.play_arrow),
                          label: Text("Watch Video"),
                        ),
                      ),
                    Text(
                      "Instructions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${model.data.strInstructions}"),
                    const SizedBox(height: 20),
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...model.data.ingredients.map((e) {
                      return ingredientTile(e.ingredient, e.measure);
                    }),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
      },
    );
  }

  Widget ingredientTile(String? ingredient, String? measure) {
    if (ingredient == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8),
          const SizedBox(width: 10),
          Text(ingredient, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(measure ?? "", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class _DessertImageWidget extends StatelessWidget {
  final Dessert dessert;
  const _DessertImageWidget({required this.dessert});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      dessert.strMealThumb ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: BackButton(onPressed: Navigator.of(context).pop),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "${dessert.strMeal}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
