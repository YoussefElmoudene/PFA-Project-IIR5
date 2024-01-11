class UserModel {
  int id;
  String firstName;
  String lastName;
  String username;
  String password;
  String tel;
  String email;
  String role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.tel,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
      tel: json['tel'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'tel': tel,
      'email': email,
      'role': role,
    };
  }
}
