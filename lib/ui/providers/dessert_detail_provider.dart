import 'package:demo_dessert_app/core/models/dessert_detail.dart';
import 'package:demo_dessert_app/core/models/states/app_state.dart';
import 'package:demo_dessert_app/core/services/dessert_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DessertDetailProvider extends StateNotifier<AppState<DessertDetail>> {
  String dessertId;
  Ref ref;
  DessertDetailProvider(this.ref, this.dessertId) : super(InitialAppState());

  DessertService get service => ref.read(dessertService);

  Future getDessert() async {
    try{
      final res = await service.getSingleDessert(dessertId);
      state = SuccessAppState(res);
    } catch(error){
      if(state is SuccessAppState<DessertDetail>) return;
      state = FailureAppState(error);
    }
    return;
  }
}