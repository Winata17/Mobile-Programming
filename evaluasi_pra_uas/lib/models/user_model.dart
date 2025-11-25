class UserModel {
  final String name;
  final String email;
  final String city;

  UserModel({
    required this.name,
    required this.email,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      city: json['address']['city'],
    );
  }
}
