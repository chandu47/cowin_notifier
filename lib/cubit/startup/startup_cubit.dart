import 'package:cowin_notifier/cubit/startup/startup_state.dart';
import 'package:cowin_notifier/data/model/location.dart';
import 'package:cowin_notifier/data/model/states.dart';
import 'package:cowin_notifier/data/repository/states_repo.dart';
import 'package:cowin_notifier/utils/cubit_exception.dart';
import 'package:cowin_notifier/utils/result.dart';
import 'package:cowin_notifier/utils/shared_pref_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<StartupState>{
  final _statesRepo = StatesRepository();
  bool isRegistered;
  bool notifEnabled;
  List<States> statesList;
  Location location;

  StartupCubit() : super(StartupInitialState()){
    getStartupProps();
  }

  void getStartupProps() async{
    try{
      // emit startup loading state when app startup is done
      emit(StartupLoadingState("LoadingAppStart"));

      final String lastLocation = await SharedPrefProvider.sharedPref.lastLocation;
      this.isRegistered = await SharedPrefProvider.sharedPref.isRegistered;
      this.notifEnabled = await SharedPrefProvider.sharedPref.notifEnabled;
      this.statesList = await _fetchStates();
      this.location = lastLocation!=null?Location.fromRawJson(lastLocation):null;

      //The device is registered and thus should fetch notification information
      emit(StartupLoadedState(isRegistered, notifEnabled, location, statesList));

    } catch(error){
      emit(StartupErrorState(error.toString()));
    }
  }

  void updateLocation(Location newLocation) {
    location = newLocation;
    emit(StartupLoadedState(isRegistered, notifEnabled, location, statesList));
  }

  Future<List<States>> _fetchStates() async{

    try {
      final String states = await SharedPrefProvider.sharedPref.states;

      //Check and fetch states information from shared prefs
      if (states != null)
        return States.decode(states);

      //Fetch from API
      Result statesApiResult = await _statesRepo.getStatesInfo();

      if (statesApiResult is SuccessState) {
        //save states to sharedPrefs async
        SharedPrefProvider.sharedPref.setStates(States.encode((statesApiResult as SuccessState).value));
        return (statesApiResult as SuccessState).value;
      }
      //States api threw error
      else {
        throw new CubitException("Error while fetching states information");
      }
    } catch(error){
      throw new CubitException("Error while fetching states information");
    }

  }

}