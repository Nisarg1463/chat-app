// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:chat_app/database.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  List<List<double>> dark = [
    [255, 0, 0, 0],
    [255, 0, 150, 255],
    [255, 255, 128, 0],
  ];
  List<List<double>> light = [
    [255, 255, 255, 255],
    [255, 0, 200, 255],
    [255, 255, 192, 0],
  ];
  static List<List<double>> custom = [];
  static List<Color> current = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  void loadTheme(String name, {List<List<double>>? custom}) {
    if (name == 'dark') {
      custom = dark;
    }
    current = [Colors.black, Colors.black, Colors.black, Colors.black];
    List<int> last = [];
    current[0] = Color.fromARGB(custom![0][0].toInt(), custom[0][1].toInt(),
        custom[0][2].toInt(), custom[0][3].toInt());
    current[1] = Color.fromARGB(custom[1][0].toInt(), custom[1][1].toInt(),
        custom[1][2].toInt(), custom[1][3].toInt());
    current[2] = Color.fromARGB(custom[2][0].toInt(), custom[2][1].toInt(),
        custom[2][2].toInt(), custom[2][3].toInt());
    custom[0].forEach((element) {
      if (element > 127) {
        last.add(element.toInt() - 10);
      } else {
        last.add(element.toInt() + 10);
      }
    });
    current[3] = Color.fromARGB(last[0], last[1], last[2], last[3]);
  }

  void setTheme(String uid, String name, {List<List<double>>? newCustom}) {
    if (name == 'light') {
      custom = light;
    } else if (name == 'dark') {
      custom = dark;
    } else if (name == 'custom') {
      if (newCustom != null) {
        custom = newCustom;
      }
    }
    List<int> last = [];
    current[0] = Color.fromARGB(custom[0][0].toInt(), custom[0][1].toInt(),
        custom[0][2].toInt(), custom[0][3].toInt());
    current[1] = Color.fromARGB(custom[1][0].toInt(), custom[1][1].toInt(),
        custom[1][2].toInt(), custom[1][3].toInt());
    current[2] = Color.fromARGB(custom[2][0].toInt(), custom[2][1].toInt(),
        custom[2][2].toInt(), custom[2][3].toInt());
    custom[0].forEach((element) {
      if (element > 127) {
        last.add(element.toInt() + 10);
      } else {
        last.add(element.toInt() - 10);
      }
    });
    current[3] = Color.fromARGB(last[0], last[1], last[2], last[3]);
    updateThemePref(uid, custom);
  }
}
