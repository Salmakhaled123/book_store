class BookModel {
  BookModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final Data data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  BookModel.fromJson(Map<String, dynamic> json){
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
  late final dynamic priceAfterDiscount;
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
    priceAfterDiscount = json['price_after_discount'];
    stock = json['stock'];
    bestSeller = json['best_seller'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['price_after_discount'] = priceAfterDiscount;
    _data['stock'] = stock;
    _data['best_seller'] = bestSeller;
    _data['image'] = image;
    _data['category'] = category;
    return _data;
  }
}

class Meta {
  Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });
  late final int total;
  late final int perPage;
  late final int currentPage;
  late final int lastPage;

  Meta.fromJson(Map<String, dynamic> json){
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['per_page'] = perPage;
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });
  late final String first;
  late final String last;
  late final Null prev;
  late final String next;

  Links.fromJson(Map<String, dynamic> json){
    first = json['first'];
    last = json['last'];
    prev = null;
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['prev'] = prev;
    _data['next'] = next;
    return _data;
  }
}