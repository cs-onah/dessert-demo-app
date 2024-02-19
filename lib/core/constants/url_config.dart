class UrlConfig {
  static const baseUrl = "https://themealdb.com/api/json/v1/1/filter.php";
  static const dessertUrl = "$baseUrl?c=Dessert";
  static String desertDetail(String mealId)=> "$baseUrl?i=$mealId";
}