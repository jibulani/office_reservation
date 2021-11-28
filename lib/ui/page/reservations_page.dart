import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_reservation/repository/model/reservation_info.dart';
import 'package:office_reservation/ui/page/application_page.dart';

class ReservationsPage extends StatelessWidget {
  static const String refreshIconPath =
      'graphics/reservation_refresh_icon.jpeg';

  final List<ReservationInfo> reservations;
  final DateFormat todayFormatter = DateFormat('HH:mm');
  final DateFormat defaultFormatter = DateFormat('dd.MM.yy');

  ReservationsPage({Key? key, required this.reservations}) : super(key: key);

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
            return _getItem(context, index);
          },
          itemCount: reservations.length,
        ),
      ),
    );
  }

  Widget _getItem(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
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
        title: _getTitle(index),
        subtitle: _getSubtitle(index),
      ),
    );
  }

  Widget _getTitle(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(refreshIconPath),
              width: 30,
              height: 30,
            ),
            const SizedBox(
              width: 15,
            ),
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
          _getFormattedDateTime(
              reservations.elementAt(index).reservationDateTime),
          style: const TextStyle(
            color: ApplicationPage.greyColor,
          ),
        ),
      ],
    );
  }

  Widget _getSubtitle(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          reservations.elementAt(index).location,
          style: const TextStyle(
            fontSize: 18,
            color: ApplicationPage.themeColor,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Место: ${_getFormattedPlace(reservations.elementAt(index).placeId)}",
          style: const TextStyle(
            fontSize: 18,
            color: ApplicationPage.themeColor,
          ),
        ),
      ],
    );
  }

  String _getFormattedDateTime(DateTime dateTime) {
    if (_isToday(dateTime)) {
      return todayFormatter.format(dateTime.toLocal());
    }
    return defaultFormatter.format(dateTime.toLocal());
  }

  bool _isToday(DateTime dateTime) {
    var now = DateTime.now().toUtc();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  String _getFormattedPlace(int placeId) {
    if (placeId < 10) {
      return "00$placeId";
    } else if (placeId < 100) {
      return "0$placeId";
    }
    return "$placeId";
  }
}
