import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:td2/UI/ecranSettings.dart';
import '../viewModel/settingsViewModel.dart';
import '../viewModel/taskViewModel.dart';
import 'formTask.dart';
import 'ecran1.dart';
import 'ecran2.dart';
import 'ecran3.dart';
import 'mytheme.dart';

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp(this.database, {super.key});
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_){
              SettingViewModel settingViewModel = SettingViewModel();
              return settingViewModel;
            }),
        ChangeNotifierProvider(
            create:(_){
              TaskViewModel taskViewModel = TaskViewModel(database);
              taskViewModel.generateTasks();
              return taskViewModel;
            } )
      ],
      child: Consumer<SettingViewModel>(
        builder: (context,SettingViewModel notifier,child){
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark():MyTheme.light(),
              title: 'TD2',
            home: const MyHomePage(title: "TD2"),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> pages = <Widget>[
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
    EcranSettings(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex==0?FloatingActionButton(
        onPressed: (){Navigator.push(context, MaterialPageRoute(
          builder: (context) => FormTask(),
        )
        );},
        child: const Icon(Icons.add),):const SizedBox.shrink(),
      appBar: AppBar(
        title: Text("TD2", style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 1'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 2'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Ecran 3'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label:'Settings' ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
