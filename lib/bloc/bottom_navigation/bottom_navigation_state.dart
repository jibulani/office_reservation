
import 'package:equatable/equatable.dart';
import 'package:office_reservation/repository/model/location.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  const CurrentIndexChanged(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class LocationsPageLoaded extends BottomNavigationState {
  final List<Location> locations;

  const LocationsPageLoaded(this.locations);

  @override
  List<Object> get props => [locations];

  @override
  String toString() => 'LocationsPageLoaded with locations: $locations';
}

class SecondPageLoaded extends BottomNavigationState {
  final int number;

  const SecondPageLoaded(this.number);

  @override
  List<Object> get props => [number];

  @override
  String toString() => 'SecondPageLoaded with number: $number';
}