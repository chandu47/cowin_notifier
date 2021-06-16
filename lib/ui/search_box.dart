import 'dart:math';

import 'package:cowin_notifier/cubit/startup/startup_cubit.dart';
import 'package:cowin_notifier/cubit/startup/startup_state.dart';
import 'package:cowin_notifier/data/model/district.dart';
import 'package:cowin_notifier/data/model/location.dart';
import 'package:cowin_notifier/data/model/states.dart';
import 'package:cowin_notifier/ui/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  int _radioButtonVal;
  bool _validatePincode;
  DateTime _slotDate;
  Location lastLocation = Location(1, 1, "110004");

  @override
  void initState() {
    super.initState();
    _radioButtonVal = 0;
    _slotDate = DateTime.now();
    _validatePincode = false;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartupCubit, StartupState>(
        builder: (context, state){
            if(state is StartupLoadedState){
              if( (state).savedLocation != null){
                  lastLocation.residenceState = (state).savedLocation.residenceState ?? 1;
                  lastLocation.district = (state).savedLocation.district ?? 1;
                  lastLocation.pincode = (state).savedLocation.pincode ?? "110004";
              }
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: _buildSearchCard(context, (state).statesList),
              );
            }
            else
              return Container();
        },
        listener: (context, state){
            if(state is StartupErrorState){
              showDialog(
                  context: context,
                  builder: (context){
                    return ErrorDialog("Something went wrong. Please restart the app");
                  }
              );
            }
        }
    );
  }

  //Build the find slots card
  Widget _buildSearchCard(BuildContext context, List<States> states) =>
        SizedBox(
          height: min(500, MediaQuery.of(context).size.height - 150),
          child: Column(
            children: [
              SizedBox(height: 10,),
              //District search
              Expanded(flex: 1, child: _buildDistrictSearch(states)),
              SizedBox(height: 10),
              //Divider for District, pincode search
              Row(children: [
                  SizedBox(width: 30,),
                  Expanded(child: Divider(thickness: 2,)),
                  SizedBox(width: 5,),
                  Text("OR"),
                  SizedBox(width: 5,),
                  Expanded(child: Divider(thickness: 2,)),
                  SizedBox(width: 30,),
              ],),
              SizedBox(height: 10,),
              //Pincode Search
              Expanded(flex: 1, child: _buildPincodeSearch()),
              SizedBox(height: 15),
              //Calendar to select date
              Row(
                children: [
                  SizedBox(width: 50),
                  SizedBox(width: 150,
                  child: Text(_slotDate.day.toString()+"-"+_slotDate.month.toString()+"-"+_slotDate.year.toString(), style: TextStyle(fontSize: 19),),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                      color: Colors.amber[700],
                      focusColor: Colors.amber[800],
                      icon: Icon(Icons.calendar_today_outlined),
                      onPressed:  () => _showCalendar(context)
                  ),
                ],
              ),
              SizedBox(width: 5),
              Row(children: [
                SizedBox(width: 10,),
                Expanded(child: Divider(thickness: 1,)),
                SizedBox(width: 10,),
              ],),
              SizedBox(width: 5),
              SizedBox(
                height: 60,
                child: Center(
                  child: ElevatedButton(child: Text("Find Slots"),),
                ),
              )
            ]),
        );


  //build find slots by district
  Widget _buildDistrictSearch(List<States> states){
      return Row(
        children: [
          SizedBox(width: 10,),
          SizedBox(width: 30,
            child: Radio(
              value: 0,
              groupValue: _radioButtonVal,
              onChanged: (val){
                setState(() {
                  _radioButtonVal = val;
                });
              },
            )),
          SizedBox(width: 20,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    DropdownButton(
                        focusColor: Colors.amber[600],
                        hint: Text("Select state"),
                        value: (lastLocation.residenceState).toString(),
                        items: states.map<DropdownMenuItem<String>>((States st){
                              return DropdownMenuItem(
                                  value: st.state_id.toString(),
                                  child: Text(st.state_name,style:TextStyle(color:Colors.black) ));
                        }).toList(),
                        onChanged: (String value) {
                          lastLocation.residenceState = int.parse(value);
                          lastLocation.district = states.firstWhere((st) => st.state_id == lastLocation.residenceState).districts[0].district_id;
                          BlocProvider.of<StartupCubit>(context).updateLocation(lastLocation);
                        },
                      onTap: (){
                          setState(() {
                            _radioButtonVal = 0;
                          });
                      },
                    ),
                  SizedBox(height: 10,),
                  DropdownButton(
                    focusColor: Colors.amber[600],
                    hint: Text("Select district"),
                    value: (lastLocation.district).toString(),
                    items: states.firstWhere((st) => st.state_id == lastLocation.residenceState).districts.map<DropdownMenuItem<String>>((District dt){
                      return DropdownMenuItem(
                          value: dt.district_id.toString(),
                          child: Text(dt.district_name,style:TextStyle(color:Colors.black) ));
                    }).toList(),
                    onChanged: (String value) {
                        lastLocation.district = int.parse(value);
                        BlocProvider.of<StartupCubit>(context).updateLocation(lastLocation);
                    },
                    onTap: () {
                      setState(() {
                        _radioButtonVal = 0;
                      });
                    },
                  )
                ],
              )
          )
        ],
      );
  }

  //Build find slots by pincode
  Widget _buildPincodeSearch(){
      return Row(
        children: [
          SizedBox(width: 10,),
          SizedBox(width: 30,
              child: Radio(
                value: 1,
                groupValue: _radioButtonVal,
                onChanged: (val){
                  setState(() {
                    _radioButtonVal = val;
                  });
                },
              )),
          SizedBox(width: 20,),
          Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: lastLocation.pincode,
                  hintText: "Enter Pincode",
                  errorText: _validatePincode ? 'Pincode should be six digits long' : null,
                ),
                onTap: (){
                  setState(() {
                    _radioButtonVal = 1;
                  });
                },
                onChanged: (text){
                  lastLocation.pincode = text;
                  BlocProvider.of<StartupCubit>(context).updateLocation(lastLocation);
                },
              )
          ),
          SizedBox(width: 30,)
        ],
      );
  }

  Future<void> _showCalendar(BuildContext context) async{
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _slotDate,
        firstDate: DateTime(_slotDate.year),
        lastDate: DateTime(2050));
        if (pickedDate != null && pickedDate != _slotDate)
            setState(() {
              _slotDate = pickedDate;
            });
        }
}
