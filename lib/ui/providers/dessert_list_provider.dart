import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/core/services/dessert_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DessertListProvider extends StateNotifier<AppState<List<Dessert>>> {
  final Ref ref;
  DessertListProvider(this.ref) : super(InitialAppState());

  DessertService get service => ref.read(dessertService);

  List<Dessert> allDesserts = [];

  Future getDesserts() async {
    try {
      state = LoadingAppState();
      final res = await service.getAllDesserts();
      // clean response
      allDesserts = res.where((e) {
        return !e.strMeal.isNullOrEmpty && !e.idMeal.isNullOrEmpty;
      }).toList();
      // sort alphabetically
      allDesserts.sort((a, b) => a.strMeal!.compareTo(b.strMeal!));
      setSuccessState(allDesserts);
      return;
    } catch (error) {
      if (state is SuccessAppState<AppState<List<Dessert>>>) return;
      state = FailureAppState(error);
    }
  }

  String? query;

  filter(String? value) {
    query = value;
    setSuccessState(allDesserts);
  }

  setSuccessState(List<Dessert> desserts){
    final queryResult = desserts.where((element) {
      if(query.isNullOrEmpty) return true;
      return (element.strMeal ?? "").toLowerCase().contains(query!);
    }).toList();
    state = SuccessAppState(List.from(queryResult));
  }
}

final dessertListProvider =
    StateNotifierProvider<DessertListProvider, AppState<List<Dessert>>>(
  (ref) => DessertListProvider(ref),
);

extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.trim() == "";
}
