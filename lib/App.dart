import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheduler/Helpers/Styles/Style.dart';
import 'package:scheduler/cubit/date_selection_cubit.dart';
import 'package:scheduler/cubit/day_events_cubit.dart';
import 'Helpers/Navigation/AppRoutes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(384, 853),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DateSelectionCubit(),
              ),
              BlocProvider(
                create: (context) => DayEventsCubit(),
              ),
            ],
            child: MaterialApp.router(
              title: 'Code Buddy',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes().routes,
              theme: CustomThemes.lightMode,
            ),
          );
        });
  }
}
