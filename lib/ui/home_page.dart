import 'package:cowin_notifier/cubit/startup/startup_cubit.dart';
import 'package:cowin_notifier/cubit/startup/startup_state.dart';
import 'package:cowin_notifier/ui/error_dialog.dart';
import 'package:cowin_notifier/ui/notification_page.dart';
import 'package:cowin_notifier/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _pages;
  int _selectedPageIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
     _pages = <Widget>[
        SearchPage(),
        NotificationPage()
    ];
    _selectedPageIndex = 0;
    _pageController = PageController(initialPage: _selectedPageIndex);

    //show loading dialog
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showLoadingDialog("Starting the app");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    //print(StartupInitiatedState()==StartupLoadingState());
    return Scaffold(
      body: BlocConsumer<StartupCubit, StartupState>(
          listenWhen: (prev, curr) => (prev is StartupLoadingState) && (curr is StartupLoadedState || curr is StartupErrorState),
          listener: (context, state){
            if(state is StartupLoadingState){
              //show app starting dialog
              _showLoadingDialog("Starting the app");
            }
            else if(state is StartupLoadedState){
              //dismiss alert dialog
              //
              Navigator.of(context).pop();
            }
            else{
              //something went wrong dialog
              Navigator.of(context).pop();
              _showAlertDialog("Something went wrong");
            }
          },
        builder: (context, state){
            if(state is StartupLoadedState){
              return SafeArea(
                child: PageView(
                  controller: _pageController,
                  children: _pages,
                ),
              );
            }
            else return Container();
          },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.notification_important), label: "Notifications")
        ],
        selectedItemColor: Colors.amber[800],
        onTap: _onBottomNavTapped,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onBottomNavTapped(int index){
    setState(() {
      _selectedPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _showLoadingDialog(String text){
    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context){
         return Dialog(
           child: SizedBox(
             height: 100,
             width: 200,
             child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   CircularProgressIndicator(),
                   Center(child: Text(text = text),)
                 ]
             ),
           ),
         );
        });
  }

  void _showAlertDialog(String text){
    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context){
          return ErrorDialog(text);
        });
  }

}