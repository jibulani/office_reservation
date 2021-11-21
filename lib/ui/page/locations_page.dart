
import 'package:flutter/material.dart';
import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/ui/page/application_page.dart';

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
          padding: EdgeInsets.only(bottom: 50),
          // separatorBuilder: (BuildContext context, int index) => Divider(
          //   color: Colors.black26,
          //   thickness: 1,
          //   height: 1,
          // ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)
                ),
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
                title: Text(locations.elementAt(index).name, style: const TextStyle(color: ApplicationPage.themeColor, fontWeight: FontWeight.bold),),
              ),
            );
          },
          itemCount: locations.length,
        ),
      ),
    );
  }
}