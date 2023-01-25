import 'package:flutter/material.dart';
import 'package:hcdv_app/enum/app-enum.dart';
import 'package:hcdv_app/screen/coupe_screen.dart';
import 'package:hcdv_app/screen/ligue1_screen.dart';
import 'package:hcdv_app/screen/u13a_screen.dart';
import 'package:hcdv_app/screen/u13top_screen.dart';
import 'package:hcdv_app/screen/u15_screen.dart';
import 'package:hcdv_app/screen/u17_screen.dart';
import 'package:hcdv_app/screen/u20_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Navigation Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //int _typeMatchScreen = 0;
  //int _leagueMatchScreen = 0;

  late TypeMatch _typeMatch;
  late Ligue _ligue;

  late TabController _typeStatsTopTabController;
  late TabController _leagueBottomTabController;

  @override
  void initState() {
    super.initState();

    _typeMatch = TypeMatch.championnat;
    _ligue = Ligue.ligue1;

    _typeStatsTopTabController =
        TabController(length: TypeStats.values.length, vsync: this);
    _leagueBottomTabController =
        TabController(length: Ligue.values.length, vsync: this);
    /*
    _leagueBottomTabController.addListener(() {
      print('State change ${_ligue.label}');
    });
    */
  }

  bool isTypeMatchChampionnat(TypeMatch typeMatch) {
    return typeMatch == TypeMatch.championnat;
  }

  Widget getLeaguePage(int index) {
    switch (Ligue.values[index]) {
      case Ligue.ligue1:
        return Ligue1Page(TypeStats.values[_typeStatsTopTabController.index]);

      case Ligue.u20:
        return U20LiguePage(TypeStats.values[_typeStatsTopTabController.index]);

      case Ligue.u17:
        return U17LiguePage(TypeStats.values[_typeStatsTopTabController.index]);

      case Ligue.u15:
        return U15LiguePage(TypeStats.values[_typeStatsTopTabController.index]);

      case Ligue.u13top:
        return U13topLiguePage(
            TypeStats.values[_typeStatsTopTabController.index]);

      case Ligue.u13a:
        return U13aLiguePage(
            TypeStats.values[_typeStatsTopTabController.index]);

      default:
        return Center(
          child: Text(
              '${Ligue.values[index].label} - ${TypeStats.values[_typeStatsTopTabController.index].label} - ${_typeMatch.label}'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /***** Main App Bar *****/
        appBar: AppBar(
          title: const Text('HCDV - GameCenter'),
          /*** Type Stats TabBar ***/
          bottom: isTypeMatchChampionnat(_typeMatch)
              ? TabBar(
                  controller: _typeStatsTopTabController,
                  /**  Tabs type de stats **/
                  tabs: List<Widget>.generate(TypeStats.values.length, (index) {
                    return Tab(
                      height: 50,
                      text: TypeStats.values[index].label,
                      icon: const Icon(
                        Icons.cloud_outlined,
                        size: 10,
                      ),
                    );
                  }),
                )
              : PreferredSize(
                  child: Container(), preferredSize: Size.fromHeight(0)),
        ),
        /***** League Bar *****/
        body: TabBarView(
          controller: _leagueBottomTabController,
          children: List<Widget>.generate(Ligue.values.length, (int index) {
            if (isTypeMatchChampionnat(_typeMatch)) {
              getLeaguePage(index);
            } else {
              return const CoupePage();
            }
          }),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Theme.of(context).primaryColor,
              //*** League TabBar  ***/
              child: isTypeMatchChampionnat(_typeMatch)
                  ? TabBar(
                      controller: _leagueBottomTabController,
                      onTap: (index) {
                        setState(() {
                          _ligue = Ligue.values[index];
                        });
                      },
                      isScrollable: true,
                      tabs: List.generate(Ligue.values.length, (index) {
                        return Tab(text: Ligue.values[index].label);
                      }),
                    )
                  : Container(),
            ),
            /*** Cintainer vide pour choix coupe ***/
            BottomNavigationBar(
              currentIndex: _typeMatch.index,
              onTap: (int index) {
                setState(() {
                  _typeMatch = TypeMatch.values[index];
                });
              },
              items: List<BottomNavigationBarItem>.generate(
                  TypeMatch.values.length, (index) {
                return BottomNavigationBarItem(
                  icon: const Icon(Icons.airplanemode_active),
                  label: TypeMatch.values[index].label,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
