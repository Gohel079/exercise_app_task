import 'dart:ffi';

import 'package:exercise_app/model/recommended_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/api_repo.dart';

class RecommendedTimeBloc {
  final ApiRepository _repository = ApiRepository();
  BehaviorSubject<bool>? dailyMover;

  SetDailyMoverBloc() {
    dailyMover = BehaviorSubject<bool>.seeded(false);
  }

  recommendedApiCall(Map<String,dynamic>? data,Function(RecommendedTimeModel) onSuccess)
  {
    _repository.recommendedTime(data,(reponse) {
      dailyMover?.add(reponse.success ?? false);
      onSuccess(reponse);
    },);


  }
}