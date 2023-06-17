part of 'my_calendar_cubit.dart';

enum MyCalendarFilter {
  noDate,
  today,
  nextMonday,
  nextTuesday,
  after1Week,
}

class MyCalendarState with EquatableMixin {
  const MyCalendarState({
    this.selectedDay,
    this.filter = MyCalendarFilter.noDate,
  });

  final DateTime? selectedDay;
  final MyCalendarFilter filter;

  MyCalendarState copyWith({
    DateTime? selectedDay,
    MyCalendarFilter? filter,
  }) {
    return MyCalendarState(
      selectedDay: selectedDay ?? this.selectedDay,
      filter: filter ?? this.filter,
    );
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
        selectedDay?.millisecondsSinceEpoch ?? '',
        filter,
      ];
}
