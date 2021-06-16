import 'package:cowin_notifier/data/model/location.dart';
import 'package:cowin_notifier/data/model/states.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class StartupState{}

@immutable
class StartupInitialState extends StartupState{}

class StartupLoadingState extends StartupState{
  final stateType;

  StartupLoadingState(this.stateType);
}

class StartupLoadedState extends StartupState{

  final bool isRegistered;
  final bool notifEnabled;
  final Location savedLocation;
  final List<States> statesList;

  StartupLoadedState(this.isRegistered, this.notifEnabled, this.savedLocation,
      this.statesList);

}

/*class StartupLoadedNotRegisteredState extends StartupState{

  final bool isRegistered;
  final bool notifEnabled;
  final Location savedLocation;
  final List<States> statesList;

  StartupLoadedNotRegisteredState(this.isRegistered, this.notifEnabled, this.savedLocation,
      this.statesList);
}*/

class StartupErrorState extends StartupState{

  final String errMsg;

  StartupErrorState(this.errMsg);

}
