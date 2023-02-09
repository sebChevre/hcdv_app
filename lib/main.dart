import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcdv_app/screen/coupe_screen.dart';
import 'package:hcdv_app/screen/ligue1_playoff_out_screen.dart';
import 'package:hcdv_app/screen/ligue1_screen.dart';
import 'package:hcdv_app/screen/ranking.dart';
import 'package:hcdv_app/screen/u13a_screen.dart';
import 'package:hcdv_app/screen/u13top_screen.dart';
import 'package:hcdv_app/screen/u15_screen.dart';
import 'package:hcdv_app/screen/u17_screen.dart';
import 'package:hcdv_app/screen/u20_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'enum/app-color.dart';
import 'model/ligue.dart';
import 'model/type-match.dart';
import 'model/type-stats.dart';

Future<void> main() async {
  initializeDateFormatting("fr_CH");

  await dotenv.load();

  runApp(const HCDVApp());
  CacheManager.logLevel = CacheManagerLogLevel.verbose;
}

class HCDVApp extends StatelessWidget {
  const HCDVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HCDV - GameCenter',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TypeMatch _typeMatch;
  late TypeStats _typeStats;
  late Ligue _ligue;

  late TabController _typeMatchsTopTabController;
  late TabController _leagueBottomTabController;

  @override
  void initState() {
    super.initState();
    _typeMatch = TypeMatch.championnat;
    _typeStats = TypeStats.matchs;
    _ligue = Ligue.ligue1;

    _typeMatchsTopTabController =
        TabController(length: TypeStats.values.length, vsync: this);
    _leagueBottomTabController =
        TabController(length: Ligue.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /***** Main App Bar *****/
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: AppColor.main_red,
            title: Row(
              children: [
                Column(
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "hcdv_logo.png",
                          height: 60,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 30)),
                        const Text(
                          'HCDV - GameCenter',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            /*** Type Stats TabBar ***/
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: _typeMatchsTopTabController,
              onTap: (index) {
                print('TypeMatchs tap, index: ${index}');
                setState(() {
                  _typeMatch = TypeMatch.values[index];
                });
              },
              /**  Tabs type de stats **/
              tabs: List<Widget>.generate(_ligue.typesMatch.length, (index) {
                return Tab(
                  height: 65,
                  text: TypeMatch.values[index].label,
                  icon: Image.asset(TypeMatch.values[index].image,
                      height: 35,
                      color: _typeMatchsTopTabController.index == index
                          ? Colors.white
                          : Colors.black),
                );
              }),
            )),

        /***** League Bar - Barre de choix des leagues *****/
        body: TabBarView(
          controller: _leagueBottomTabController,
          children: List<Widget>.generate(Ligue.values.length, (int index) {
            if (_typeMatch == TypeMatch.coupe) {
              return CoupePage();
            }

            //test sur la valeur de la ligue choisie
            switch (Ligue.values[index]) {
              case Ligue.ligue1:
                if (_typeStats == TypeStats.classement) {
                  return RankingScreen(Ligue.ligue1, _typeMatch);
                } else if (_typeMatch == TypeMatch.championnat) {
                  return Ligue1Page(_typeStats);
                } else {
                  return Ligue1PlayOffOutPage(_typeStats);
                }

              case Ligue.u20:
                if (_typeStats == TypeStats.classement) {
                  return _typeMatch == TypeMatch.championnat
                      ? RankingScreen(Ligue.u20, _typeMatch)
                      : noPlayOffCards();
                } else if (_typeMatch == TypeMatch.championnat) {
                  return U20LiguePage(_typeStats);
                } else {
                  return noPlayOffCards();
                }

              case Ligue.u17:
                if (_typeStats == TypeStats.classement) {
                  return _typeMatch == TypeMatch.championnat
                      ? RankingScreen(Ligue.u17, _typeMatch)
                      : noPlayOffCards();
                } else if (_typeMatch == TypeMatch.championnat) {
                  return U17LiguePage(_typeStats);
                } else {
                  return noPlayOffCards();
                }

              case Ligue.u15:
                if (_typeStats == TypeStats.classement) {
                  return _typeMatch == TypeMatch.championnat
                      ? RankingScreen(Ligue.u15, _typeMatch)
                      : noPlayOffCards();
                } else if (_typeMatch == TypeMatch.championnat) {
                  return U15LiguePage(_typeStats);
                } else {
                  return noPlayOffCards();
                }

              case Ligue.u13top:
                if (_typeStats == TypeStats.classement) {
                  return _typeMatch == TypeMatch.championnat
                      ? noClassementCards()
                      : noPlayOffCards();
                } else if (_typeMatch == TypeMatch.championnat) {
                  return U13TopLiguePage(_typeStats);
                } else {
                  return noPlayOffCards();
                }

              case Ligue.u13a:
                if (_typeStats == TypeStats.classement) {
                  return _typeMatch == TypeMatch.championnat
                      ? noClassementCards()
                      : noPlayOffCards();
                } else if (_typeMatch == TypeMatch.championnat) {
                  return U13ALiguePage(_typeStats);
                } else {
                  return noPlayOffCards();
                }
              default:
                return Center(
                  child: Text(
                      '${Ligue.values[index].label} - ${_typeStats.label} - ${_typeMatch.label}'),
                );
            }
          }),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.black,
              //*** League TabBar  ***/
              child: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.white,
                controller: _leagueBottomTabController,
                onTap: (index) {
                  setState(() {
                    _ligue = Ligue.values[index];
                    print(_ligue.label);
                    print('League button click, index: ${index}');
                  });
                },
                isScrollable: true,
                tabs: List.generate(Ligue.values.length, (index) {
                  return Tab(text: Ligue.values[index].label);
                }),
              ),
            ),
            /*** Cintainer vide pour choix coupe ***/

            BottomNavigationBar(
              backgroundColor: AppColor.main_red,
              selectedItemColor: Colors.white,
              currentIndex: _typeStats.index,
              onTap: (int index) {
                setState(() {
                  _typeStats = TypeStats.values[index];
                });
              },
              items: List<BottomNavigationBarItem>.generate(
                  TypeStats.values.length, (index) {
                return BottomNavigationBarItem(
                  icon: TypeStats.values[index].icon,
                  label: TypeStats.values[index].label,
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Card noPlayOffCards() {
    return const Card(
        color: Color.fromARGB(255, 206, 39, 27),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  "Aucun playoffs prévus actuellement",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ))));
  }

  Card noClassementCards() {
    return const Card(
        color: Color.fromARGB(255, 206, 39, 27),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  "Pas de classement pour cette catégorie de jeu",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ))));
  }
}
