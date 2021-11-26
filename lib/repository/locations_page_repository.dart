
import 'package:office_reservation/repository/model/location.dart';

class LocationsPageRepository {
  List<Location> _data = [];

  Future<void> fetchData() async {
    // simulate real data fetching
    await Future.delayed(const Duration(milliseconds: 600)); // TODO: get offices from db
    // store dummy data
    var locations = [Location(1, "Кузнецкий мост #303", null), Location(2, "Кузнецкий мост #404", null)];
    _data = locations;
  }

  List<Location> get data => _data;
}
