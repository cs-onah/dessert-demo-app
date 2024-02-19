import 'package:demo_dessert_app/core/constants/url_config.dart';
import 'package:demo_dessert_app/core/models/api_responses/single_dessert_response.dart';
import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/dessert_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dessertService = StateProvider((ref) => DessertService());

class DessertService {
  final _network = Dio();

  Future<List<Dessert>> getAllDesserts() async {
    try {
      final response = await _network.get(UrlConfig.dessertUrl);
      return SingleDessertResponse.fromJson(response.data).meals;
    } on DioException {
      throw "An error occurred";
    }
  }

  Future<DessertDetail> getSingleDessert(String dessertId) async {
    try {
      final response = await _network.get(UrlConfig.desertDetail(dessertId));
      final detail = SingleDessertResponse.fromJson(
        response.data,
      ).meals.firstOrNull;
      if (detail == null) throw "No matching dessert found for $dessertId";
      return detail;
    } on DioException {
      throw "An error occurred";
    }
  }
}
