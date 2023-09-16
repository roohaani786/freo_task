

import 'dart:convert';

WikiSearchResultModel wikiSearchResultFromJson(String str) => WikiSearchResultModel.fromJson(json.decode(str));

String wikiSearchResultToJson(WikiSearchResultModel data) => json.encode(data.toJson());

class WikiSearchResultModel {
  bool? batchComplete;
  Query? query;

  WikiSearchResultModel({this.batchComplete, this.query});

  WikiSearchResultModel.fromJson(Map<String, dynamic> json) {
    batchComplete = json['batchcomplete'];
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batchcomplete'] = batchComplete;
    if (query != null) {
      data['query'] = query!.toJson();
    }
    return data;
  }
}

class Query {
  List<Pages>? pages;

  Query({this.pages});

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    pages: json["pages"] == null ? [] : List<Pages>.from(json["pages"]!.map((x) => Pages.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": pages == null ? [] : List<dynamic>.from(pages!.map((x) => x.toJson())),
  };
}

class Pages {
  int? pageid;
  int? ns;
  String? title;
  Thumbnail? thumbnail;
  String? pageimage;
  Terms? terms;
  String? description;
  String? descriptionsource;

  Pages(
      {this.pageid,
        this.ns,
        this.title,
        this.thumbnail,
        this.pageimage,
        this.terms,
      this.description,
      this.descriptionsource});

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    pageid: json["pageid"],
    ns: json["ns"],
    title: json["title"],
    thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    pageimage: json["pageimage"],
    terms: json["terms"] == null ? null : Terms.fromJson(json["terms"]),
    description: json["description"],
    descriptionsource: json["descriptionsource"],
  );

  Map<String, dynamic> toJson() => {
    "pageid": pageid,
    "ns": ns,
    "title": title,
    "thumbnail": thumbnail?.toJson(),
    "pageimage": pageimage,
    "terms": terms?.toJson(),
    "description": description,
    "descriptionsource": descriptionsource,
  };
}

class Thumbnail {
  String? source;
  int? width;
  int? height;

  Thumbnail({this.source, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Terms {
  List<String>? alias;
  List<String>? label;
  List<String>? description;

  Terms({this.alias, this.label, this.description});

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
    alias: json["alias"] == null ? [] : List<String>.from(json["alias"]!.map((x) => x)),
    label: json["label"] == null ? [] : List<String>.from(json["label"]!.map((x) => x)),
    description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "alias": alias == null ? [] : List<dynamic>.from(alias!.map((x) => x)),
    "label": label == null ? [] : List<dynamic>.from(label!.map((x) => x)),
    "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
  };
}
