class WikiPageClickModel {
  bool? batchcomplete;
  Query? query;

  WikiPageClickModel({this.batchcomplete, this.query});

  WikiPageClickModel.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchcomplete'] = this.batchcomplete;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    return data;
  }
}

class Query {
  List<ClickPages>? pages;

  Query({this.pages});

  Query.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = <ClickPages>[];
      json['pages'].forEach((v) {
        pages!.add(new ClickPages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClickPages {
  int? pageid;
  int? ns;
  String? title;
  String? contentmodel;
  String? pagelanguage;
  String? pagelanguagehtmlcode;
  String? pagelanguagedir;
  String? touched;
  int? lastrevid;
  int? length;
  String? fullurl;
  String? editurl;
  String? canonicalurl;

  ClickPages(
      {this.pageid,
        this.ns,
        this.title,
        this.contentmodel,
        this.pagelanguage,
        this.pagelanguagehtmlcode,
        this.pagelanguagedir,
        this.touched,
        this.lastrevid,
        this.length,
        this.fullurl,
        this.editurl,
        this.canonicalurl});

  ClickPages.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    contentmodel = json['contentmodel'];
    pagelanguage = json['pagelanguage'];
    pagelanguagehtmlcode = json['pagelanguagehtmlcode'];
    pagelanguagedir = json['pagelanguagedir'];
    touched = json['touched'];
    lastrevid = json['lastrevid'];
    length = json['length'];
    fullurl = json['fullurl'];
    editurl = json['editurl'];
    canonicalurl = json['canonicalurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageid'] = this.pageid;
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['contentmodel'] = this.contentmodel;
    data['pagelanguage'] = this.pagelanguage;
    data['pagelanguagehtmlcode'] = this.pagelanguagehtmlcode;
    data['pagelanguagedir'] = this.pagelanguagedir;
    data['touched'] = this.touched;
    data['lastrevid'] = this.lastrevid;
    data['length'] = this.length;
    data['fullurl'] = this.fullurl;
    data['editurl'] = this.editurl;
    data['canonicalurl'] = this.canonicalurl;
    return data;
  }
}
