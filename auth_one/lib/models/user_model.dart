// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? token;
  String? renewalToken;

  User({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.token,
    this.renewalToken,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['token'],
        renewalToken: responseData['renewalToken']);
  }
}
