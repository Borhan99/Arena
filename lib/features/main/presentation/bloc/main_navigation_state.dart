import 'package:equatable/equatable.dart';

class MainNavigationState extends Equatable {
  final int selectedIndex;

  const MainNavigationState({this.selectedIndex = 0});

  @override
  List<Object> get props => [selectedIndex];
}
