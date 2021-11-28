class Reservation {
  static const String columnId = 'id';
  static const String columnPlaceId = 'place_id';
  static const String columnReservationDateTime = 'reservation_date_time';

  late int? id;
  late int placeId;
  late DateTime reservationDateTime;

  Reservation(this.id, this.placeId, this.reservationDateTime);

  Reservation.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    placeId = map[columnPlaceId];
    reservationDateTime = DateTime.parse(map[columnReservationDateTime]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnPlaceId: placeId,
      columnReservationDateTime: reservationDateTime.toIso8601String()
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Reservation{id: $id, placeId: $placeId, reservationDateTime: $reservationDateTime}';
  }
}
