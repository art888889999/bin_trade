part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class OnboardIndicatorOutEvent extends HomeEvent {}

class OnboardIndicatorInEvent extends HomeEvent {}

class GetUserEvent extends HomeEvent {}

class OnboardIndicatorBackEvent extends HomeEvent {
  final int b;
  const OnboardIndicatorBackEvent({required this.b});
}

class HomeChangePageIndex extends HomeEvent {
  final int index;
  const HomeChangePageIndex({required this.index});
}

class ChangeHistoryPageIndex extends HomeEvent {
  final int index;
  const ChangeHistoryPageIndex({required this.index});
}

class SetUserEvent extends HomeEvent {
  final String name;
  const SetUserEvent({required this.name});
}

class GetCurrentChartsEvent extends HomeEvent {
  final String value;
  const GetCurrentChartsEvent({required this.value});
}

class SetOrderTimeEvent extends HomeEvent {
  final String value;
  const SetOrderTimeEvent({required this.value});
}

class SetOrderPointEvent extends HomeEvent {
  final String value;
  const SetOrderPointEvent({required this.value});
}

class SetUserImageEvent extends HomeEvent {
  const SetUserImageEvent();
}

class GetTimerUpdateChartEvent extends HomeEvent {
  const GetTimerUpdateChartEvent();
}

class AddTgEvent extends HomeEvent {
  const AddTgEvent();
}

class GetHistoryEvent extends HomeEvent {
  const GetHistoryEvent();
}

class ResetUserEvent extends HomeEvent {
  const ResetUserEvent();
}

class GetNewsEvent extends HomeEvent {
  const GetNewsEvent();
}

class StopOrderEvent extends HomeEvent {
  final String id;
  const StopOrderEvent({required this.id});
}

class AddOrderEvent extends HomeEvent {
  final bool value;
  const AddOrderEvent({required this.value});
}
