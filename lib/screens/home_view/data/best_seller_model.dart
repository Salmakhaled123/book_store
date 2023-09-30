class BestSellerModel {
  BestSellerModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final Data data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  BestSellerModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    message = json['message'];
    error = List.castFrom<dynamic, dynamic>(json['error']);
    status = json['status'];
  }

}

class Data {
  Data({
    required this.products,
  });
  late final List<Products> products;

  Data.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.bestSeller,
    required this.image,
    required this.category,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String price;
  late final int discount;
  late final double priceAfterDiscount;
  late final int stock;
  late final int bestSeller;
  late final String image;
  late final String category;

  Products.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount']??'';
    stock = json['stock'];
    bestSeller = json['best_seller'];
    image = json['image'];
    category = json['category'];
  }

}