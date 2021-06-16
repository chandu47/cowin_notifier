import 'package:cowin_notifier/cubit/startup/startup_cubit.dart';
import 'package:cowin_notifier/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COWIN Slots and Notifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<StartupCubit>(
        create: (context) => StartupCubit(),
        child: MyHomePage(title: 'COWIN Slots and Notifier'),
      )
    );
  }
}
