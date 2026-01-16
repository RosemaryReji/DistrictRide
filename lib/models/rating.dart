class Rating {
  final String rideId;
  final String reviewer;
  final int stars; // 1 to 5
  final String comment;

  Rating({
    required this.rideId,
    required this.reviewer,
    required this.stars,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
        "rideId": rideId,
        "reviewer": reviewer,
        "stars": stars,
        "comment": comment,
      };

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rideId: json["rideId"] ?? "",
        reviewer: json["reviewer"] ?? "",
        stars: json["stars"] ?? 0,
        comment: json["comment"] ?? "",
      );
}