import 'dart:math';

class SecondPageRepository {
  int? _data;

  Future<void> fetchData() async {
    // simulate real data fetching
    await Future.delayed(const Duration(milliseconds: 600));
    // store dummy data
    _data = Random().nextInt(1000);
  }

  int? get data => _data;
}
