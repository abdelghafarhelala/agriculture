class SponserModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  SponserModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  SponserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  int? ord;
  String? type;
  String? name;
  String? img;
  String? urlL;
  int? withId;

  Data(
      {this.id,
      this.ord,
      this.type,
      this.name,
      this.img,
      this.urlL,
      this.withId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    name = json['name'];
    img = json['img'];
    urlL = json['url_l'];
    withId = json['with_id'];
  }
}
