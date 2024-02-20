import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/ui/providers/dessert_list_provider.dart';

class DessertDetail extends Dessert {
  dynamic strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strTags;
  String? strYoutube;
  String? strSource;
  dynamic strImageSource;
  dynamic strCreativeCommonsConfirmed;
  dynamic dateModified;
  List<DessertIngredient> ingredients;

  DessertDetail({
    super.idMeal,
    super.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    super.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
    this.ingredients = const [],
  });

  @override
  DessertDetail copyWith({
    String? idMeal,
    String? strMeal,
    dynamic strDrinkAlternate,
    String? strCategory,
    String? strArea,
    String? strInstructions,
    String? strMealThumb,
    String? strTags,
    String? strYoutube,
    String? strSource,
    dynamic strImageSource,
    dynamic strCreativeCommonsConfirmed,
    dynamic dateModified,
  }) =>
      DessertDetail(
        idMeal: idMeal ?? this.idMeal,
        strMeal: strMeal ?? this.strMeal,
        strDrinkAlternate: strDrinkAlternate ?? this.strDrinkAlternate,
        strCategory: strCategory ?? this.strCategory,
        strArea: strArea ?? this.strArea,
        strInstructions: strInstructions ?? this.strInstructions,
        strMealThumb: strMealThumb ?? this.strMealThumb,
        strTags: strTags ?? this.strTags,
        strYoutube: strYoutube ?? this.strYoutube,
        strSource: strSource ?? this.strSource,
        strImageSource: strImageSource ?? this.strImageSource,
        strCreativeCommonsConfirmed:
            strCreativeCommonsConfirmed ?? this.strCreativeCommonsConfirmed,
        dateModified: dateModified ?? this.dateModified,
      );

  factory DessertDetail.fromJson(Map<String, dynamic> json) {
    List<DessertIngredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json["strIngredient$i"];
      String? measure = json["strMeasure$i"];
      if (ingredient.isNullOrEmpty) break;
      ingredients.add(
        DessertIngredient(ingredient: ingredient, measure: measure),
      );
    }
    return DessertDetail(
      idMeal: json["idMeal"],
      strMeal: json["strMeal"],
      strDrinkAlternate: json["strDrinkAlternate"],
      strCategory: json["strCategory"],
      strArea: json["strArea"],
      strInstructions: json["strInstructions"],
      strMealThumb: json["strMealThumb"],
      strTags: json["strTags"],
      strYoutube: json["strYoutube"],
      strSource: json["strSource"],
      strImageSource: json["strImageSource"],
      strCreativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
      dateModified: json["dateModified"],
      ingredients: ingredients,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strDrinkAlternate": strDrinkAlternate,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strSource": strSource,
        "strImageSource": strImageSource,
        "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
        "dateModified": dateModified,
      };
}

class DessertIngredient {
  final String? ingredient;
  final String? measure;
  DessertIngredient({this.ingredient, this.measure});
}
