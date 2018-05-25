import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(new MyApp());
} 
class MyApp extends StatefulWidget {
  
  // This widget is the root of your application.
  MyAppState createState() => MyAppState();
  
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar makeTabBar() {
    return TabBar(tabs: <Tab>[
      Tab(
        text: 'Kids',
      ),
      Tab(
        text: 'Meals',
      ),
      Tab(
        text: 'Teachers',
      ),
      Tab(
        text: 'Activities',
      ),
      Tab(
        text: 'Class',
      ),
      Tab(
        text: 'Other',
      ),
    ], controller: tabController,labelColor:Colors.deepPurple,indicatorColor:Colors.deepPurple);
  }

  TabBarView makeTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: makeTabBar(),
        ),
        body:makeTabBarView(<Widget>[TheGridView().build(), TheDropDownView().makeMenu(),SimpleWidget()]),
      ),
    );
  }
}

class SimpleWidget extends StatefulWidget {
  @override
  SimpleWidgetState createState() => SimpleWidgetState();
}

class SimpleWidgetState extends State<SimpleWidget> {
  int stepCounter = 0;
  List<Step> steps = [
    Step(
      title: Text("Step One"),
      content: Text("This is the first step"),
      isActive: true,
    ),
    Step(
      title: Text("Step Two"),
      content: Text("This is the second step"),
      isActive: true,
    ),
    Step(
      title: Text("Step Three"),
      content: Text("This is the Third step"),
      state: StepState.editing,
      isActive: true,
    ),
    Step(
      title: Text("Step Four"),
      content: Text("This is the fourth step"),
      isActive: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        currentStep: this.stepCounter,
        steps: steps,
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            stepCounter = step;
          });
        },
        onStepCancel: () {
          setState(() {
            stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
          });
        },
        onStepContinue: () {
          setState(() {
            stepCounter < steps.length - 1 ? stepCounter += 1 : stepCounter = 0;
          });
        },
      ),
    );
  }
}
 class TheDropDownView {
 DropdownButton makeMenu(){
   return DropdownButton<String>(
                items: <String>['Foo', 'Bar'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              );
 }
 
}
class TheGridView {
  

  Card makeGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          new CircleAvatar(
  backgroundImage: new NetworkImage('https://www.gstatic.com/webp/gallery3/1.png'),maxRadius: 100.0,),
          new Text(name,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 20.0, color: Colors.black87),overflow: TextOverflow.fade,),
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
        primary: true,
        padding: EdgeInsets.all(10.0),
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: <Widget>[
          makeGridCell("KID1", Icons.home),
          makeGridCell("KID2", Icons.email),
          makeGridCell("KID3", Icons.chat_bubble),
          makeGridCell("KID4", Icons.new_releases),
          makeGridCell("Kid5", Icons.network_wifi),
          makeGridCell("Kid6", Icons.settings),
        ]);
  }
}