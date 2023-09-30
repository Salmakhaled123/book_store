class UserDataModel {
  UserDataModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });
  late final Data data;
  late final String message;
  late final List<dynamic> error;
  late final int status;

  UserDataModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    message = json['message'];
    error = List.castFrom<dynamic, dynamic>(json['error']);
    status = json['status'];
  }

}

class Data {
  Data({
    required this.user,
    required this.token,
  });
  late final User user;
  late final String token;

  Data.fromJson(Map<String, dynamic> json)
  {
    user = User.fromJson(json['user']);
    token = json['token'];
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.phone,
    required this.emailVerified,
    required this.image,
  });
   final int id;
   final String name;
   final String email;
   final dynamic address;
   final dynamic city;
   final dynamic phone;
   final bool emailVerified;
   final dynamic image;

 factory User.fromJson(Map<String, dynamic> json)
 {
  return User(id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      phone: json['phone'],
      emailVerified: json['email_verified'],
      image: json['image']);
  }

}