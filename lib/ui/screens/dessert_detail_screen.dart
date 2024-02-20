import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/ui/providers/dessert_detail_provider.dart';
import 'package:demo_dessert_app/ui/widgets/base_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              DessertImageWidget(dessert: widget.dessert),
              Expanded(child: Center(child: CupertinoActivityIndicator())),
            ],
          ),
        FailureAppState() => Column(
            children: [
              DessertImageWidget(dessert: widget.dessert),
              Expanded(
                child: Center(
                  child: BaseStateWidget(
                    message: "Failed to fetch product details",
                  ),
                ),
              ),
            ],
          ),
        SuccessAppState() => DessertImageWidget(dessert: model.data),
      },
    );
  }
}

class DessertImageWidget extends StatelessWidget {
  final Dessert dessert;
  const DessertImageWidget({
    super.key,
    required this.dessert,
  });

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
