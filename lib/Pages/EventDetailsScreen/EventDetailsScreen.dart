import 'package:flutter/material.dart';
import 'package:scheduler/BOs/EventDetailBO.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDetail eventDetail;
  const EventDetailsScreen({super.key, required this.eventDetail});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
