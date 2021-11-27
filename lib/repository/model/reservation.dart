class Reservation {
  final int id;
  final String name;
  final String location;
  final int placeId;
  final DateTime reservationDateTime;

  Reservation(
      this.id,
      this.name,
      this.location,
      this.placeId,
      this.reservationDateTime);
}
