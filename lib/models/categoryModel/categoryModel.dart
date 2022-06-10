class ProductModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<ProductData>? data;

  ProductModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;
  String? linkUrl;

  ProductData(
      {this.id,
      this.ord,
      this.type,
      this.parentId,
      this.name,
      this.img,
      this.details,
      this.linkUrl});

  ProductData.fromJson(Map<String, dynamic> json) {
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
