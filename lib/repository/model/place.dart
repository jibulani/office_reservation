class Place {
  static const String columnId = 'id';
  static const String columnLocationId = 'location_id';
  static const String columnXCoordinateMultiplier = 'x_coordinate_multiplier';
  static const String columnYCoordinateMultiplier = 'y_coordinate_multiplier';
  static const String columnHeightMultiplier = 'height_multiplier';
  static const String columnWidthMultiplier = 'width_multiplier';
  static const String columnOriginalHeight = 'original_height';
  static const String columnOriginalWidth = 'original_width';

  late int id;
  late int locationId;
  late double xCoordinateMultiplier;
  late double yCoordinateMultiplier;
  late double heightMultiplier;
  late double widthMultiplier;
  late double originalHeight;
  late double originalWidth;

  Place(
      this.id,
      this.locationId,
      this.xCoordinateMultiplier,
      this.yCoordinateMultiplier,
      this.heightMultiplier,
      this.widthMultiplier,
      this.originalHeight,
      this.originalWidth);

  Place.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    locationId = map[columnLocationId];
    xCoordinateMultiplier = map[columnXCoordinateMultiplier];
    yCoordinateMultiplier = map[columnYCoordinateMultiplier];
    heightMultiplier = map[columnHeightMultiplier];
    widthMultiplier = map[columnWidthMultiplier];
    originalHeight = map[columnOriginalHeight];
    originalWidth = map[columnOriginalWidth];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnLocationId: locationId,
      columnXCoordinateMultiplier: xCoordinateMultiplier,
      columnYCoordinateMultiplier: yCoordinateMultiplier,
      columnHeightMultiplier: heightMultiplier,
      columnWidthMultiplier: widthMultiplier,
      columnOriginalHeight: originalHeight,
      columnOriginalWidth: originalWidth,
    };
    return map;
  }

  @override
  String toString() {
    return 'Place{id: $id, locationId: $locationId,'
        'xCoordinate: $xCoordinateMultiplier, yCoordinate: $yCoordinateMultiplier,'
        'height: $heightMultiplier, width: $widthMultiplier},'
        'originalHeight: $originalHeight, originalWidth: $originalWidth';
  }
}
