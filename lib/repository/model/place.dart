
class Place {
  final int id;
  final int xCoordinate;
  final int yCoordinate;
  final double height;
  final double width;
  final bool isReserved;
  final bool isSelected;

  Place(this.id, this.xCoordinate, this.yCoordinate, this.height, this.width,
      this.isReserved, this.isSelected);
}
