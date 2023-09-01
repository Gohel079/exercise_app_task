import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

class ApiProvider {

  final Dio _dio = Dio(BaseOptions(connectTimeout: Duration(milliseconds: 30000)));
  final String _url = "http://16.171.185.228/api/v1/user/update_user/";



  Future<Response?> recommendationAPI(Map<String,dynamic>? data) async {
    Response? response;
    try {
      _dio.options.headers['Authorization'] = "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkzNTg4MzY4LCJpYXQiOjE2OTM1NDUxNjgsImp0aSI6IjMyOTYyMjcyNTQyMDRiZDQ4NzBjNzdlYmNiZWNiMzA5IiwidXNlcl9pZCI6IjBjZmQ5ZTYyLTlhMDItNGRkOC04M2Q0LWNhM2I3ZWU5NzdmYyIsImVtYWlsIjoicGFscy50Y2xlQGdtYWlsLmNvbSJ9.hITrxvzoo_IEIPF5Ss40dRJSFOoOrk9xr7LGcB8qu48";

      _dio.interceptors.add(AwesomeDioInterceptor(
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true));
      response = await _dio.post(_url,queryParameters: data);

      print("response code : ${response.statusCode}");
      return response;
    } catch (error, stacktrace) {
      return response;
    }
  }

  Future<Response?> customTimeAPI(Map<String,dynamic>? data) async {
    Response? response;
    try {
      _dio.options.headers['Authorization'] = "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkzNjEzMTE5LCJpYXQiOjE2OTM1Njk5MTksImp0aSI6ImU5ZWNiN2I4NTFlOTRlOTA5ZjMxMGY4MGMyMjVjYjJmIiwidXNlcl9pZCI6IjBjZmQ5ZTYyLTlhMDItNGRkOC04M2Q0LWNhM2I3ZWU5NzdmYyIsImVtYWlsIjoicGFscy50Y2xlQGdtYWlsLmNvbSJ9.kxbO3pSPAdpTujgBNYimgFdBXoN9V4D1RVtNN3VNhUs";

      _dio.interceptors.add(AwesomeDioInterceptor(
          logRequestTimeout: true,
          logRequestHeaders: true,
          logResponseHeaders: true));
      response = await _dio.post(_url,queryParameters: data);

      print("response code : ${response.statusCode}");
      return response;
    } catch (error, stacktrace) {
      return response;
    }
  }
}

