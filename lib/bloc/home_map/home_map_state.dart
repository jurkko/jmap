part of 'home_map_bloc.dart';

@immutable
abstract class HomeMapState extends Equatable {}

class HomeMapInitial extends HomeMapState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomePageLoadSuccess extends HomeMapState {
  Set<Marker> markers;

  HomePageLoadSuccess(this.markers);

  @override
  // TODO: implement props
  List<Object> get props => [markers];
}

class HomePageLoadingState extends HomeMapState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}