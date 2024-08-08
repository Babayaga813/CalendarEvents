import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scheduler/Helpers/Navigation/AppRouteConstants.dart';
import 'package:scheduler/Helpers/Styles/Style.dart';
import 'package:scheduler/bloc/events_bloc.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _fetchEventsIfMounted();
  }

  Future<void> _fetchEventsIfMounted() async {
    try {
      // Simulate some async operation
      await Future.delayed(const Duration(milliseconds: 1500));

      // Ensure the widget is still mounted before making the call
      if (mounted) {
        context.read<EventsBloc>().add(FetchEvents());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextAnimator(
              "Hey There!",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.dancingScript().fontFamily),
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500)),
            ),
            BlocConsumer<EventsBloc, EventsState>(
              listener: (context, state) {
                if (state is EventsFetching) {
                  isLoading = true;
                } else if (state is EventsFetched) {
                  isLoading = false;
                  GoRouter.of(context).pushReplacementNamed(
                      AppRouteConstants.dateSelectionRoute);
                }
              },
              builder: (context, state) {
                return isLoading
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Loading your events, hang tight..."),
                          const SizedBox(
                            height: 10,
                          ),
                          LoadingAnimationWidget.horizontalRotatingDots(
                              color: CustomColors.blackColor, size: 30)
                        ],
                      )
                    : const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
