import 'dart:convert';
import 'package:dio/dio.dart';

import '../../logger.dart';


class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
     {
        options.headers.addAll({
          'Accept': 'application/json',
        });
      }
      options.validateStatus = (statusCode) {
        if (statusCode == null) {
          return false;
        }
        switch(statusCode) {
          case 400:
          case 404:
          case 405:
          case 403:
          case 422:
          case 401: {
            Logger.e("Unauthorized");
            return false;
          }
          default: {
            if(statusCode >= 200 && statusCode < 300) {
              return true;
            } else {
              /// ToDo: Design app is not working popup
              return false;
            }
          }
        }

      };
    Logger.i(options.headers, tag: "HEADER", isJson: true);
  
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data != null && (response.data as Map).containsKey("_data")) {
      var data = response.data["_data"];
      var jsonData = jsonDecode(data);
      response.data = jsonData;
    }
    // Response decryptedResponse = Response(requestOptions: response.requestOptions, data:jsonData  , statusCode: response.statusCode ) ;
    super.onResponse(response, handler);
  }
}
