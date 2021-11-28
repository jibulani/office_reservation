import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/model/reservation.dart';

class ReservationInfo {
  late int id;
  late String name;
  late String location;
  late int placeId;
  late DateTime reservationDateTime;

  ReservationInfo(this.id, this.name, this.location, this.placeId,
      this.reservationDateTime);

  ReservationInfo.fromMap(Map<String, dynamic> map) {
    id = map[Reservation.columnId];
    name = "#$id";
    location = map[Location.columnName];
    placeId = map[Reservation.columnPlaceId];
    reservationDateTime =
        DateTime.parse(map[Reservation.columnReservationDateTime]);
  }

  @override
  String toString() {
    return 'ReservationInfo{id: $id, location: $location,'
        'placeId: $placeId, reservationDateTime: $reservationDateTime}';
  }
}
