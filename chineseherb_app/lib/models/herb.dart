class Herb {
  int _herbID;
  String _chName;
  String _engName;
  String _effect;
  String _taste;
  String _qulity;
  String _shape;

  Herb(this._herbID, this._chName, this._engName, this._effect, this._taste,
      this._qulity, this._shape);

  int get herbID => _herbID;
  String get chName => _chName;
  String get engName => _engName;
  String get effect => _effect;
  String get taste => _taste;
  String get qulity => _qulity;
  String get shape => _shape;

  set herbID(int newID) {
    this._herbID = newID;
  }

  set chName(String newChName) {
    this._chName = newChName;
  }

  set engName(String newEngName) {
    this._engName = newEngName;
  }

  set effect(String newEffect) {
    this._effect = newEffect;
  }

  set taste(String newTaste) {
    this._taste = newTaste;
  }

  set qulity(String newQulity) {
    this._qulity = newQulity;
  }

  set shape(String newShape) {
    this._shape = newShape;
  }

  //Convert Herb object to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (herbID != null) {
      map["herbID"] = _herbID;
    }

    map["chName"] = _chName;
    map["engName"] = _engName;
    map["effect"] = _effect;
    map["taste"] = _taste;
    map["qulity"] = _qulity;
    map["shape"] = _shape;

    return map;
  }

  Herb.fromMapObject(Map<String, dynamic> map) {
    this._herbID = map["herbID"];
    this._chName = map["chName"];
    this._engName = map["engName"];
    this._effect = map["effect"];
    this._taste = map["taste"];
    this._qulity = map["qulity"];
    this._shape = map["shape"];
  }
}
