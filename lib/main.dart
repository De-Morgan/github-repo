import 'package:flutter/material.dart';
import 'package:githubrepo/core/model/githup_repo.dart';

import 'core/data_provider/github_api.dart';
import 'core/repository/githup_repo_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Repos',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Repos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: GithubRepoRepository().getGithubRepo(),
          builder:
              (BuildContext context, AsyncSnapshot<List<GithubRepo>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: CircularProgressIndicator(),
                alignment: FractionalOffset.center,
              );
            }
            final githubreps = snapshot.data;
            return ListView.builder(
              itemCount: githubreps.length,
              itemBuilder: (BuildContext context, int index) {
                final githubrep = githubreps[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${githubrep.full_name}",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(" Repo owner id ${githubrep.full_name}"),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
