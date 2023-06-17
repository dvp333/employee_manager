import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_calendar_state.dart';

class MyCalendarCubit extends Cubit<MyCalendarState> {
  MyCalendarCubit() : super(const MyCalendarState());

  void selectToday() {
    emit(state.copyWith(
      filter: MyCalendarFilter.today,
      selectedDay: DateTime.now(),
    ));
  }

  void selectNextMonday() {
    var currentWeekday = state.selectedDay?.weekday ?? DateTime.now().weekday;
    final nextMonday = (7 - currentWeekday) + 1;
    emit(state.copyWith(
      filter: MyCalendarFilter.nextMonday,
      selectedDay: _addToSelectedDay(Duration(days: nextMonday)),
    ));
  }

  void selectNextTuesday() {
    const tuesday = 2;
    var currentWeekday = state.selectedDay?.weekday ?? DateTime.now().weekday;
    final nextTuesday = currentWeekday < tuesday
        ? (tuesday - currentWeekday)
        : (7 - currentWeekday) + 2;
    emit(state.copyWith(
      filter: MyCalendarFilter.nextTuesday,
      selectedDay: _addToSelectedDay(Duration(days: nextTuesday)),
    ));
  }

  void selectAfter1Week() {
    emit(state.copyWith(
      filter: MyCalendarFilter.after1Week,
      selectedDay: _addToSelectedDay(const Duration(days: 7)),
    ));
  }

  void setSelectedDay(DateTime? selectedDay, [MyCalendarFilter? filter]) {
    emit(state.copyWith(selectedDay: selectedDay, filter: filter));
  }

  void clearSelectedDay() {
    emit(state.copyWithSelectedDayNull());
  }

  DateTime _addToSelectedDay(Duration duration) {
    DateTime newDay;
    if (state.selectedDay != null) {
      newDay = state.selectedDay!.add(duration);
    } else {
      newDay = DateTime.now().add(duration);
    }
    return newDay;
  }
}
