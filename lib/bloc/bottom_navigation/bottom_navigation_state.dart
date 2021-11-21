
import 'package:equatable/equatable.dart';

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

class FirstPageLoaded extends BottomNavigationState {
  final String text;

  const FirstPageLoaded(this.text);

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'FirstPageLoaded with text: $text';
}

class SecondPageLoaded extends BottomNavigationState {
  final int number;

  const SecondPageLoaded(this.number);

  @override
  List<Object> get props => [number];

  @override
  String toString() => 'SecondPageLoaded with number: $number';
}