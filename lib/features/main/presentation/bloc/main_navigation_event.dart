import 'package:equatable/equatable.dart';

abstract class MainNavigationEvent extends Equatable {
  const MainNavigationEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends MainNavigationEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
}
