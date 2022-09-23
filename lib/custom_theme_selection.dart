import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomThemeSelection extends StatefulWidget {
  final User user;
  const CustomThemeSelection(this.user, {Key? key}) : super(key: key);

  @override
  _CustomThemeSelectionState createState() => _CustomThemeSelectionState();
}

class _CustomThemeSelectionState extends State<CustomThemeSelection> {
  List<double> background = [255, 0, 0, 0];
  List<double> nonInteractive = [255, 0, 150, 255];
  List<double> interactive = [255, 255, 115, 0];

  void click() {
    MyThemeData().setTheme(widget.user.uid, 'custom',
        newCustom: [background, nonInteractive, interactive]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(background[0].toInt(),
          background[1].toInt(), background[2].toInt(), background[3].toInt()),
      appBar: AppBar(
        title: const Text('Custom Theme Selection'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(children: [
                Text(
                  'Background: ',
                  style: TextStyle(
                      color: Color.fromARGB(
                          nonInteractive[0].toInt(),
                          nonInteractive[1].toInt(),
                          nonInteractive[2].toInt(),
                          nonInteractive[3].toInt())),
                ),
                Column(children: [
                  Row(
                    children: [
                      Slider(
                          thumbColor: Color.fromARGB(
                              nonInteractive[0].toInt(),
                              nonInteractive[1].toInt(),
                              nonInteractive[2].toInt(),
                              nonInteractive[3].toInt()),
                          activeColor: Color.fromARGB(
                              interactive[0].toInt(),
                              interactive[1].toInt(),
                              interactive[2].toInt(),
                              interactive[3].toInt()),
                          value: background[0],
                          max: 255,
                          divisions: 255,
                          label: background[0].round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              background[0] = value;
                            });
                          }),
                      Text(
                        background[0].round().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt())),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Slider(
                          thumbColor: Color.fromARGB(
                              nonInteractive[0].toInt(),
                              nonInteractive[1].toInt(),
                              nonInteractive[2].toInt(),
                              nonInteractive[3].toInt()),
                          activeColor: Color.fromARGB(
                              interactive[0].toInt(),
                              interactive[1].toInt(),
                              interactive[2].toInt(),
                              interactive[3].toInt()),
                          value: background[1],
                          max: 255,
                          divisions: 255,
                          label: background[1].round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              background[1] = value;
                            });
                          }),
                      Text(
                        background[1].round().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt())),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Slider(
                          thumbColor: Color.fromARGB(
                              nonInteractive[0].toInt(),
                              nonInteractive[1].toInt(),
                              nonInteractive[2].toInt(),
                              nonInteractive[3].toInt()),
                          activeColor: Color.fromARGB(
                              interactive[0].toInt(),
                              interactive[1].toInt(),
                              interactive[2].toInt(),
                              interactive[3].toInt()),
                          value: background[2],
                          max: 255,
                          divisions: 255,
                          label: background[2].round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              background[2] = value;
                            });
                          }),
                      Text(
                        background[2].round().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt())),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Slider(
                          thumbColor: Color.fromARGB(
                              nonInteractive[0].toInt(),
                              nonInteractive[1].toInt(),
                              nonInteractive[2].toInt(),
                              nonInteractive[3].toInt()),
                          activeColor: Color.fromARGB(
                              interactive[0].toInt(),
                              interactive[1].toInt(),
                              interactive[2].toInt(),
                              interactive[3].toInt()),
                          value: background[3],
                          max: 255,
                          divisions: 255,
                          label: background[3].round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              background[3] = value;
                            });
                          }),
                      Text(
                        background[3].round().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt())),
                      ),
                    ],
                  )
                ])
              ]),
              Row(children: [
                Text(
                  'Noninteractive: ',
                  style: TextStyle(
                      color: Color.fromARGB(
                          nonInteractive[0].toInt(),
                          nonInteractive[1].toInt(),
                          nonInteractive[2].toInt(),
                          nonInteractive[3].toInt())),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Slider(
                            value: nonInteractive[0],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: nonInteractive[0].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                nonInteractive[0] = value.round().toDouble();
                              });
                            }),
                        Text(
                          nonInteractive[0].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: nonInteractive[1],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: nonInteractive[1].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                nonInteractive[1] = value.round().toDouble();
                              });
                            }),
                        Text(
                          nonInteractive[1].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: nonInteractive[2],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: nonInteractive[2].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                nonInteractive[2] = value.round().toDouble();
                              });
                            }),
                        Text(
                          nonInteractive[2].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: nonInteractive[3],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: nonInteractive[3].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                nonInteractive[3] = value.round().toDouble();
                              });
                            }),
                        Text(
                          nonInteractive[3].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    )
                  ],
                )
              ]),
              Row(children: [
                Text(
                  'Interactive: ',
                  style: TextStyle(
                      color: Color.fromARGB(
                          nonInteractive[0].toInt(),
                          nonInteractive[1].toInt(),
                          nonInteractive[2].toInt(),
                          nonInteractive[3].toInt())),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Slider(
                            value: interactive[0],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: interactive[0].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                interactive[0] = value.round().toDouble();
                              });
                            }),
                        Text(
                          interactive[0].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: interactive[1],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: interactive[1].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                interactive[1] = value.round().toDouble();
                              });
                            }),
                        Text(
                          interactive[1].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: interactive[2],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: interactive[2].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                interactive[2] = value.round().toDouble();
                              });
                            }),
                        Text(
                          interactive[2].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Slider(
                            value: interactive[3],
                            thumbColor: Color.fromARGB(
                                nonInteractive[0].toInt(),
                                nonInteractive[1].toInt(),
                                nonInteractive[2].toInt(),
                                nonInteractive[3].toInt()),
                            activeColor: Color.fromARGB(
                                interactive[0].toInt(),
                                interactive[1].toInt(),
                                interactive[2].toInt(),
                                interactive[3].toInt()),
                            label: interactive[3].round().toString(),
                            max: 255,
                            divisions: 255,
                            onChanged: (double value) {
                              setState(() {
                                interactive[3] = value.round().toDouble();
                              });
                            }),
                        Text(
                          interactive[3].toString(),
                          style: TextStyle(
                              color: Color.fromARGB(
                                  nonInteractive[0].toInt(),
                                  nonInteractive[1].toInt(),
                                  nonInteractive[2].toInt(),
                                  nonInteractive[3].toInt())),
                        )
                      ],
                    )
                  ],
                )
              ]),
              TextButton(
                  onPressed: click,
                  child: Text(
                    'Set',
                    style: TextStyle(
                      color: Color.fromARGB(
                          interactive[0].toInt(),
                          interactive[1].toInt(),
                          interactive[2].toInt(),
                          interactive[3].toInt()),
                    ),
                  ))
            ],
          )),
    );
  }
}
