class User {
  String name;
  String email;
  String password;
  List<dynamic> cart = [];
  List<dynamic> orders = [];
  List<dynamic> wishlist = [];

  User({
    required this.name,
    required this.email,
    required this.password,
  });
}
