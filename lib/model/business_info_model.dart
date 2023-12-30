class BusinessInformationModel {
  BusinessInformationModel({
    this.id,
    this.planSubscribeId,
    this.businessCategoryId,
    this.companyName,
    this.address,
    this.phoneNumber,
    this.pictureUrl,
    this.language,
    this.subscriptionDate,
    this.remainingShopBalance,
    this.shopOpeningBalance,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  BusinessInformationModel.fromJson(dynamic json) {
    id = json['id'];
    planSubscribeId = json['plan_subscribe_id'];
    businessCategoryId = json['business_category_id'];
    companyName = json['companyName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    pictureUrl = json['pictureUrl'];
    language = json['language'];
    subscriptionDate = json['subscriptionDate'];
    remainingShopBalance = json['remainingShopBalance'];
    shopOpeningBalance = json['shopOpeningBalance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  num? id;
  num? planSubscribeId;
  num? businessCategoryId;
  String? companyName;
  String? address;
  String? phoneNumber;
  dynamic pictureUrl;
  String? language;
  dynamic subscriptionDate;
  num? remainingShopBalance;
  num? shopOpeningBalance;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['plan_subscribe_id'] = planSubscribeId;
    map['business_category_id'] = businessCategoryId;
    map['companyName'] = companyName;
    map['address'] = address;
    map['phoneNumber'] = phoneNumber;
    map['pictureUrl'] = pictureUrl;
    map['language'] = language;
    map['subscriptionDate'] = subscriptionDate;
    map['remainingShopBalance'] = remainingShopBalance;
    map['shopOpeningBalance'] = shopOpeningBalance;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  dynamic description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}