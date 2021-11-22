import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_reservation/repository/model/reservation.dart';
import 'package:office_reservation/ui/page/application_page.dart';

class ReservationsPage extends StatelessWidget {
  final List<Reservation> reservations;
  final DateFormat todayFormatter = DateFormat('HH:mm');
  final DateFormat defaultFormatter = DateFormat('dd.MM.yy');

  ReservationsPage({required this.reservations}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ApplicationPage.themeColor,
        centerTitle: true,
        title: const Text(
          'История бронирований',
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(image: AssetImage('graphics/reservation_refresh_icon.jpeg'), width: 30, height: 30,),
                        const SizedBox(width: 15,),
                        Text(
                          reservations.elementAt(index).name,
                          style: const TextStyle(
                              color: ApplicationPage.themeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      getFormattedDateTime(reservations.elementAt(index).reservationDateTime),
                      style: const TextStyle(
                        color: ApplicationPage.greyColor,
                      ),
                    ),
                  ],
                ),
                // trailing: Text(
                //   getFormattedDateTime(reservations.elementAt(index).reservationDateTime),
                //   style: const TextStyle(
                //     color: ApplicationPage.greyColor,
                //   ),
                // ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                    Text(
                      reservations.elementAt(index).location,
                      style: const TextStyle(
                        fontSize: 18,
                        color: ApplicationPage.themeColor,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "Место: ${getFormattedPlace(reservations.elementAt(index).placeId)}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: ApplicationPage.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: reservations.length,
        ),
      ),
    );
  }

  String getFormattedDateTime(DateTime dateTime) {
    if (isToday(dateTime)) {
      return todayFormatter.format(dateTime);
    }
    return defaultFormatter.format(dateTime);
  }

  bool isToday(DateTime dateTime) {
    var now = DateTime.now();
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day;
  }

  String getFormattedPlace(int placeId) {
    if (placeId < 10) {
      return "00$placeId";
    } else if (placeId < 100) {
      return "0$placeId";
    }
    return "$placeId";
  }
}
