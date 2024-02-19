class UrlConfig {
  static const baseUrl = "https://themealdb.com/api/json/v1/1/filter.php";
  static const dessertUrl = "$baseUrl?c=Dessert";
  static String desertDetail(String dessertId)=> "$baseUrl?i=$dessertId";

  static const defaultDessertImage = "https://www.southernliving.com/thmb/3x3cJaiOvQ8-3YxtMQX0vvh1hQw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/2652401_QFSSL_SupremePizza_00072-d910a935ba7d448e8c7545a963ed7101.jpg";
  static const defaultMemojiImage = "https://img.freepik.com/premium-photo/memoji-happy-man-white-background-emoji_826801-6839.jpg";
}