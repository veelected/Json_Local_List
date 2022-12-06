class Two{
  final String name;
  final  List<String> classes;

  Two({
    required this.name,
    required this.classes
  });

  factory Two.fromJson(Map<String,dynamic>json){
    var classesfromJson = json['classes'];
    List<String> classesList = classesfromJson.cast<String>();
    return Two(
        name: json["name"],
        classes: classesList);
  }
}
