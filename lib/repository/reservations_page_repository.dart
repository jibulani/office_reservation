import 'package:office_reservation/repository/model/reservation.dart';

class ReservationsPageRepository {
  List<Reservation> _data = [];

  Future<void> fetchData() async {
    // simulate real data fetching
    await Future.delayed(const Duration(milliseconds: 600)); // TODO: get reservations from db
    // store dummy data
    _data = [
      Reservation(1, "#9090", "Кузнецкий мост #303", 1, DateTime.now()),
      Reservation(2, "#9079", "Кузнецкий мост #303", 1, DateTime.utc(2021, 11, 12))
    ];
  }

  List<Reservation> get data => _data;
}
