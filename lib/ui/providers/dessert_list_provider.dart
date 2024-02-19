import 'package:demo_dessert_app/core/models/dessert.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/core/services/dessert_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DessertListProvider extends StateNotifier<AppState<List<Dessert>>> {
  final Ref ref;
  DessertListProvider(this.ref) : super(InitialAppState());

  DessertService get service => ref.read(dessertService);

  Future getDesserts() async {
    try {
      final res = await service.getAllDesserts();
      state = SuccessAppState(List.from(res));
      return;
    } catch (error) {
      if (state is SuccessAppState<AppState<List<Dessert>>>) return;
      state = FailureAppState(error);
    }
  }
}

final dessertListProvider =
    StateNotifierProvider<DessertListProvider, AppState<List<Dessert>>>(
  (ref) => DessertListProvider(ref),
);
