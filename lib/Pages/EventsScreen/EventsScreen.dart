import 'package:flutter/material.dart';
import 'package:scheduler/widgets/custom_calendar.dart';
import 'package:scheduler/widgets/custom_date.dart';
import 'package:scheduler/widgets/custom_tile.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomCalendar(),
            SizedBox(
              height: 16,
            ),
            CustomDate(),
            SizedBox(
              height: 8,
            ),
            CustomTile()
          ],
        ),
      ),
    );
  }
}
