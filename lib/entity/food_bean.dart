import 'dart:typed_data';

class FoodBean {
  int id;
  String name;
  Uint8List? image;
  String type;
  String brand;
  int amount;
  double? price;
  String startAt;
  String endAt;

  FoodBean(
    this.id,
    this.name,
    this.image,
    this.type,
    this.brand,
    this.amount,
    this.price,
    this.startAt,
    this.endAt,
  );

  factory FoodBean.fromJson(Map<String, dynamic> json) {
    return FoodBean(json['id'], json['name'], json['image'], json['type'], json['brand'],
        json['amount'], json['price'], json['start_at'], json['end_at']);
  }

  get overdue {
    var difference = DateTime.parse(endAt).difference(DateTime.now());
    int daysDiff = difference.inDays;
    return daysDiff;
  }
}
