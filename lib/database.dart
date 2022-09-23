// ignore_for_file: avoid_function_literals_in_foreach_calls, void_checks
import 'dart:core';

import 'package:chat_app/chat.dart';
import 'package:chat_app/message.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;
DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

Map<dynamic, dynamic> names = {};
Map<dynamic, dynamic> prefMap = {};
List<dynamic> result = [];

void addUser(User user) async {
  Query query = databaseReference.child('users/').orderByValue();

  DataSnapshot snapshot = await query.ref.get();
  bool notFound = true;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> users = snapshot.value as Map;
    users.forEach((key, value) {
      if (value == user.email) {
        notFound = false;
      }
    });
    if (notFound) {
      var id = databaseReference.child('users/').push();
      id.set(user.email);
      id = databaseReference.child('user-id-map/').push();
      id.set(<String>[user.email!, user.displayName!, user.uid]);
    }
  } else {
    var id = databaseReference.child('users/').push();
    id.set(user.email);
    id = databaseReference.child('user-id-map/').push();
    id.set(<String>[user.email!, user.displayName!, user.uid]);
  }
}

Future<bool> findUser(String user) async {
  Query query = databaseReference.child('users/').equalTo(user);
  DataSnapshot snapshot = await query.ref.get();
  var found = false;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> values = snapshot.value as Map;
    values.forEach((key, value) {
      if (value == user) {
        found = true;
      }
    });
  }
  return found;
}

void getChatWith(String from, String to) async {
  Query query = databaseReference.child('chats/').orderByValue();
  DataSnapshot snapshot = await query.ref.get();
  List<String> list = [to, from];
  list.sort((a, b) => a.compareTo(b));
  Map struct = {
    'users': list,
    'lastUpdate': DateTime.now().toString(),
    'type': 'private',
  };
  bool found = false;
  if (snapshot.value != null) {
    Map<dynamic, dynamic> values = snapshot.value as Map;
    values.forEach((key, value) {
      var users = value['users'];
      if (users[0] == list[0] && users[1] == list[1]) {
        found = true;
      }
    });
    if (!found) {
      var id = databaseReference.child('chats/').push();
      id.set(struct);
    }
  } else {
    var id = databaseReference.child('chats/').push();
    id.set(struct);
  }
}

Future<void> loadNames() async {
  Query query = databaseReference.child('user-id-map/').orderByValue();
  DataSnapshot snapshot = await query.ref.get();
  Map<dynamic, dynamic> data = snapshot.value as Map;
  data.forEach((key, value) {
    names[value[0]] = [value[1], value[2]];
  });
}

String? getName(String email) {
  if (names[email] != null) {
    return names[email][0];
  }
  return ' ';
}

Future<void> getChats(String of, List<Chat> chats, String uid) async {
  Query query = databaseReference.child('chats/').orderByValue();
  DataSnapshot snapshot = await query.ref.get();
  DataSnapshot snapshot2 =
      await databaseReference.child('chats-pending/').get();
  if (snapshot.value != null) {
    Map<dynamic, dynamic> data = snapshot.value as Map;
    data.forEach((key, value) {
      List<dynamic> users = value['users'];
      List<String> userList = [];
      users.forEach((element) {
        userList.add(element.toString());
      });
      userList.remove(of);
      int pending = 0;
      if (snapshot2.value != null) {
        Map pendingData = snapshot2.value as Map;
        pendingData.forEach((key2, value2) {
          if (key2 == key && value2 != null) {
            if (value2[uid] != null) {
              pending = value2[uid];
            }
          }
        });
      }
      if (value['type'] == 'private') {
        if (users[0] == of) {
          Chat chat = Chat();
          var name = getName(users[1]);
          chat.set(key, name!, DateTime.parse(value['lastUpdate']), userList,
              pending);
          chats.add(chat);
        } else if (users[1] == of) {
          Chat chat = Chat();
          var name = getName(users[0]);
          chat.set(key, name!, DateTime.parse(value['lastUpdate']), userList,
              pending);
          chats.add(chat);
        }
      } else if (value['type'] == 'group') {
        bool found = false;
        users.forEach((element) {
          if (element == of) {
            found = true;
            return;
          }
        });
        if (found) {
          Chat chat = Chat();
          chat.set(key, value['title'], DateTime.parse(value['lastUpdate']),
              userList, pending);
          chats.add(chat);
        }
      }
    });
    chats.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
  }
}

