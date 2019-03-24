class Formula {
  String _formula_id ;
  String _chinese_name ;
  String _phonetic ;
  String _english_name ;
  String _classification ;
  String _source ;
  String _combination ;
  String _method ;
  String _action ;
  String _indication ;
  String _pathogenesis ;
  String _clarification ;
  String _application ;
  String _additonal_formulae ;
  String _formula_song ;

  Formula(this._formula_id, this._chinese_name, this._phonetic, this._english_name, this._classification, this._source, this._combination, this._method, this._action, this._indication, this._pathogenesis, this._clarification, this._application, this._additonal_formulae, this._formula_song);

  String get formula_id => _formula_id;
  String get chinese_name => _chinese_name;
  String get phonetic => _phonetic;
  String get english_name => _english_name;
  String get classification => _classification;
  String get source => _source;
  String get combination => _combination;
  String get method => _method;
  String get action => _action;
  String get indication => _indication;
  String get pathogenesis => _pathogenesis;
  String get clarification => _clarification;
  String get application => _application;
  String get additonal_formulae => _additonal_formulae;
  String get formula_song => _formula_song;

  set formula_id (String target){
    this._formula_id = target;
  }
  set chinese_name (String target){
    this._chinese_name = target;
  }
  set phonetic (String target){
    this._phonetic = target;
  }
  set english_name (String target){
    this._english_name = target;
  }
  set classification (String target){
    this._classification = target;
  }
  set source (String target){
    this._source = target;
  }
  set combination (String target){
    this._combination = target;
  }
  set method (String target){
    this._method = target;
  }
  set action (String target){
    this._action = target;
  }
  set indication (String target){
    this._indication = target;
  }
  set pathogenesis (String target){
    this._pathogenesis = target;
  }
  set clarification (String target){
    this._clarification = target;
  }
  set application (String target){
    this._application = target;
  }
  set additonal_formulae (String target){
    this._additonal_formulae = target;
  }
  set formula_song (String target){
    this._formula_song = target;
  }

  //Convert Herb object to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["formula_id"] = _formula_id;
    map["chinese_name"] = _chinese_name;
    map["phonetic"] = _phonetic;
    map["english_name"] = _english_name;
    map["classification"] = _classification;
    map["source"] = _source;
    map["combination"] = _combination;
    map["method"] = _method;
    map["action"] = _action;
    map["indication"] = _indication;
    map["pathogenesis"] = _pathogenesis;
    map["clarification"] = _clarification;
    map["application"] = _application;
    map["additonal_formulae"] = _additonal_formulae;
    map["formula_song"] = _formula_song;

    return map;
  }

  Formula.fromMapObject(Map<String, dynamic> map) {
    this._formula_id = map["formula_id"];
    this._chinese_name = map["chinese_name"];
    this._phonetic = map["phonetic"];
    this._english_name = map["english_name"];
    this._classification = map["classification"];
    this._source = map["source"];
    this._combination = map["combination"];
    this._method = map["method"];
    this._action = map["action"];
    this._indication = map["indication"];
    this._pathogenesis = map["pathogenesis"];
    this._clarification = map["clarification"];
    this._application = map["application"];
    this._additonal_formulae = map["additonal_formulae"];
    this._formula_song = map["formula_song"];
  }
}
