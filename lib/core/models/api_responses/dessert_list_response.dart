import 'package:demo_dessert_app/core/models/dessert.dart';

class DessertListResponse {
  List<Dessert> meals;

  DessertListResponse({this.meals = const []});

  DessertListResponse copyWith({List<Dessert>? meals}) =>
      DessertListResponse(meals: meals ?? this.meals);

  factory DessertListResponse.fromJson(Map<String, dynamic> json) =>
      DessertListResponse(
        meals: json["meals"] == null
            ? []
            : List<Dessert>.from(json["meals"]!.map((x) => Dessert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

