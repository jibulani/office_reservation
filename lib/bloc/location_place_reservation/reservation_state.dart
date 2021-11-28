import 'package:equatable/equatable.dart';
import 'package:office_reservation/repository/model/place_info.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class PageLoading extends ReservationState {
  @override
  String toString() => 'PageLoading';
}

class PlacesLoaded extends ReservationState {
  final List<PlaceInfo> places;

  const PlacesLoaded(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesLoaded to $places';
}

class PlacesLoadedWithDialog extends ReservationState {
  final List<PlaceInfo> places;

  const PlacesLoadedWithDialog(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesLoadedWithDialog to $places';
}
