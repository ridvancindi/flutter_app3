class Settings {
  int? _notification;
    Settings(
      this._notification,);
  int get notification => _notification!;
  set notification(int value) {
    _notification = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["notification"] = _notification;
    
    return map;
  }
    Settings.dbdenOkunanDeger(Map<String, dynamic> map){
      this._notification = map["notification"];
  }
  
}
