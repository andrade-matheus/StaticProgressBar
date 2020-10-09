import 'package:flutter/material.dart';
import 'package:progress_bar/progress_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Static Progress Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Test Progress Bar'),
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
  double percent = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 3),
              StaticProgressBar(
                percent: 0.8,
                width: 250,
                height: 50,
                backgroundColor: Colors.black12,
                progressColor: Colors.blue,
                centerText: Text("80 %"),
                animation: true,
                animationDuration: 1000,
              ),
              Spacer(flex: 1),
              StaticProgressBar(
                percent: 0.5,
                width: 250,
                height: 50,
                backgroundColor: Colors.black12,
                progressColor: Colors.blue,
                centerText: Text("5 / 10"),
                animation: true,
                animationDuration: 1000,
              ),
              Spacer(flex: 3),
            ],
          ),
        ));
  }
}
