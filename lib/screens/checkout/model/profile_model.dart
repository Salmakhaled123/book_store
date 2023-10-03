class ProfileModel {
  late final Data data;
  ProfileModel({
    required this.data,
  });
  ProfileModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }
}
class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
   required this.address,
   required this.city,
   required this.phone,
    required this.emailVerified,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String address;
  late final String city;
  late final String phone;
  late final bool emailVerified;
  late final String image;

  Data.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name']??'name';
    email = json['email']??'email';
    address = json['address'] ?? 'address';
    city = json['city']?? 'city';
    phone = json['phone']??'phone';
    emailVerified = json['email_verified'];
    image = json['image']??'image';
  }

}