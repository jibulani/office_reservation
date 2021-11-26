
import 'package:equatable/equatable.dart';
import 'package:office_reservation/repository/model/place.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class PlaceChanged extends ReservationState {
  final Place place;

  const PlaceChanged(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'PlaceChanged to $place';
}

class PageLoading extends ReservationState {
  @override
  String toString() => 'PageLoading';
}

class PageMenuDialog extends ReservationState {
  @override
  String toString() => 'PageMenuDialog';
}

class PlacesLoaded extends ReservationState {
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesLoaded to $places';
}