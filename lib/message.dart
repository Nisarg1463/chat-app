// ignore_for_file: avoid_function_literals_in_foreach_calls

class Message {
  String name = '';
  String message = '';
  String time = '';

  void create(String name, String message) {
    this.name = name;
    this.message = message;

    int hour = DateTime.now().hour;
    String end = 'AM';
    int minute = DateTime.now().minute;

    if (hour > 12) {
      hour -= 12;
      end = 'PM';
    } else if (hour == 0) {
      hour = 12;
    } else if (hour == 12) {
      end = 'PM';
    }

    if (minute < 10) {
      time =
          hour.toString() + ':0' + DateTime.now().minute.toString() + ' ' + end;
    } else {
      time =
          hour.toString() + ':' + DateTime.now().minute.toString() + ' ' + end;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'message': message,
      'time': time,
    };
    return map;
  }

  void toMessage(Map<dynamic, dynamic> map) {
    name = map['name'];
    message = map['message'];
    time = map['time'];
  }
}
