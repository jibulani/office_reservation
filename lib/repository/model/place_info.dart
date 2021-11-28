import 'package:office_reservation/repository/model/place.dart';

class PlaceInfo {
  static const String columnIsReserved = 'is_reserved';

  late int id;
  late int locationId;
  late double xCoordinateMultiplier;
  late double yCoordinateMultiplier;
  late double heightMultiplier;
  late double widthMultiplier;
  late bool isReserved;
  late bool isSelected;
  late double originalHeight;
  late double originalWidth;

  PlaceInfo(
      this.id,
      this.locationId,
      this.xCoordinateMultiplier,
      this.yCoordinateMultiplier,
      this.heightMultiplier,
      this.widthMultiplier,
      this.isReserved,
      this.isSelected,
      this.originalHeight,
      this.originalWidth);

  PlaceInfo.fromMap(Map<String, dynamic> map) {
    id = map[Place.columnId];
    locationId = map[Place.columnLocationId];
    xCoordinateMultiplier = map[Place.columnXCoordinateMultiplier];
    yCoordinateMultiplier = map[Place.columnYCoordinateMultiplier];
    heightMultiplier = map[Place.columnHeightMultiplier];
    widthMultiplier = map[Place.columnWidthMultiplier];
    originalHeight = map[Place.columnOriginalHeight];
    originalWidth = map[Place.columnOriginalWidth];
    isReserved = map[columnIsReserved] == 1;
    isSelected = false;
  }

  @override
  String toString() {
    return 'PlaceInfo{id: $id, xCoordinate: $xCoordinateMultiplier,'
        'yCoordinate: $yCoordinateMultiplier, height: $heightMultiplier,'
        'width: $widthMultiplier, isSelected: $isSelected, isReserved: $isReserved}';
  }
}