Future<List<Message>?> getMessages(String id) async {
  DataSnapshot snapshot = await databaseReference.child('chats/$id').ref.get();
  if (snapshot.value != null) {
    Map data = snapshot.value as Map;
    List<Message> messages = [];
    List? chatData = data['chat'];
    if (chatData != null) {
      chatData.forEach((element) {
        Message message = Message();
        Map map = element as Map;
        message.toMessage(map);
        messages.add(message);
      });
    }
    return messages;
  }
}

void updateChat(String id, Message message) async {
  DataSnapshot snapshot = await databaseReference.child('chats/$id').ref.get();
  Map map = snapshot.value as Map;
  bool found = false;
  map.keys.forEach((element) {
    if ('chat' == element) {
      List<dynamic> op = List<dynamic>.from(map['chat']);
      op.add(message.toJson());
      map['chat'] = op;
      found = true;
    }
  });
  if (!found) {
    map['chat'] = [message.toJson()];
  }

  map['lastUpdate'] = DateTime.now().toString();

  Map<String, dynamic> op = {};
  map.forEach((key, value) {
    op[key] = value;
  });
  databaseReference.child('chats/$id').update(op);
}

void chatRef(String id, Function callback) async {
  databaseReference.child('chats/$id').onValue.listen((event) {
    callback();
  });
}

void userRef(Function callback) {
  databaseReference.child('chats/').onValue.listen((event) {
    callback();
  });
}

Future<void> setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInstance = FirebaseDatabase.instanceFor(
      databaseURL:
          'https://chatapp-cc467-default-rtdb.asia-southeast1.firebasedatabase.app/',
      app: await Firebase.initializeApp());
  databaseReference = firebaseInstance.ref();
}

void changeUIDname(String email, String name) async {
  DataSnapshot snapshot =
      await databaseReference.child('user-id-map/').ref.get();
  if (snapshot.value != null) {
    Map map = snapshot.value as Map;
    map.forEach((key, value) {
      if (value[0] == email) {
        map[key][1] = name;
      }
    });
    Map<String, dynamic> op = {};
    map.forEach((key, value) {
      op[key] = value;
    });
    databaseReference.child('user-id-map/').update(op);
  }
}

void createGroupChat(List<String> users, String title) async {
  Map<String, dynamic> struct = {};
  struct['lastUpdate'] = DateTime.now().toString();
  struct['type'] = 'group';
  List<String> op = [];
  users.forEach((element) {
    var name = getName(element);
    if (name != null) {
      op.add(element);
    }
  });
  if (op.isNotEmpty && title.isNotEmpty) {
    var id = databaseReference.child('chats/').push();
    struct['users'] = op;
    struct['title'] = title;
    id.set(struct);
  }
}

void userPrefMapping(String uid, String prefId) {
  var id = databaseReference.child('user-pref-mapping/').push();
  id.set({'user': uid, 'pref': prefId});
}

Future<void> loadUserPrefMap() async {
  DataSnapshot snapshot =
      await databaseReference.child('user-pref-mapping/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value! as Map;
    data.forEach((key, value) {
      prefMap[value['user']] = value['pref'];
    });
  }
}

bool findPref(String key) {
  bool found = false;
  prefMap.keys.forEach((element) {
    if (element == key) {
      found = true;
      return;
    }
  });
  return found;
}

void updateThemePref(String uid, List<List<double>> theme) async {
  Query query = databaseReference.child('user-pref/').ref.orderByValue();
  await loadUserPrefMap();
  DataSnapshot snapshot = await query.ref.get();
  if (snapshot.value != null && findPref(uid)) {
    Map data = snapshot.value! as Map;
    data[prefMap[uid]]['theme'] = theme;
    Map<String, dynamic> op = {};
    data.forEach((key, value) {
      op[key] = value;
    });
    databaseReference.child('user-pref/').update(op);
  } else {
    var id = databaseReference.child('user-pref/').push();
    id.set({'user': uid, 'theme': theme});
    userPrefMapping(uid, id.key!);
  }
}

Future<void> getThemePref(String uid) async {
  await loadUserPrefMap();
  if (findPref(uid)) {
    DataSnapshot snapshot = await databaseReference.child('user-pref/').get();
    Map data = snapshot.value! as Map;
    List<List<double>> custom = [];
    data.forEach((key, value) {
      if (key == prefMap[uid]) {
        Map map = value as Map;
        map.forEach((key, value) {
          if (key == 'theme') {
            List<dynamic> temp = map['theme'] as List;
            temp.forEach((element) {
              List<dynamic> temp1 = element as List;
              List<double> op = [];
              temp1.forEach((element) {
                op.add(element.toDouble());
              });
              custom.add(op);
            });
          }
        });
      }
    });
    MyThemeData().loadTheme('custom', custom: custom);
  } else {
    MyThemeData().loadTheme('dark');
  }
}

