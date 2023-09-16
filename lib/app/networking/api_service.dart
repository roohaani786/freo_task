import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:freo_task/app/networking/url_constants.dart';
import '../../environment.dart';
import '../../logger.dart';
import '../constants/custom_snack_bar.dart';
import '../data/api_response.dart';
import '../localization/app_preferences.dart';
import 'api_error_response.dart';
import 'base_api_service.dart';
import 'dio_interceptor.dart';

class ApiService extends BaseApiService {
  final int defaultConnectTimeout = 30 * 1000; // 30 sec
  final int defaultReceiveTimeout = 60 * 1000; // 60 sec

  late Dio _dio;

  static final ApiService _instance = ApiService._internal();

  final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  factory ApiService.getInstance() {
    return _instance;
  }




  ApiService._internal() {
    _dio = Dio()
      ..options.connectTimeout = defaultConnectTimeout
      ..options.receiveTimeout = defaultReceiveTimeout
      ..interceptors.addAll([DioInterceptor(),_dioCacheManager.interceptor]);
  }

  @override
  Future<ApiResponse<T>> postApiCall<T>(String url, Map<String, dynamic> body,
      {Options? options,
        bool urlOverride = false,
        CancelToken? cancelToken,
        FormData? formData,
        bool overrideModel = false}) async {
    url = urlOverride ? url : "https://en.wikipedia.org/w/api.php";

    Logger.i(body, tag: "REQUEST", isJson: true);
    Logger.i(url, tag: "POST URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }

    try {
      final Response response = await _dio.post(url,
          data: formData ?? body, options: options, cancelToken: cancelToken);
      Logger.i("${response.statusCode}", tag: "RESPONSE CODE");
      Logger.i(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      Logger.log("ERROR54 $e");
      return super.handleDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> patchApiCall<T>(String url, Map<String, dynamic> body,
      {Options? options,
      bool urlOverride = false,
      CancelToken? cancelToken,
        FormData? formData,
      bool overrideModel = false}) async {
    url = urlOverride ? url : "https://en.wikipedia.org/w/api.php";

    Logger.i(body, tag: "REQUEST", isJson: true);
    Logger.i(url, tag: "POST URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }

    try {
      final Response response = await _dio.patch(url,
          data: formData ?? body, options: options, cancelToken: cancelToken);
      Logger.i("${response.statusCode}", tag: "RESPONSE CODE");
      Logger.i(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      Logger.log("ERROR54 $e");
      return super.handleDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> deleteApiCall<T>(String url, Map<String, dynamic> body,
      {Options? options,
        bool urlOverride = false,
        CancelToken? cancelToken,
        bool overrideModel = false}) async {
    url = urlOverride ? url : "https://en.wikipedia.org/w/api.php";

    Logger.i(body, tag: "REQUEST", isJson: true);
    Logger.i(url, tag: "POST URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }

    try {
      final Response response = await _dio.delete(url,
          data: body, options: options, cancelToken: cancelToken);
      Logger.i("${response.statusCode}", tag: "RESPONSE CODE");
      Logger.i(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      Logger.log("ERROR54 $e");
      return super.handleDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> getApiCall<T>(String url,
      {Map<String, dynamic>? qParams,
        bool urlOverride = false,
        bool responseTypesAsBytes = false,
        bool overrideModel = false,
        Options? options}) async {
    url = urlOverride ? url : "${UrlConstants.baseUrl}$url";
    Logger.i(qParams, tag: "REQUEST PARAMS", isJson: true);
    Logger.i(url, tag: "GET URL");



    try {
      if (await isInternetConnected() == false) {
        showCustomSnackBar("No Internet Connection");
      }
      DioCacheManager dioCacheManager;
      dioCacheManager = DioCacheManager(CacheConfig());
      Options cacheOptions =
      buildCacheOptions(const Duration(days: 7), forceRefresh: true);
      Dio dio = Dio();
      dio.interceptors.addAll([dioCacheManager.interceptor,DioInterceptor()]);
      Response response = await dio.get(
          url,
          queryParameters: qParams,
          options: cacheOptions);
      if (kDebugMode) {
        print(response);
      }
      Logger.i("${response.statusCode}", tag: "RESPONSE CODE");
      Logger.i(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      return handleDioError(e);
    }
  }

  Future<ApiResponse<T>> requestApiCall<T>(String url,
      {Map<String, dynamic>? qParams,
        bool urlOverride = false,
        bool responseTypesAsBytes = false,
        bool overrideModel = false,
        Options? options}) async {
    url = urlOverride ? url : "https://en.wikipedia.org/w/api.php";
    Logger.i(qParams, tag: "REQUEST PARAMS", isJson: true);
    Logger.i(url, tag: "GET URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }
    Response response;
    try {
      if (responseTypesAsBytes) {
        Options ops = options ?? Options();
        ops.responseType = ResponseType.bytes;
        response = await _dio.request(url, data: qParams, options: ops);
      } else {
        response = await _dio.request(url, data: qParams, options: options);
      }
      Logger.i("${response.statusCode}", tag: "RESPONSE CODE");
      Logger.i(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      return handleDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> upload<T>(String url, String? path, String? fileKey,
      String? fileName, Function(int count, int total)? onUploadProgress,
      {Options? options, FormData? formData}) async {
    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }
    try {
      url = "https://en.wikipedia.org/w/api.php";
      final fd = formData ??
          FormData.fromMap({
            (fileKey ?? ""):
            await MultipartFile.fromFile(path ?? "", filename: fileName),
          });
      final response = await _dio.post(url,
          data: fd, onSendProgress: onUploadProgress, options: options);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      return super.handleDioError(e);
    }
  }

  @override
  Future<dynamic> download(String url, String path,
      {dynamic data,
        Function(int count, int total)? showDownloadProgress,
        Options? options,
        bool urlOverride = false}) async {
    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }

    try {
      url = urlOverride ? url : "https://en.wikipedia.org/w/api.php";
  print("response");
      final response = await _dio.download(url, path,
          data: data,
          options: options,
          onReceiveProgress: showDownloadProgress);
      print("response");
      print(response);
      return Future.value(ApiResponse.from(
          responseData: null, httpStatusCode: response.statusCode));
    } on DioError catch (e) {
      return super.handleDioError(e);
    }
  }
}
