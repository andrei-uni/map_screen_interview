import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_screen_interview/map_screen/map_bloc/map_bloc.dart';
import 'package:map_screen_interview/map_screen/map_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => MapBloc(),
        child: const MapScreen(),
      ),
    );
  }
}
