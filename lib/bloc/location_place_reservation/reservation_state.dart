
import 'package:equatable/equatable.dart';
import 'package:office_reservation/repository/model/place.dart';

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
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'PlacesLoaded to $places';
}