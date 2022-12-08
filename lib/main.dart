import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'One.dart';
import 'package:flutter/services.dart';

import 'Two.dart';

void main() {
  runApp(const MyApp());
}

class Five {
  List<Blade> bladeList;

  Five({
    required this.bladeList,
  });

  factory Five.fromJson(Map<String, dynamic> json) {
    var list = json['blades'] as List;
    List<Blade> bladeList;
    bladeList = list.map((e) => Blade.fromJson(e)).toList();
    return Five(bladeList: bladeList);
  }
}

class Blade {
  String acquisition;
  String uid;
  String weapon;

  Blade({
    required this.acquisition,
    required this.uid,
    required this.weapon,
  });

  factory Blade.fromJson(Map<String, dynamic> json) {
    return Blade(
      acquisition: json['acquisition'],
      uid: json['uid'],
      weapon: json['weapon'],
    );
  }
}

class Four {
  final int id;
  final String flight_name;
  final List<Passenger> passengers;
  final List<OtherPeople> other_people;

  Four({
    required this.other_people,
    required this.id,
    required this.flight_name,
    required this.passengers,
  });

  factory Four.fromJson(Map<String, dynamic> json) {
    //enter exact json identifier Name!!
    var listOther = json['other_people'] as List;
    List<OtherPeople> otherPeopleList = listOther
        .map((other_people) => OtherPeople.fromJson(other_people))
        .toList();

    var list = json['passengers'] as List;
    List<Passenger> passengerList =
        list.map((passengers) => Passenger.fromJson(passengers)).toList();

    //declare and initialize List before return
    return Four(
      id: json['id'],
      flight_name: json['flight_name'],
      passengers: passengerList,
      other_people: otherPeopleList,
    );
  }
}

class Passenger {
  int id;
  int check_bags;

  Passenger({
    required this.id,
    required this.check_bags,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id'],
      check_bags: json['check_bags'],
    );
  }
}

class OtherPeople {
  int id;

  OtherPeople({required this.id});

  factory OtherPeople.fromJson(Map<String, dynamic> json) {
    return OtherPeople(id: json['id']);
  }
}

// class Property {
//   double width;
//   double height;
//
//   Property({
//     required this.width,
//     required this.height,
//   });
//
//   factory Property.fromJson(Map<String, dynamic> json) {
//     return Property(
//       width: json['width'],
//       height: json['height'],
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//run future everytime homepage runs
Future<String> _loadFile() async {
  return await rootBundle.loadString('assets/bladeData.json');
}

class _MyHomePageState extends State<MyHomePage> {
  // Future loadData() async {
  //   String jsonString = await _loadData();
  //   final jsonResponse = json.decode(jsonString);
  //   One one = One.fromJson(jsonResponse);
  //
  //   print('${one.id}-${one.name}-${one.gender}');
  // }

  //TWO//
  // Future loadData() async {
  //   String jsonString = await _loadData();
  //   final jsonResponse = json.decode(jsonString);
  //   Two two = Two.fromJson(jsonResponse);
  //
  //   var newTwoList = [];
  //   for (var obj in two.classes) {
  //     newTwoList.add(obj);
  //     print(obj);
  //   }
  //   print('${two.name}-${two.classes}');
  //   print('${two.classes[2]}');
  //   print(newTwoList);
  // }

  // Future loadData() async {
  //   String jsonString = await _loadData();
  //   final jsonResponse = json.decode(jsonString);
  //   Three three = Three.fromJson(jsonResponse);
  //
  //   print('${three.name}');
  //   print('${three.id}');
  //   print('${three.property.width}');
  //   print('${three.property.height}');
  //   print('${three.property}');
  // }

  Future loadData() async {
    String jsonStringFromFile = await _loadFile();
    final jsonDecode = json.decode(jsonStringFromFile);

    return jsonDecode;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    //call loadata again
    return Scaffold(
      appBar: AppBar(title: Text('Blade List')),
      body: Center(
        //run loadfile method here and call it with snapshot
        child: FutureBuilder<String>(
          future: _loadFile(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            final jsonDecode = json.decode(snapshot.data!);
            Five five = Five.fromJson(jsonDecode);
            {
              return (ListView.builder(
                  itemCount: five.bladeList.length,
                  itemBuilder: (context, index) {
                    var listLength = index + 1;
                    return Card(margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      color: Colors.red,
                      elevation: 5,
                      child: Column(
                        children: [
                          Image.network(five.bladeList[index].acquisition),
                          ListTile(
                            trailing: Text(
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                '$listLength'),
                            subtitle: Text(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white70),
                                five.bladeList[index].weapon),
                            title: Text(
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                '${five.bladeList[index].uid.substring(3).toUpperCase()}'),
                            selectedColor: Colors.red,
                          ),
                        ],
                      ),
                    );
                  }));
            }
          },
        ),
      ),
    );
  }
}
