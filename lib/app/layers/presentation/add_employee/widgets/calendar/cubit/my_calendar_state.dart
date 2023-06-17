part of 'my_calendar_cubit.dart';

enum MyCalendarFilter {
  noDate,
  today,
  nextMonday,
  nextTuesday,
  after1Week,
}

class MyCalendarState with EquatableMixin {
  const MyCalendarState(
      {this.selectedDay,
      this.filter = MyCalendarFilter.noDate,
      this.focusedDay});

  final DateTime? selectedDay;
  final MyCalendarFilter filter;
  final DateTime? focusedDay;

  MyCalendarState copyWith(
      {DateTime? selectedDay, MyCalendarFilter? filter, DateTime? focusedDay}) {
    return MyCalendarState(
        selectedDay: selectedDay ?? this.selectedDay,
        filter: filter ?? this.filter,
        focusedDay: focusedDay ?? this.focusedDay);
  }

  MyCalendarState copyWithSelectedDayNull({
    MyCalendarFilter? filter,
  }) {
    return MyCalendarState(
      selectedDay: null,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
        selectedDay?.microsecondsSinceEpoch ?? '',
        filter,
        focusedDay?.microsecondsSinceEpoch ?? '',
      ];
}
