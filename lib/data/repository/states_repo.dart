import 'package:cowin_notifier/data/model/district.dart';
import 'package:cowin_notifier/data/model/states.dart';
import 'package:cowin_notifier/data/network/districts_client.dart';
import 'package:cowin_notifier/data/network/states_client.dart';
import 'package:cowin_notifier/utils/request_type.dart';
import 'package:cowin_notifier/utils/result.dart';
import 'package:http/http.dart';

class StatesRepository{

  StatesClient _statesClient = StatesClient(Client());

  DistrictsClient _districtsClient = DistrictsClient(Client());

  Future<Result> getStatesInfo() async{
    final response = await _statesClient.request(requestType: RequestType.GET);
    List<States> _statesList;
    //Check if the the response from states api is success
    try{
      if(response.statusCode==200){
        _statesList = States.decode(response.
        body);
        for(States state in _statesList){
          //Get districts information for each state and set to states object
            Result districtsResult = await _getDistrictsInfo(state.state_id);
            if(districtsResult is SuccessState){
              state.districts = (districtsResult as SuccessState).value;
            }
            else{
              return Result.error((districtsResult as ErrorState).msg);
            }
        }
        return Result<List<States>>.success(_statesList);
      }
      else{
        return Result.error("States API throwing error");
      }
    } catch(error){
      return Result.error("Something went wrong while fetching states.");
    }
  }

  Future<Result> _getDistrictsInfo(int stateId) async{
    final response = await _districtsClient.request(requestType: RequestType.GET, param: stateId);
    try {
      if (response.statusCode == 200) {
        return Result<List<District>>.success(
            District.decode(response.body));
      }
      else {
        return Result.error("Districts API throwing exception");
      }
    } catch(error){
      return Result.error("Something went wrong while fetching districts.");
    }
  }
}