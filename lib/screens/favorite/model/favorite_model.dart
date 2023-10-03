import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) => FavoriteModel.fromJson(json.decode(str));


class FavoriteModel {
  final Data data;
  final String message;
  final List<dynamic> error;
  final int status;

  FavoriteModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    error: List<dynamic>.from(json["error"].map((x) => x)),
    status: json["status"],
  );

}

class Data {

  final List<Datum> data;


  Data({
    required this.data,

  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),

  );

}

class Datum {
  final int id;
  final String name;
  final String price;
  final String category;
  final String image;
  final int discount;
  final int stock;
  final String description;
  final int bestSeller;

  Datum({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.discount,
    required this.stock,
    required this.description,
    required this.bestSeller,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    category: json["category"],
    image: json["image"],
    discount: json["discount"],
    stock: json["stock"],
    description: json["description"],
    bestSeller: json["best_seller"],
  );

}

