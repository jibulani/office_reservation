import 'package:office_reservation/repository/db_helper.dart';
import 'package:office_reservation/repository/model/location.dart';

class LocationsPageRepository {
  List<Location> _data = [];

  Future<void> fetchData() async {
    _data = await DbHelper.instance.getLocations();
  }

  List<Location> get data => _data;
}
