import 'dart:ui';
import 'dart:io' show Platform;
import 'package:crypto_app/services/get_api.dart';
import 'package:crypto_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool _isVisible = true;
ScrollController? controller;
GetAPI get = GetAPI();
Color? color;
var rate, time;
String dropdownValue = 'USD';
int _selectedIndex = 0;
final list = ['USD', 'INR', 'PKR', 'EURO'];
bool? type;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      type = false;
    }
    if (Platform.isIOS) {
      type = false;
    }

    controller = ScrollController();
    controller!.addListener(() {
      setState(() {
        _isVisible =
            controller!.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Crypto App"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const Settings());
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: get.apiData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: color,
                              child:
                                  Text(snapshot.data![index]['id'].toString()),
                              radius: 20,
                            ),
                            title: Text(
                              snapshot.data![index]['name'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index]['username'])
                                  // Text(
                                  //   "\$ ${snapshot.data['rate'].round()}",
                                  //   style: TextStyle(fontSize: 15),
                                  // ),
                                  // Text(
                                  //   snapshot.data['time']
                                  //       .substring(11, 17)
                                  //       .toString(),
                                  //   style: const TextStyle(
                                  //       fontSize: 15, color: Colors.red),
                                  // ),
                                ]),
                          );
                        });
                  } else {
                    return Container(child: const Text('No'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Offstage(
        offstage: _isVisible,
        child: BottomAppBar(
          child: type == true
              ? Container(
                  margin: EdgeInsets.fromLTRB(150, 10, 20, 20),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 26,
                    elevation: 30,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Container(
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        dropdownValue = value.toString();
                      });
                    },
                    itemExtent: 40.0,
                    children: const [
                      Text(
                        'USD',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'INR',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'PKR',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'EURO',
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
