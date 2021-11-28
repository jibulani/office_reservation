class Location {

  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnImagePath = 'image_path';

  late int id;
  late String name;
  late String? imgPath;

  Location(this.id, this.name, this.imgPath);

  Location.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    imgPath = map[columnImagePath];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnName: name,
    };
    if (imgPath != null) {
      map[columnImagePath] = imgPath;
    }
    return map;
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $name, imgPath: $imgPath}';
  }
}
