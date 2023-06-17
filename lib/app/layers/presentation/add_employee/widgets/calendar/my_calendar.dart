import 'package:employee_manager/app/injection/injector.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/bottom_buttons.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/calendar/cubit/my_calendar_cubit.dart';
import 'package:employee_manager/app/layers/presentation/add_employee/widgets/calendar/selectable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarPicker extends StatefulWidget {
  const MyCalendarPicker({
    Key? key,
    this.onTapSave,
    required this.dateFormat,
    this.initialDay,
    this.filter,
    this.firstDay,
    this.lastDay,
  }) : super(key: key);

  final void Function(DateTime? selectedDay)? onTapSave;

  final DateFormat dateFormat;
  final DateTime? initialDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final MyCalendarFilter? filter;

  @override
  State<MyCalendarPicker> createState() => _MyCalendarPickerState();
}

class _MyCalendarPickerState extends State<MyCalendarPicker> {
  late PageController _pageController;
  late MyCalendarCubit cubit = getIt<MyCalendarCubit>();

  @override
  void initState() {
    super.initState();
    cubit.setSelectedDay(
      widget.initialDay,
      widget.filter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCalendarCubit, MyCalendarState>(
      bloc: cubit,
      builder: (context, state) {
        return InkWell(
          onTap: () => _showDatePicker(context, cubit),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(4.0))),
            child: Row(
              children: [
                const SizedBox(width: 11.5),
                SizedBox(
                  height: 17.0,
                  width: 19.12,
                  child: SvgPicture.asset(
                    'assets/images/svg/calendar.svg',
                  ),
                ),
                const SizedBox(width: 13.18),
                Expanded(
                  child: Text(
                    _getSelectedDayText(state.selectedDay),
                    style: TextStyle(
                        fontSize: 16.0,
                        color: state.selectedDay == null
                            ? const Color(0xFF949C9E)
                            : const Color(0xFF323238)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDatePicker(BuildContext context, MyCalendarCubit cubit) {
    showDialog(
        context: context,
        builder: (_) {
          final initialDay = cubit.state.selectedDay;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: BlocBuilder<MyCalendarCubit, MyCalendarState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 24.0),
                          Visibility(
                            visible: state.selectedDay == null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'No date',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.noDate,
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'Today',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.today,
                                      onTap: () => cubit.selectToday(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.selectedDay != null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'Today',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.today,
                                      onTap: () => cubit.selectToday(),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'Next Monday',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.nextMonday,
                                      onTap: () => cubit.selectNextMonday(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Visibility(
                            visible: state.selectedDay != null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'Next Tuesday',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.nextTuesday,
                                      onTap: () => cubit.selectNextTuesday(),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: SelectableButton(
                                      label: 'After 1 week',
                                      isSelected: state.filter ==
                                          MyCalendarFilter.after1Week,
                                      onTap: () => cubit.selectAfter1Week(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _buildHeader(state.focusedDay),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: TableCalendar(
                              headerVisible: false,
                              onCalendarCreated: (controller) =>
                                  _pageController = controller,
                              onDaySelected: (selectedDay, focusedDay) {
                                cubit.setSelectedDay(selectedDay);
                              },
                              firstDay:
                                  widget.firstDay ?? DateTime.utc(1950, 1, 1),
                              lastDay: widget.lastDay ??
                                  DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                              selectedDayPredicate: (day) =>
                                  state.selectedDay == day,
                              focusedDay: state.focusedDay ??
                                  state.selectedDay ??
                                  DateTime.now(),
                              currentDay: state.selectedDay ?? DateTime.now(),
                              onPageChanged: (focusedDay) =>
                                  cubit.setFocusedDay(focusedDay),
                              calendarBuilders: CalendarBuilders(
                                outsideBuilder: (context, day, focusedDay) =>
                                    const Text(''),
                              ),
                              calendarStyle: const CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                      color: Color(0xFF1DA1F2),
                                      shape: BoxShape.circle),
                                  todayDecoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  todayTextStyle: TextStyle(
                                    color: Color(0xFF1DA1F2),
                                  )),
                            ),
                          ),
                          BottomButtons(
                            prefix: Row(
                              children: [
                                SizedBox(
                                  height: 23.0,
                                  width: 20.0,
                                  child: SvgPicture.asset(
                                    'assets/images/svg/calendar.svg',
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Text(
                                  _getSelectedDayText(state.selectedDay),
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            onTapSave: () {
                              widget.onTapSave?.call(state.selectedDay);
                              Navigator.of(context).pop();
                            },
                            onTapCancel: () {
                              if (initialDay != null) {
                                cubit.setSelectedDay(initialDay);
                              } else {
                                cubit.clearSelectedDay();
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  Widget _buildHeader(DateTime? selectedDay) {
    final headerText = DateFormat.yMMMM().format(selectedDay ?? DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.arrow_left_rounded,
                color: Color(0xFF949C9E),
                size: 40.0,
              ),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
          Text(
            headerText,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.arrow_right_rounded,
                color: Color(0xFF949C9E),
                size: 40.0,
              ),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  String _getSelectedDayText(DateTime? selectedDay) {
    final today = DateTime.now();
    return selectedDay != null
        ? selectedDay.day == today.day
            ? 'Today'
            : widget.dateFormat.format(selectedDay)
        : 'No date';
  }
}
