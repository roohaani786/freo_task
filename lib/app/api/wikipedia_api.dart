import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../logger.dart';
import '../data/api_response.dart';
import '../data/model/wiki_page_click_model.dart';
import '../data/model/wiki_search_result_model.dart';
import '../networking/api_service.dart';
import '../networking/url_constants.dart';

class WikiRepository {
  final ApiService apiService = Get.find<ApiService>();

  Future<ApiResponse> getWikiSearchResults({required String query}) async {
    print("here");
    print("Query is $query");

    Map<String,dynamic> qParams = {
      "prop": "pageimages|pageterms|description",
      "titles": query,
      "formatversion": "2",
    };

    ApiResponse apiResponse;
    apiResponse = await apiService.getApiCall<WikiSearchResultModel>(
        UrlConstants.getPersonalities,
    qParams: qParams);
    return apiResponse;
  }

  Future<ApiResponse> getWikiDetailById({required int pageId}) async {
    print("here");
    print("PageId is $pageId");

    Map<String,dynamic> qParams = {
      "prop": "info",
      "pageids": pageId,
      "formatversion": "2",
      "inprop": "url",
    };

    ApiResponse apiResponse;
    apiResponse = await apiService.getApiCall<WikiPageClickModel>(
        UrlConstants.getPersonalities,
        qParams: qParams);

    return apiResponse;
  }
}