import 'package:office_reservation/repository/db_helper.dart';
import 'package:office_reservation/repository/model/reservation_info.dart';

class ReservationsPageRepository {
  List<ReservationInfo> _data = [];

  Future<void> fetchData() async {
    _data = await DbHelper.instance.getReservationInfoList();
  }

  List<ReservationInfo> get data => _data;
}
