import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/Services/EventsService/EventsService.dart';
import 'App.dart';

void main() {
  runApp(const MyApp());
  registerService();
}

void registerService() {
  GetIt.instance.registerSingleton<EventsService>(EventsService());
}
