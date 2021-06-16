import 'package:cowin_notifier/cubit/startup/startup_cubit.dart';
import 'package:cowin_notifier/cubit/startup/startup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotifyMeCard extends StatefulWidget {
  const NotifyMeCard({Key key}) : super(key: key);

  @override
  _NotifyMeCardState createState() => _NotifyMeCardState();
}

class _NotifyMeCardState extends State<NotifyMeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartupCubit, StartupState>(
        builder: (context, state) {
          if(state is StartupLoadingState){
            return SizedBox(
              height: 60,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if(state is StartupLoadedState && !(state as StartupLoadedState).isRegistered){
            return SizedBox(
              height: 60,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text("Enable Notifications to get notified when a slot becomes available"),),
              ),
            );
          }
          else return Container();
        }
    );
  }
}