void registerOneSignal(String uid, String pid) async {
  DataSnapshot snapshot = await databaseReference.child('one-signal/').get();
  bool found = false;
  if (snapshot.value != null) {
    Map data = snapshot.value! as Map;
    data.forEach((key, value) {
      if (value[uid] == pid) {
        found = true;
      }
    });
    if (!found) {
      var id = databaseReference.child('one-signal/').push();
      id.set({uid: pid});
    }
  } else {
    var id = databaseReference.child('one-signal/').push();
    id.set({uid: pid});
  }
}

Future<List<String>> getpids(List<String> uids) async {
  DataSnapshot snapshot = await databaseReference.child('one-signal/').get();
  List<String> op = [];
  if (snapshot.value != null) {
    Map map = snapshot.value! as Map;
    uids.forEach((element) {
      map.forEach((key, value) {
        var pid = names[element][1];
        if (value[pid] != null) {
          op.add(value[pid]);
        }
      });
    });
  }
  return op;
}

Future<void> removePid(String uid) async {
  // OneSignal.shared.setAppId('fc835a9a-cd4b-4101-af16-b90be357f6f9');
  OSDeviceState? state = await OneSignal.shared.getDeviceState();
  var pid = '';
  if (state != null) {
    pid = state.userId!;
  }
  DataSnapshot snapshot = await databaseReference.child('one-signal/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value! as Map;
    Map<String, dynamic> op = {};
    data.forEach((key, value) {
      if (value[uid] != pid) {
        op[key] = value;
      }
    });
    databaseReference.child('one-signal/').remove();
    if (op.isNotEmpty) {
      databaseReference.child('one-signal/').update(op);
    }
  }
}

Future<void> setActive(String id, String uid, bool active) async {
  DataSnapshot snapshot = await databaseReference.child('chats/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value! as Map;
    List users = data[id]['active'];
    List<String> actives = [];
    if (users != null) {
      users.forEach((element) {
        actives.add(element.toString());
      });
    }
    if (active) {
      actives.add(uid);
    } else {
      actives.removeWhere((element) => element == uid);
    }
    data[id]['active'] = actives;
    Map<String, dynamic> op = {};
    data.forEach((key, value) {
      op[key] = value;
    });
    databaseReference.child('chats/').update(op);
  }
}

Future<void> getActive(String id) async {
  DataSnapshot snapshot = await databaseReference.child('chats/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value! as Map;
    result = data[id]['active'];
  } else {
    result = [];
  }
}

bool isActive(String uid) {
  bool active = false;
  if (result != null) {
    result.forEach((element) {
      if (element == names[uid][1]) {
        active = true;
        return;
      }
    });
  }
  return active;
}

void setUnread(List<String> uids, String id) async {
  List<String> op = [];
  uids.forEach((element) {
    if (!isActive(element)) {
      op.add(element);
    }
  });
  DataSnapshot snapshot = await databaseReference.child('chats-pending/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value as Map;
    Map pending = {};
    if (data[id] != null) {
      pending = data[id];
      op.forEach((element) {
        if (pending[names[element][1]] != null) {
          pending[names[element][1]] = pending[names[element][1]]! + 1;
        } else {
          pending[names[element][1]] = 1;
        }
      });
    } else {
      op.forEach((element) {
        pending[names[element][1]] = 1;
      });
    }
    data[id] = pending;
    Map<String, dynamic> res = {};
    data.forEach((key, value) {
      res[key] = value;
    });
    databaseReference.child('chats-pending/').update(res);
  } else {
    Map<String, dynamic> pending = {};
    op.forEach((element) {
      pending[names[element][1]] = 1;
    });
    databaseReference.child('chats-pending/').update({id: pending});
  }
}

void removeUnread(String id, String uid) async {
  DataSnapshot snapshot = await databaseReference.child('chats-pending/').get();
  if (snapshot.value != null) {
    Map data = snapshot.value as Map;
    data.forEach((key, value) {
      if (key == id) {
        if (value[uid] != null) {
          Map temp = value;
          temp.remove(uid);
          value = temp;
        }
      }
    });
    Map<String, dynamic> res = {};
    data.forEach((key, value) {
      res[key] = value;
    });
    await databaseReference.child('chats-pending/').remove();
    if (res.isNotEmpty) {
      databaseReference.child('chats-pending/').update(res);
    }
  }
}
