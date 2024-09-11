class TYpeBean {
  int id;
  String name;

  TYpeBean(
    this.id,
    this.name,
  );

  factory TYpeBean.fromJson(Map<String, dynamic> json) {
    return TYpeBean(
      json['id'],
      json['name'],
    );
  }
}
