class Chat {
  String id = '';
  String name = '';
  late DateTime lastUpdate;
  int pending = 0;
  List<String> users = [];

  void set(String id, String name, DateTime lastUpdate, List<String> users,
      int pendings) async {
    this.id = id;
    this.name = name;
    this.lastUpdate = lastUpdate;
    this.users = users;
    pending = pendings;
  }
}
