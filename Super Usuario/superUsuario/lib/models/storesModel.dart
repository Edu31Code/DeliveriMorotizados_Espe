import 'dart:convert';

Stores storesFromJson(String str) => Stores.fromJson(json.decode(str));

String storesToJson(Stores data) => json.encode(data.toJson());

class Stores {
  int? id;
  String? storeName;
  String? firstName;
  String? lastName;
  String? phone;
  bool? showEmail;
  String? location;
  String? banner;
  int? bannerId;
  String? gravatar;
  int? gravatarId;
  String? shopUrl;
  int? productsPerPage;
  bool? showMoreProductTab;
  bool? tocEnabled;
  String? storeToc;
  bool? featured;
  bool? enabled;
  DateTime? registered;
  String? payment;
  bool? trusted;
  List<Category>? categories;

  Stores({
    this.id,
    this.storeName,
    this.firstName,
    this.lastName,
    this.phone,
    this.showEmail,
    this.location,
    this.banner,
    this.bannerId,
    this.gravatar,
    this.gravatarId,
    this.shopUrl,
    this.productsPerPage,
    this.showMoreProductTab,
    this.tocEnabled,
    this.storeToc,
    this.featured,
    this.enabled,
    this.registered,
    this.payment,
    this.trusted,
    this.categories,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        id: json["id"],
        storeName: json["store_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        showEmail: json["show_email"],
        location: json["location"],
        banner: json["banner"],
        bannerId: json["banner_id"],
        gravatar: json["gravatar"],
        gravatarId: json["gravatar_id"],
        shopUrl: json["shop_url"],
        productsPerPage: json["products_per_page"],
        showMoreProductTab: json["show_more_product_tab"],
        tocEnabled: json["toc_enabled"],
        storeToc: json["store_toc"],
        featured: json["featured"],
        enabled: json["enabled"],
        registered: DateTime.parse(json["registered"]),
        payment: json["payment"],
        trusted: json["trusted"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_name": storeName,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "show_email": showEmail,
        "location": location,
        "banner": banner,
        "banner_id": bannerId,
        "gravatar": gravatar,
        "gravatar_id": gravatarId,
        "shop_url": shopUrl,
        "products_per_page": productsPerPage,
        "show_more_product_tab": showMoreProductTab,
        "toc_enabled": tocEnabled,
        "store_toc": storeToc,
        "featured": featured,
        "enabled": enabled,
        "registered": registered!.toIso8601String(),
        "payment": payment,
        "trusted": trusted,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Social {
  String? fb;
  String? youtube;
  String? twitter;
  String? linkedin;
  String? pinterest;
  String? instagram;

  Social({
    this.fb,
    this.youtube,
    this.twitter,
    this.linkedin,
    this.pinterest,
    this.instagram,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        fb: json["fb"],
        youtube: json["youtube"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        pinterest: json["pinterest"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "fb": fb,
        "youtube": youtube,
        "twitter": twitter,
        "linkedin": linkedin,
        "pinterest": pinterest,
        "instagram": instagram,
      };
}

class Address {
  String? street1;
  String? street2;
  String? city;
  String? zip;
  String? country;
  String? state;

  Address({
    this.street1,
    this.street2,
    this.city,
    this.zip,
    this.country,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street1: json["street_1"],
        street2: json["street_2"],
        city: json["city"],
        zip: json["zip"],
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "street_1": street1,
        "street_2": street2,
        "city": city,
        "zip": zip,
        "country": country,
        "state": state,
      };
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Links {
  List<Collection>? self;
  List<Collection>? collection;

  Links({
    this.self,
    this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  String? href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Rating {
  String? rating;
  int? count;

  Rating({
    this.rating,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rating: json["rating"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "count": count,
      };
}

class StoreOpenClose {
  bool? enabled;
  Time? time;
  String? openNotice;
  String? closeNotice;

  StoreOpenClose({
    this.enabled,
    this.time,
    this.openNotice,
    this.closeNotice,
  });

  factory StoreOpenClose.fromJson(Map<String, dynamic> json) => StoreOpenClose(
        enabled: json["enabled"],
        time: Time.fromJson(json["time"]),
        openNotice: json["open_notice"],
        closeNotice: json["close_notice"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "time": time!.toJson(),
        "open_notice": openNotice,
        "close_notice": closeNotice,
      };
}

class Time {
  Day? sunday;
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
  Day? saturday;

  Time({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        sunday: Day.fromJson(json["sunday"]),
        monday: Day.fromJson(json["monday"]),
        tuesday: Day.fromJson(json["tuesday"]),
        wednesday: Day.fromJson(json["wednesday"]),
        thursday: Day.fromJson(json["thursday"]),
        friday: Day.fromJson(json["friday"]),
        saturday: Day.fromJson(json["saturday"]),
      );

  Map<String, dynamic> toJson() => {
        "sunday": sunday!.toJson(),
        "monday": monday!.toJson(),
        "tuesday": tuesday!.toJson(),
        "wednesday": wednesday!.toJson(),
        "thursday": thursday!.toJson(),
        "friday": friday!.toJson(),
        "saturday": saturday!.toJson(),
      };
}

class Day {
  String? status;
  String? openingTime;
  String? closingTime;

  Day({
    this.status,
    this.openingTime,
    this.closingTime,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        status: json["status"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "opening_time": openingTime,
        "closing_time": closingTime,
      };
}
