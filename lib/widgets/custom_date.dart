import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/Helpers/Utilities/utilities.dart';

import '../cubit/date_selection_cubit.dart';

class CustomDate extends StatefulWidget {
  const CustomDate({super.key});

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<DateSelectionCubit, DateSelectionState>(
          listener: (context, state) {
            if (state is UpdateDate) {
              date = state.selectedDay;
            }
          },
          builder: (context, state) {
            return Container(
              color: const Color(0xffF8F8F8),
              child: ListTile(
                title: Text(
                  date.dateToString(),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
