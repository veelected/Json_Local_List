class One {
  int id;
  String name;
  String gender;

  One({required this.id, required this.name, required this.gender});

  factory One.fromJson(Map<String, dynamic> json) {
    return One(
        id: json["id"],
        name: json["name"],
        gender: json["gender"]);
  }
}