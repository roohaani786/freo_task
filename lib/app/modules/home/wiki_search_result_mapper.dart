
import 'package:freo_task/app/data/model/wiki_page_click_model.dart';
import 'package:freo_task/app/data/model/wiki_search_result_model.dart';

import '../../data/mapper.dart';

void registerWikiResultConstructors() {
  MapperFactory.registerConstructor<WikiSearchResultModel>(
          (map) => WikiSearchResultModel.fromJson(map));
  MapperFactory.registerConstructor<WikiPageClickModel>(
          (map) => WikiPageClickModel.fromJson(map));
  // List of registers
}