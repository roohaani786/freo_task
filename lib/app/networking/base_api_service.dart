import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../logger.dart';
import '../data/api_response.dart';
import '../data/mapper.dart';
import '../localization/translation_keys.dart';
import 'api_error_response.dart';

abstract class BaseApiService {
  Future<ApiResponse<T>> postApiCall<T>(String url, Map<String, dynamic> body,
      {Options? options});

  Future<ApiResponse<T>> getApiCall<T>(String url,
      {Map<String, dynamic>? qParams,
        bool responseTypesAsBytes = false,
        Options? options});

  Future<ApiResponse<T>> upload<T>(String url, String path, String fileKey,
      String fileName, Function(int count, int total)? onUploadProgress,
      {Options? options, FormData? formData});

  Future<dynamic> download(String url, String path,
      {dynamic data,
        Function(int count, int total)? showDownloadProgress,
        Options? options});

  Future<ApiResponse<T>> handleDioError<T>(DioError e) {
    if (e.response != null) {
      Logger.e("DioException", error: e.error, stackTrace: e.stackTrace);
      return Future.value(
          ApiResponse.serverError(httpStatusCode: e.response!.statusCode));
    } else {
      Logger.e("DioException", error: e.error);
      if (e.toString().contains('SocketException')) {
        if (e.toString().contains('Network is unreachable')) {
          return Future.value(ApiResponse.networkError(
              httpStatusCode: ApiResponseListener.noInternetConnection));
        }
        return Future.value(ApiResponse.serverError(
            httpStatusCode: ApiResponseListener.internalServerError));
      }
      return Future.value(
          ApiResponse.serverError(httpStatusCode: ApiResponseListener.unknown));
    }
  }

  ApiResponse<T> handleDioResponse<T>(Response response) {
    final parsedResponse = MapperFactory.map<T>(response.data);
    if (parsedResponse == null) {
      return ApiResponse.serverError(
        httpStatusCode: response.statusCode!,
        responseData: parsedResponse,
      );
    }
    return ApiResponse.from(
      message: response.data['message'] !=null ?
       response.data['message'] is String &&  response.data['message'].toString().trim() !=""  ?  response.data['message']  : TranslationKeys.somethingWentWrongText
     : (response.data['errors'] is List)
          ? response.data['errors'].length > 0
          ? response.data['errors'][0]['message'] ?? TranslationKeys.somethingWentWrongText
          : TranslationKeys.somethingWentWrongText
          : (response.data['errors'] ?? TranslationKeys.somethingWentWrongText),
      httpStatusCode: response.statusCode!,
      responseData: parsedResponse,
    );
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    return false;
  }
}
