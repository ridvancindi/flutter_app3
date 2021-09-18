class Data {
  int? _id;
  String? _kelime;
  String? _karsilik;
  int? _isActive;
  String? _createdDate;
  String? _upgrateDate;
  Data(this._kelime, this._karsilik, this._isActive, this._createdDate,
      this._upgrateDate);
  Data.withId(this._id, this._kelime, this._karsilik, this._isActive,
      this._createdDate, this._upgrateDate);
  int get id => _id!;
  String get kelime => _kelime!;
  String get karsilik => _karsilik!;
  int get isActive => _isActive!;
  String get createdDate => _createdDate!;
  String get upgrateDate => _upgrateDate!;
  set kelime(String value) {
    _kelime = value;
  }

  set karsilik(String value) {
    _karsilik = value;
  }

  set isActive(int value) {
    _isActive = value;
  }

  set createdDate(String value) {
    createdDate = value;
  }

  set upgrateDate(String value) {
    upgrateDate = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["kelime"] = _kelime;
    map["karsilik"] = _karsilik;
    map["isactive"] = _isActive;
    map["createdDate"] = _createdDate;
    map["upgrateDate"] = _upgrateDate;

    return map;
  }

  Data.dbdenOkunanDeger(Map<String, dynamic> map) {
    this._id = map["id"];
    this._kelime = map["kelime"];
    this._karsilik = map["karsilik"];
    this._isActive = map["isactive"];
    this._createdDate = map["createdDate"];
    this._upgrateDate = map["upgrateDate"];
  }
}
