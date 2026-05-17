class RatingModel {
  final double? rate;
  final int? count;

  RatingModel({this.rate, this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate'] is int
          ? (json['rate'] as int).toDouble()
          : json['rate'] as double?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}
