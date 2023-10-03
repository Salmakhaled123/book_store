class GovernorateModel {
  GovernorateModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final List<Data> data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  GovernorateModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
    error = List.castFrom<dynamic, dynamic>(json['error']);
    status = json['status'];
  }

}

class Data
{
  Data({
    required this.id,
    required this.governorateNameEn,
  });
  late final int id;
  late final String governorateNameEn;
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    governorateNameEn = json['governorate_name_en'];
  }

}