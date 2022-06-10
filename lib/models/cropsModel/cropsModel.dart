class CropsModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<CropsData>? data;

  CropsModel({this.result, this.errorMessage, this.errorMessageEn, this.data});

  CropsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <CropsData>[];
      json['data'].forEach((v) {
        data!.add(CropsData.fromJson(v));
      });
    }
  }
}

class CropsData {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;
  String? linkUrl;

  CropsData(
      {this.id,
      this.ord,
      this.type,
      this.parentId,
      this.name,
      this.img,
      this.details,
      this.linkUrl});

  CropsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    type = json['type'];
    parentId = json['parent_id'];
    name = json['name'];
    img = json['img'];
    details = json['details'];
    linkUrl = json['link_url'];
  }
}
