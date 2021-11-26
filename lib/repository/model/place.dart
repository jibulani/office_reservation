
class Place {
  int id;
  double xCoordinateMultiplier;
  double yCoordinateMultiplier;
  double heightMultiplier;
  double widthMultiplier;
  bool isReserved;
  bool isSelected;

  Place(this.id, this.xCoordinateMultiplier, this.yCoordinateMultiplier, this.heightMultiplier, this.widthMultiplier,
      this.isReserved, this.isSelected);

  @override
  String toString() {
    return 'Place{id: $id, xCoordinate: $xCoordinateMultiplier, yCoordinate: $yCoordinateMultiplier, height: $heightMultiplier, width: $widthMultiplier, isReserved: $isReserved, isSelected: $isSelected}';
  }
}
