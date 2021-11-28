import 'package:office_reservation/repository/db_helper.dart';
import 'package:office_reservation/repository/model/place_info.dart';
import 'package:office_reservation/repository/model/reservation.dart';

class ReserveLocationPlaceRepository {
  List<PlaceInfo> _data = [];

  Future<void> fetchData(int locationId) async {
    _data = await DbHelper.instance.getPlaceInfoList(locationId);
  }

  Future<void> reservePlace(int placeId) async {
    await DbHelper.instance
        .addReservation(Reservation(null, placeId, DateTime.now().toUtc()));
  }

  List<PlaceInfo> get data => _data;
}
