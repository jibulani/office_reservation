
import 'package:office_reservation/repository/model/place.dart';

class ReserveLocationPlaceRepository {
  List<Place> _data = [];

  Future<void> fetchData(int locationId) async {
    // simulate real data fetching
    await Future.delayed(const Duration(milliseconds: 600)); // TODO: get places from db
    // store dummy data
    _data = [
      Place(1, 0.05, 0.2, 0.12, 0.15, true, false),
      Place(2, 0.05, 0, 0.12, 0.15, false, false),
      Place(3, -0.2, 0.2, 0.12, 0.15, false, true),
    ];
  }

  Future<void> reservePlace(int placeId) async {
    // TODO: save reserved place in reservations
  }

  List<Place> get data => _data;
}