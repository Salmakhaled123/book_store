class SliderModel {
  SliderModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final Data data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  SliderModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    message = json['message'];
    error = List.castFrom<dynamic, dynamic>(json['error']);
    status = json['status'];
  }

}

class Data {
  Data({
    required this.sliders,
  });
  late final List<Sliders> sliders;

  Data.fromJson(Map<String, dynamic> json){
    sliders =json['sliders']!=null?
    List.from(json['sliders']).map((e)=>Sliders.fromJson(e)).toList():[];
  }


}

class Sliders {
  Sliders({
    required this.image,
  });
  late final dynamic image;

  Sliders.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
  }


}