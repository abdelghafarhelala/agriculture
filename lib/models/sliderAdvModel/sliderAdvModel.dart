class SliderAdvModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<SlidersAdv>? data;

  SliderAdvModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  SliderAdvModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <SlidersAdv>[];
      json['data'].forEach((v) {
        data!.add(SlidersAdv.fromJson(v));
      });
    }
  }
}

class SlidersAdv {
  int? id;
  int? ord;
  String? type;
  String? name;
  String? img;
  String? urlL;
  int? withId;

  SlidersAdv(
      {this.id,
      this.ord,
      this.type,
      this.name,
      this.img,
      this.urlL,
      this.withId});

  SlidersAdv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    name = json['name'];
    img = json['img'];
    urlL = json['url_l'];
    withId = json['with_id'];
  }
}
