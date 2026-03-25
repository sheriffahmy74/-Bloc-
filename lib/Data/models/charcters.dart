class Charcters {
  late int id;
  late String name;
  late String image;
  Charcters.fromjson(Map<String, dynamic> json) {
    id =json ["id"];
    name =json ["name"];
    image =json ["image"];
  }
}
