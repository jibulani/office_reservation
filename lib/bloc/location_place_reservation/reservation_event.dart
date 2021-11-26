
import 'package:equatable/equatable.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaces extends ReservationEvent {
  final int locationId;

  const LoadPlaces(this.locationId);

  @override
  List<Object> get props => [locationId];
}

class PlaceTapped extends ReservationEvent {
  final int placeId;

  const PlaceTapped(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class ReservationApproved extends ReservationEvent {
  final int placeId;

  const ReservationApproved(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class ContinueReservation extends ReservationEvent {

  const ContinueReservation();

  // @override
  // List<Object> get props => [];
}

class FinishReservation extends ReservationEvent {

  const FinishReservation();

// @override
// List<Object> get props => [];
}