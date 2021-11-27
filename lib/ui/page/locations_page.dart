
import 'package:flutter/material.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/ui/page/application_page.dart';
import 'package:office_reservation/ui/page/reserve_location_place_page.dart';

class LocationsPage extends StatelessWidget {
  final List<Location> locations;

  const LocationsPage({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationPage.themeColor,
        centerTitle: true,
        title: const Text('Бронирование места в офисе',),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                title: Text(
                  locations.elementAt(index).name,
                  style: const TextStyle(
                    color: ApplicationPage.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ReserveLocationPlacePage(
                            location: locations.elementAt(index),
                          ),
                    ),
                  );
                },
              ),
            );
          },
          itemCount: locations.length,
        ),
      ),
    );
  }
}