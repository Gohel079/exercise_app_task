import 'dart:ffi';

import 'package:exercise_app/model/recommended_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/api_repo.dart';

class CustomTimeBloc {
  final ApiRepository _repository = ApiRepository();


  customApi(Map<String,dynamic>? data,Function(RecommendedTimeModel) onSuccess)
  {
    _repository.customTime(data,(reponse) {
      onSuccess(reponse);
    },);


  }
}