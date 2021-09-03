class Data {
  int? _id;
  String? _name;
  String? _surname;
  int? _isActive;
      Data(
      this._name,
      this._surname,
      this._isActive
      );
  Data.withId(
      this._id,
      this._name,
      this._surname,
      this._isActive,);
  int get id => _id!;
  String get name => _name!;
  String get surname => _surname!;
  int get isActive => _isActive!;
  set name(String value) {
    _name = value;
  }
  set surname(String value) {
    _surname = value;
  }
  set isActive(int value) {
    _isActive = value;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["name"] = _name;
    map["surname"] = _surname;
    map["isactive"] =   _isActive;
    
    return map;
  }
    Data.dbdenOkunanDeger(Map<String, dynamic> map){
      this._id = map["id"];
      this._name = map["name"];
      this._surname = map["surname"];
      this._isActive = map["isactive"];
  }
}
