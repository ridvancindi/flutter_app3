class Settings {
  int? _id;
  int? _notification;
  Settings(
    this._notification,
  );
  Settings.withId(
    this._id,
    this._notification,
  );
  int get id => _id!;
  int get notification => _notification!;
  set notification(int value) {
    _notification = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = _id;
    map["notification"] = _notification;

    return map;
  }

  Settings.dbdenOkunanDeger(Map<String, dynamic> map) {
    this._id = map["id"];
    this._notification = map["notification"];
  }
}
