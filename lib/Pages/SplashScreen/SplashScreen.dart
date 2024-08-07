import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:scheduler/Helpers/AppConstants/AppConstants.dart';
import 'package:scheduler/Helpers/Navigation/AppRouteConstants.dart';
import 'package:scheduler/Services/EventsService/EventsService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    EventsService service = GetIt.instance<EventsService>();

    service.getEventDetails();

    print(AppConstants.events.length);

    Future.delayed(const Duration(seconds: 3), () {
      print("hello");
      GoRouter.of(context).pushNamed(AppRouteConstants.dateSelectionRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hey There"),
      ),
    );
  }
}
