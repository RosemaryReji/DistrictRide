class User {
  final String name;
  final String phone;
  final double rating;

  User({
    required this.name,
    required this.phone,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "rating": rating,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        phone: json["phone"],
        rating: json["rating"],
      );
}
