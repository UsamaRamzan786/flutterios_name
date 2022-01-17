import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
];

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        backgroundColor: Colors.white,
        elevation: 5,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Dark Mode'),
                trailing: GFToggle(
                  enabledThumbColor: Colors.amber,
                  disabledThumbColor: Colors.grey,
                  onChanged: (val) => {
                    if (val == true)
                      {
                        Get.changeTheme(ThemeData.dark()),
                      },
                    if (val == false) {Get.changeTheme(ThemeData.light())}
                  },
                  value: true,
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Android View'),
                trailing: GFToggle(
                  enabledThumbColor: Colors.amber,
                  disabledThumbColor: Colors.grey,
                  onChanged: (val) => {Get.changeTheme(ThemeData.light())},
                  value: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
