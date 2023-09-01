import 'package:exercise_app/model/recommended_model.dart';
import 'package:exercise_app/remote/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  void recommendedTime(Map<String,dynamic>? data,Function(RecommendedTimeModel) onSuccess) {
     _provider.recommendationAPI(data).then((value) {
       final response = recommendedTimeModelFromJson(value.toString());
       onSuccess(response);
     },);
  }

  void customTime(Map<String,dynamic>? data,
      Function(RecommendedTimeModel) onSuccess) {
    _provider.customTimeAPI(data).then((value) {
      final response = recommendedTimeModelFromJson(value.toString());
      onSuccess(response);
    },);
  }
}
