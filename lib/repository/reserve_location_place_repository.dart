
import 'package:office_reservation/repository/model/place.dart';

class ReserveLocationPlaceRepository {
  List<Place> _data = [];

  Future<void> fetchData() async {
    // simulate real data fetching
    await Future.delayed(const Duration(milliseconds: 600)); // TODO: get places from db
    // store dummy data
    _data = [
      Place(1, 40, 240, 150, 75, true, false),
      Place(2, 40, 30, 150, 75, false, false),
      Place(3, -135, 200, 150, 75, false, true),
    ];
  }

  List<Place> get data => _data;
}