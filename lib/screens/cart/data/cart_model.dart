class CartModel {
  CartModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final Data data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  CartModel.fromJson(dynamic json){
    data = Data.fromJson(json['data']);
    message = json['message'];
    error = List.castFrom<dynamic, dynamic>(json['error']);
    status = json['status'];
  }

}

class Data {
  Data({
    required this.total,
    required this.cartItems,
  });


  late final dynamic total;
  late final List<CartItems> cartItems;

  Data.fromJson(dynamic json){
    total = json['total'];
    cartItems = List.from(json['cart_items']).
    map((e)=>CartItems.fromJson(e)).toList();
  }

}



class CartItems {
  CartItems({
    required this.itemId,
    required this.itemProductId,
    required this.itemProductName,
    required this.itemProductImage,
    required this.itemProductPrice,
    required this.itemProductDiscount,
    required this.itemProductPriceAfterDiscount,
    required this.itemProductStock,
    required this.itemQuantity,
    required this.itemTotal,
  });
  late final int itemId;
  late final int itemProductId;
  late final String itemProductName;
  late final String itemProductImage;
  late final String itemProductPrice;
  late final int itemProductDiscount;
  late final dynamic itemProductPriceAfterDiscount;
  late final int itemProductStock;
  late final int itemQuantity;
  late final dynamic itemTotal;

  CartItems.fromJson(Map<String, dynamic> json){
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductImage = json['item_product_image']??'';
    itemProductPrice = json['item_product_price'];
    itemProductDiscount = json['item_product_discount'] ?? 0;
    itemProductPriceAfterDiscount = json['item_product_price_after_discount'];
    itemProductStock = json['item_product_stock'] ?? 0;
    itemQuantity = json['item_quantity'];
    itemTotal = json['item_total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['item_id'] = itemId;
    _data['item_product_id'] = itemProductId;
    _data['item_product_name'] = itemProductName;
    _data['item_product_image'] = itemProductImage;
    _data['item_product_price'] = itemProductPrice;
    _data['item_product_discount'] = itemProductDiscount;
    _data['item_product_price_after_discount'] = itemProductPriceAfterDiscount;
    _data['item_product_stock'] = itemProductStock;
    _data['item_quantity'] = itemQuantity;
    _data['item_total'] = itemTotal;
    return _data;
  }
}