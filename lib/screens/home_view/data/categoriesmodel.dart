class CategoriesModel {
  late final Data data;

  CategoriesModel({
    required this.data,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);

  }


}

class Data {
  Data({
    required this.categories,

  });
  late final List<Categories> categories;


  Data.fromJson(Map<String, dynamic> json){
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();

  }


}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.productsCount,
  });
  late final int id;
  late final String name;
  late final int productsCount;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    productsCount = json['products_count'];
  }


}


