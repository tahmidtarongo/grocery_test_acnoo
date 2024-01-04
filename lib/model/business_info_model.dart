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
    this.enrolledPlan,});

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
    enrolledPlan = json['enrolled_plan'] != null ? EnrolledPlan.fromJson(json['enrolled_plan']) : null;
  }
  num? id;
  num? planSubscribeId;
  num? businessCategoryId;
  String? companyName;
  String? address;
  String? phoneNumber;
  String? pictureUrl;
  String? language;
  dynamic subscriptionDate;
  num? remainingShopBalance;
  num? shopOpeningBalance;
  String? createdAt;
  String? updatedAt;
  Category? category;
  EnrolledPlan? enrolledPlan;

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
    if (enrolledPlan != null) {
      map['enrolled_plan'] = enrolledPlan?.toJson();
    }
    return map;
  }

}

class EnrolledPlan {
  EnrolledPlan({
    this.id,
    this.planId,
    this.businessId,
    this.price,
    this.duration,
    this.plan,});

  EnrolledPlan.fromJson(dynamic json) {
    id = json['id'];
    planId = json['plan_id'];
    businessId = json['business_id'];
    price = json['price'];
    duration = json['duration'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  num? id;
  num? planId;
  num? businessId;
  num? price;
  num? duration;
  Plan? plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['plan_id'] = planId;
    map['business_id'] = businessId;
    map['price'] = price;
    map['duration'] = duration;
    if (plan != null) {
      map['plan'] = plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
    this.id,
    this.subscriptionName,});

  Plan.fromJson(dynamic json) {
    id = json['id'];
    subscriptionName = json['subscriptionName'];
  }
  num? id;
  String? subscriptionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['subscriptionName'] = subscriptionName;
    return map;
  }

}

class Category {
  Category({
    this.id,
    this.name,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}