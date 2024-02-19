import 'package:demo_dessert_app/core/models/dessert_detail.dart';

class SingleDessertResponse {
  List<DessertDetail> meals;

  SingleDessertResponse({this.meals = const []});

  SingleDessertResponse copyWith({List<DessertDetail>? meals}) =>
      SingleDessertResponse(meals: meals ?? this.meals);

  factory SingleDessertResponse.fromJson(Map<String, dynamic> json) =>
      SingleDessertResponse(
        meals: json["meals"] == null
            ? []
            : List<DessertDetail>.from(
                json["meals"]!.map((x) => DessertDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}
