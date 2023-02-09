import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_info/git_info.dart';

import '../enum/app-color.dart';

class AppInfosPage extends StatelessWidget {
  const AppInfosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            /***** Main App Bar *****/
            appBar: AppBar(
              leading: BackButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.black),
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            body: SizedBox(
              height: 200,
              child: Card(
                shadowColor: Colors.red,
                child: FutureBuilder<GitInformation>(
                  future: GitInfo.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Branch: ${snapshot.data!.branch}'),
                            Text('Hash: ${snapshot.data!.hash}'),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            )));
  }
}
