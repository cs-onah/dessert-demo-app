class Dessert {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Dessert({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  Dessert copyWith({
    String? strMeal,
    String? strMealThumb,
    String? idMeal,
  }) =>
      Dessert(
        strMeal: strMeal ?? this.strMeal,
        strMealThumb: strMealThumb ?? this.strMealThumb,
        idMeal: idMeal ?? this.idMeal,
      );

  factory Dessert.fromJson(Map<String, dynamic> json) => Dessert(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal,
    "strMealThumb": strMealThumb,
    "idMeal": idMeal,
  };
}
