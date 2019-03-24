import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:chineseherb_app/models/herb.dart';
import 'package:chineseherb_app/models/formula.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String herbTable = "herb_table";
  String colHerbID = "herbID";
  String colChName = "chName";
  String colEngName = "engName";
  String colEffect = "effect";
  String colTaste = "taste";
  String colQulity = "qulity";
  String colShape = "shape";
  String colHaveIcon = "haveIcon";

  String formulaeTable = "Formulae";
  String formula_id = "formula_id";
  String formula_chinese_name = "chinese_name";
  String formula_phonetic = "phonetic";
  String formula_english_name = "english_name";
  String formula_classification = "classification";
  String formula_source = "source";
  String formula_combination = "combination";
  String formula_method = "method";
  String formula_action = "action";
  String formula_indication = "indication";
  String formula_pathogenesis = "pathogenesis";
  String formula_clarification = "clarification";
  String formula_application = "application";
  String formula_additonal_formulae = "additonal_formulae";
  String formula_formula_song = "formula_song";

  String formulaHerbTable = "Formulae_Herbs";
  String formulaHerb_formula_id = "formula_id";
  String formulaHerb_herb_id = "herb_id";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'app.db';
    print("initializing Database");
    var appDatabase = openDatabase(path, version: 1, onCreate: _createDB);
    return appDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    print("initializing Database: create Table");
    await db.execute(
        'CREATE TABLE $herbTable($colHerbID INTEGER PRIMARY KEY, $colChName TEXT, '
        '$colEngName TEXT, $colEffect TEXT, $colTaste TEXT, $colQulity TEXT, $colShape TEXT, $colHaveIcon TEXT)');
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0001','馬勃','Puffball','局部止血藥，清肺，利咽，解熱等','辛，平','以個大、皮薄、飽滿、鬆泡有彈性者為佳','紫色馬勃：呈陀螺形，或已壓扁呈扁圓形，直徑5~12cm，不孕基部發達；包被薄，2層，紫褐色，粗皺，有圓形凹陷，外翻，上部常裂成小塊或已部分脫落；孢體紫色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0002','人參','Ginseng Root','大補元氣，複脈固脫，補脾益肺，生津止渴，安神益智。用於體虛欲脫，肢冷脈微，脾虛食少，肺虛喘咳，津傷口渴，內熱消渴，久病虛贏，驚悸失眠，陽痿宮冷；心力衰竭，心原性休克','平、味甘、微苦，微溫','以條粗、質硬、皮細、無破痕者為佳','生曬參片：為圓形或類圓形薄片，表面灰白色，顯菊花紋，粉性，體輕，質脆。有特異香氣', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0003','天麻','Tall Gastrodiae','息風止痙，平肝潛陽，祛風通絡','氣微，性平，味甘，微辛','藥材以質地堅實，體重，有鸚哥嘴，無空心者為佳。飲片以體實澤亮半透明者為佳','塊莖呈橢圓形或長條形，略扁，皺縮而稍彎曲。長3~15cm，寬1.5~6cm，厚0.5~2cm。表面黃白色至淡黃棕色，略透明，多不規則縱皺紋，有縱皺紋及由潛伏芽排列成的多輪橫環紋，有時可見棕褐色菌索，具點狀痕點或膜質鱗葉有時可見棕黑色菌索。冬至以後莖枯時採挖者稱“冬麻”，頂端為紅棕色至深棕色頂芽；立夏以前植株出芽時採挖者稱“春麻”，頂端有殘留莖基。末端均有自母體麻脫落後的圓臍狀疤痕。質堅實，不易折斷，斷面較平坦，角質樣，黃白色或淡棕色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0004','北沙參','Coastal Glehnia Root','養陰清肺，益胃生津。用於肺熱燥咳、勞嗽痰血、熱病津傷口渴','甘，微苦，微寒','以枝條細長、圓柱形、均勻、質堅、外皮色白者為佳','長圓柱形，偶有分枝。表面淡黃白色，偶有外皮殘存，全體有細縱皺紋及縱溝，並有棕黃色點狀細根痕。頂端常留有棕黃色根莖殘基，上端稍細，中部略粗，下部漸細。質脆，易折斷，斷面皮部淺黃白色，木部黃色。氣特異，味微甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0005','大黃','Tangute Rhubarb','攻積滯；清濕熱；瀉火；涼血；祛瘀；解毒。主治實熱便秘；熱結胸痞；濕熱瀉痢；黃疸；淋病；水腫腹滿；小便不利；目赤；咽喉腫痛；口舌生瘡；胃熱嘔吐；吐血；咯血；衄血；便血；尿血；蓄血；經閉；產後瘀滯腹痛；症瘕積聚；跌打損傷；熱毒癰瘍；丹毒；燙傷','味苦，性寒','以堅實、氣清香味苦而微澀者為佳','本品呈類圓柱形、圓錐形、卵圓形或不規則塊狀，長3~17cm，直徑3~10cm。除盡外皮者表面黃棕色至紅棕色，有的可見類白色網狀紋理及星點 (異型維管束) 散在，殘留的外皮棕褐色，多具繩孔及粗皺紋。質堅實，有的中心稍鬆軟，斷面淡紅棕色或黃棕色，顯顆粒性；根莖髓部寬廣，有星點環列或散在；根木部發達，具放射狀紋理，成層環明顯，無星點。氣清香，味苦而微澀，嚼之粘牙，有砂粒感', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0006','山藥','Common Yan Rhizome','補脾養胃，生津益肺，補腎澀精。用於脾虛食少，久瀉不止，肺虛喘咳，腎虛遺精，帶下，尿頻，虛熱消渴','甘、平','以身長、條粗、質堅實、粉性足、色潔白者為佳','略呈圓柱形，彎曲而稍扁，長15~30cm，直徑1. 5~6cm。表面黃白色或淡黃色，有縱溝、縱皺紋及鬚根痕，偶有淺棕色外皮殘留。體重，質堅實，不易折斷，斷面白色，粉性。無臭，味淡、微酸，嚼之發粘。光山藥呈圓柱形，兩端平齊，長9~18cm，直徑1. 5~3cm。表面光滑，白色或黃白色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0007','生薑','Fresh Ginger','發汗解表，溫中止嘔，溫肺止咳，解魚蟹毒，解藥毒','辛，微溫','以個大，肉質厚，新鮮者為佳','生薑呈不規則的塊狀，略扁，肉質肥厚。表面黃褐色或灰棕色，質脆，易折斷，斷面黃色，內皮層有明顯環紋。氣香特異，味辛辣', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0008','乾薑','Dried Ginger','溫中散寒，回陽通脈，燥濕消痰，溫肺化飲。主治脘腹冷痛；嘔吐；泄瀉，亡陽厥逆；寒飲喘咳；寒濕痹痛','味辛，性熱','以質堅實、斷面色黃白、粉性足、氣味濃者為佳','根莖呈不規則塊狀，略扁，具指狀分枝，長3~7cm，厚1~2cm。表面灰棕色或淺黃棕色，粗糙，具縱皺紋及明顯的環節。分枝處常有鱗葉殘存，分枝頂端有莖痕或芽。質堅實，斷面黃白色或灰白色，粉性和顆粒性，有一明顯圓環 (內皮層)，筋脈點 (維管束) 及黃色油點散在。氣香，特異，味辛辣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0009','牛膝','Common Achyranthes','補肝腎；強筋骨；活血通經；引火 (血) 下行；利尿通淋。主治腰膝酸痛；下肢痿軟；血滯經閉；痛經；產後血瘀腹痛；症瘕；胞衣不下；熱淋；血淋；跌打損傷；癰腫惡瘡；咽喉腫痛','味苦；酸；性平','以條長、皮細肉肥、色黃白者為佳','根呈細長圓柱形，有的稍彎曲，上端稍粗，下端較細，長15~50cm，直徑0.4~1cm。表面及黃色或淡棕色，具細微縱皺紋，有細小橫長皮孔及稀疏的細根痕。質硬而脆，易折斷，斷面平坦，黃棕色，微呈角質樣，中心維管束木部較大，黃白色，其週邊散有多數點狀維管束，排列成2~4輪。氣微，味微甜、澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0010','苦參','Lightyellow Sophra Root','清熱燥濕；祛風殺蟲。主濕熱瀉痢；腸風便血；黃疸；小便不利；水腫；帶下；陰癢；疥癬；麻風；皮膚瘙癢；濕毒瘡瘍 ','苦，寒','以條勻、斷面黃白、味極苦者為佳','根長圓柱形，下部常分枝，長10~30cm，直徑l~2.5cm。表面棕黃色至灰棕色，具縱皺紋及橫生皮孔。栓皮薄，常破裂反卷，易剝落，露出黃色內皮。質硬，不易折斷，折斷面纖維性。切片厚3~6mm，切面黃白色，具放射狀紋理。氣微，味苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0011','丹參','Dan - shen Root','活血調經，祛瘀止痛，涼血消癰，清心除煩，養血安神。主治月經不調，經閉痛經，症瘕積聚，胸腹刺痛，熱痹疼痛，瘡瘍腫痛，心煩不眠；肝脾腫大，心絞痛','苦，微寒','以條粗壯、色紫紅者為佳','藥材多為帶根莖的根，根莖粗短，有莖基殘餘，下著生多數細長的根。根呈圓柱形，稍彎曲，表面呈磚紅色，粗糙，具多數縱溝或皺紋，有鬚根痕，外部栓皮常鱗片狀剝落，皮層有時開裂，長8~22cm，直徑5~12mm，質堅脆，易折斷，斷面不平，疏鬆有裂隙，皮部棕渴色或磚紅色，韌皮部狹。形成層明顯，淡棕色，木質部導管束灰黃色或黃白色，放射狀排列。氣微，味微苦、澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0012','百部','Japanese Stemona Root','潤肺下氣止咳，殺蟲。用於新久咳嗽，肺癆咳嗽，百日咳；外用於頭蝨，體虱，蟯蟲病，陰部騷癢','甘、苦，微溫','以粗壯、肥潤、堅實、色白者為佳','對葉百部：呈長紡錘形或長條形，長8~24cm，直徑0.8~2cm。表面淺黃棕色至灰棕色，具淺縱皺紋或不規則縱槽。質堅實，斷面黃白色至暗棕色，柱較大，髓部類白色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0013','白附子','Giant Typhonium Tuber','燥濕化痰，祛風止痙，解毒散結止痛','味辛、甘，性溫，有毒','以個大、質堅實，色白、粉性足者為佳','白附子塊莖呈橢圓形或卵圓形，長2~5cm，直徑1~3cm。表面白色或黃白色，有環紋及鬚根痕，頂端具莖痕或芽痕。質堅硬，斷面類白色，富粉性。無臭，味淡，嚼之麻辣刺舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0014','白茅根','Lalang Grass Rhizome','涼血，止血，清熱，利尿。治熱病煩渴，吐血，衄血，肺熱喘急，胃熱噦逆，淋病，小便不利，水腫，黃疸','甘、寒','以條粗、色白、味甜者為佳','根莖長圓柱形，有時分枝，長短不一，長30~60cm，直徑2~4mm。表面黃白色或淡黃色，有光澤，具縱皺紋，環節明顯，節上殘留灰棕色鱗葉及細根，節間長1~3cm。體輕，質韌，折斷面纖維性，黃白色，多具放射狀裂隙，有時中心可見一小孔。氣微，味微甜', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0015','白前','Willowleaf Swallowwort Rhizome and Root','降氣化痰，止咳。用於咳嗽痰多，氣喘。該品性微溫而不燥烈，長於祛痰，降肺氣以平咳喘，無論屬寒屬熱，外感內傷，新嗽久咳均可用之','辛、苦，微溫','以根莖粗、鬚根長、斷面粉白色、粉性足者為佳','根纖細彎曲扭轉而成團狀，長約1~10cm，多數呈毛須狀，表面棕色或紫棕色，有細繳皺，並具多數小鬚根。根莖呈管狀，細長有節，略彎曲，長約4~15cm，直徑1.5~5mm，表面淺黃色至黃棕色，有細縱皺紋，節部膨大，常有分歧，並密生鬚根，頂端常殘留灰綠色或紫棕色的地上莖；質堅脆，易折斷，斷面類圓形，中空或有膜質的髓。質堅脆，易折斷，斷面類白色，氣微弱，味甜', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0016','白芍','White Peony Root','養血柔肝，緩中止痛，斂陰收汗。治胸腹脅肋疼痛，瀉痢腹痛，自汗盜汗，陰虛發熱，月經不調，崩漏，帶下','苦酸，微寒','以根粗長、勻直、質堅實、粉性足、表面潔淨者為佳','乾燥根呈圓柱形，粗細均勻而平直，長10~20cm，直徑1~1.8cm。表面淡紅棕色或粉白色，平坦，或有明顯的縱皺及鬚根痕，栓皮未除盡處有棕褐色斑痕，偶見橫向皮孔。質堅實而重，不易折斷。斷面灰白色或微帶棕色，木部放射線呈菊花心狀，形成層環明顯。氣微，味微苦而酸', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0017','白頭翁','Chinese Pulsatilla Root','清熱解毒，涼血止痢，燥濕殺蟲。主治熱毒痢疾，鼻衄，血痔，帶下，陰癢，癰瘡，瘰鬁','味苦，性寒','以條粗長，質堅實者為佳','根長圓柱形或圓錐形，稍彎曲，有時扭曲而稍扁，長5~20cm，直徑0.5~2cm。表面黃棕色或棕褐色，有不規則的縱皺紋或縱溝，中部有時分出2~3支根，皮部易脫落而露出黃色木部，且常朽蝕成凹洞，可見縱向突起的網狀花紋；根頭部稍膨大，有時分叉，頂端殘留數層鞘狀葉柄基及幼葉，密生白色長絨毛。質硬脆，折斷面稍平坦，皮部黃白色，木部淡黃色，皮部與木部間有時出現空隙。氣微，味微苦澀', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0018','白薇','Blackend Swallowwort Root and Rhizome','清熱涼血，利尿通淋，解毒療瘡。用於溫邪傷營發熱，陰虛發熱，骨蒸勞熱，產後血虛發熱，熱淋，血淋，癰疽腫毒','味苦、鹹，寒','以根細長，棕黃色者為佳','根莖粗短，有結節，多彎曲。上面有圓形的莖痕，下面及兩側簇生多數細長的根，根長10~25cm，直徑0.1~0.2cm。表面棕黃色。質脆，易折斷，斷面皮部黃白色，木部黃色。氣微，味微苦', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0019','白芷','Taiwan Angelica Root','祛風濕，活血排膿，生肌止痛。用於頭痛、牙痛、鼻淵、腸風痔漏、赤白帶下、癰疽瘡瘍、皮膚瘙癢','辛，溫','以條粗壯，質堅硬、體重、色白、粉性足、香氣濃者為佳','根呈圓錐形，長10~20cm，直徑2~2.5cm。表面灰棕色，有橫向突起的皮孔，頂端有凹陷的莖痕。質硬，斷面白色，粉性足，皮部密佈棕色油點。氣芳香，味辛、微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0020','白朮','Largehead Atractylodes Rhizome','健脾益氣、燥濕利水、止汗、安胎。用於脾虛食少、腹脹泄瀉、痰飲眩悸、水腫、自汗、胎動不安','苦、甘，溫','以個大、堅實、斷面黃白色、香氣濃郁者為佳','根莖呈拳形團塊，長3~13cm，直徑1.5~7cm。表面灰黃色或灰棕色，有瘤狀突起及斷續的縱皺紋和鬚根痕，頂端有殘留莖基和芽痕。質堅硬，不易折斷，斷面不平坦，黃白色至淡棕色，有棕黃色的點狀油室散在。氣清香，味甘、微辛，嚼之略帶粘性', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0021','巴戟天','Medicinal Morinda Root','補腎助陽；強筋壯骨；祛風除濕。用於腎虛陽痿；遺精早洩；少腹冷痛；小便不禁；宮冷不孕；風寒濕痹；腰膝酸軟；風濕肢氣','辛、甘，溫','以條肥壯、連珠狀、肉厚、色紫者為佳','根扁圓柱形式圓柱形，略彎曲，長度不等，直徑1~2cm，表面灰黃色或灰黃棕色，有的微帶紫色，具縱皺及深陷的橫紋，有的呈縊縮狀或皮部橫向斷離而露出木部，形如雞腸。質堅韌，折斷面不平，皮部厚5~7mm，淡紫色，木部直徑2~4mm。氣微，味苦，略澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0022','板藍根','Indigowoad Root','清熱，解毒，涼血，利咽。用於溫毒發斑；高熱頭痛；大頭瘟疫；舌絳紫暗，爛喉丹痧；丹毒；痄腮；喉痹；瘡腫、癰腫；水痘；麻疹；肝炎；流行性感冒，流腦，乙腦，肺炎，神昏吐衄，咽腫，火眼，瘡疹','苦，寒','以根平直粗壯、堅實、粉性大者為佳','呈細長圓柱形，長約10~20~30cm，直徑3~8mm。表面淺灰黃色，粗糙，有縱皺紋及橫斑痕，並有支根痕，根頭部略膨大，頂端有一凹窩，周邊有暗綠色的葉柄殘基，較粗的根並現密集的疣狀突起及輪狀排列的灰棕色的葉柄痕。質堅實而脆，斷面皮部黃白色至淺棕色，木質部黃色。氣微弱，味微甘', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0023','草烏','Kusnezoff Monkshood Mother Root','祛風除濕，溫經止痛。用於風寒濕痹，關節疼痛，心腹冷痛，寒疝作痛，麻醉止痛','辛、苦，熱，有大毒','以個大、肥壯、質堅實、粉性足、殘莖及鬚根少者為佳','草烏呈圓錐形而稍彎曲，形如烏鴉頭，長2~7cm，直徑1~3cm，頂端常有長1cm左右的殘莖或莖痕，表面暗棕色或灰褐色，外皮皺縮。有的具突起的支根。質堅，難折斷，斷面白色或灰白色，形成層環紋多角形或類圓形。無臭，味辛辣，麻舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0024','柴胡','Chinese Thorawax Root','和解少陽，疏肝解鬱。透表泄熱，升舉陽氣。用於感冒發熱、寒熱往來、瘧疾，肝鬱氣滯，胸肋脹痛，脫肛，子宮脫落，月經不調','苦，微寒','以條粗，無殘留鬚根者為佳','呈圓柱形或長圓錐形，長6~15cm，直徑0.3~0.8cm。根頭膨大，頂端殘留3~15個莖基或短纖維狀葉基，下部分枝。表面黑褐色或淺棕色，具縱皺紋、支根痕及皮孔。質硬而韌，不易折斷，斷面顯片狀纖維性，皮部淺棕色，木部黃白色。氣微香，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0025','蒼朮','Swordlike Atracylodes Rhizome','燥濕健脾，祛風散寒，明目。用於脘腹脹滿，泄瀉水腫，腳氣痿躄，風濕痹痛，風寒感冒，夜盲','苦、辛，溫','以個大、質堅實、斷面朱砂點多、香氣濃者為佳','呈不規則連珠狀或結節狀圓柱形，略彎曲，偶有分枝，長3~10cm，直徑1~2cm。表面灰棕色，有皺紋、橫曲紋及殘留鬚根，頂端具莖痕或殘留莖基。質堅實，斷面黃白色或灰白色，散有多數橙黃色或棕紅色油室，暴露稍久，可析出白色細針狀結晶。氣香特異，味微甘、辛、苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0026','赤芍','Red Paeoniae Trichocarpae','清熱涼血、散瘀止痛的功能。生赤芍以清熱涼血力勝。多用於溫病熱入血分的身熱出血，目赤腫痛，癰腫瘡毒','苦，微寒','以根條粗壯、粉性足、斷面粉白色者為佳','該品呈圓柱形，稍彎曲，長5~40cm，直徑0.5~3cm。表面棕褐色，粗糙，有縱溝及皺紋，並有鬚根痕及橫向凸起的皮孔，有的外皮易脫落。質硬而脆，易折斷，斷面粉白色或粉紅色，皮部窄，木部放射狀紋理明顯，有的有裂隙。氣微香，味微苦、酸澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0027','川牛膝','Medicinal Cyathula officinalis Root','逐瘀通經，通利關節，利尿通淋。用於經閉症瘕，胞衣不下，關節痹痛，足痿筋攣，尿血血淋，跌撲損傷','甘、微苦，平','以分枝少、根粗壯、斷面淺黃色者為佳','本品呈近圓柱形，微扭曲，向下略細或有少數分枝，長30~60cm，直徑0.5~3cm。表面黃棕色或灰褐色，有微扭曲的縱皺紋、側根痕和多數橫長的散在皮孔樣突起。質韌，不易折斷，斷面淺黃色或棕黃色，維管束點狀，排列成數輪同心環。氣微，味甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0028','川烏','Common Monkshood Mother Root','祛風除濕；溫經；散寒止痛。主風寒濕痹；關節疼痛；肢體麻木；半身不遂；頭風頭痛；心腹冷痛；寒疝作痛；跌打瘀痛；陰疽腫毒；並可用於麻醉止痛 ','辛、苦，熱，有大毒','以飽滿、質堅實、斷面色白者為佳','為不規則圓錐形，稍彎曲，頂端常有殘莖，中部多向一側膨大，長2~7.5cm，直徑1.2~2.5cm。表面棕褐色或灰棕色，皺縮，有小瘤狀側根及子根痕。質堅實，斷面類白色或淺灰黃色，形成層環多角形。氣微，味辛辣、麻舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0029','川芎','Szechwan Lovage Rhizome','活血祛瘀；行氣開鬱；祛風止痛 。用於胸痹心痛，胸脅刺痛，跌撲腫痛，月經不調，經閉痛經，癮瘕腹痛，頭痛，風濕痹痛','辛，溫','以個大飽滿、質堅實、油性大、香氣濃、斷面黃白者為佳','為不規則結節狀拳形團塊，直徑2~7cm。表面黃褐色，粗糙皺縮，有多數平行隆起的輪節，頂端有凹陷的類圓形莖痕，下側及輪節上有多數小瘤狀根痕。質堅實，不易折斷，斷面黃白色或灰黃色，散有黃棕色的油室，形成層呈波狀環紋。氣濃香，味苦、辛。稍有麻舌感，微回甜。飲片邊緣不整齊，呈不規則的類蝴蝶形薄片', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0030','當歸','Chinese Angelica','補血活血，調經止痛，潤腸通便。用於血虛萎黃、眩暈心悸、月經不調、經閉痛經、虛寒腹痛、腸燥便秘、風濕痹痛、跌撲損傷、癰疽瘡瘍','甘、辛，溫','以主根粗長、油潤、外皮黃棕色、肉質飽滿、香氣濃者為佳','全歸長略呈圓柱形，下部有支根3~5條或更多，長15~25cm。外皮細密，表面黃棕色至棕褐色，具縱皺紋及橫長皮孔。根頭 (歸頭) 直徑1.5~4cm，具環紋，上端圓鈍，有紫色或黃綠的葉鞘的殘基；主根 (歸身) 表面凹凸不平；支根 (歸尾) 直徑0.3~1cm，上粗下細，多扭，有少數鬚根痕。質柔韌，斷面黃白色或淡黃棕色，皮部厚，有裂隙及多數棕色點狀分泌腔，木部色較淡，形成層環黃棕色。木質部色較淡；根莖部分斷面中心通常有髓和空腔', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0031','生地黃','Dried Rehmannia Root','生地黃清熱涼血，養陰生津；','生地黃甘，寒；','生地黃以塊大、體重、斷面烏黑油潤，味甘者為佳；','生地黃呈不規則的圓形或長圓形塊狀，長6~12cm，直徑3~6cm；表面灰棕色或灰黑色，全體皺縮不平，具不規則的橫曲紋；細小的多為長條狀，稍扁而扭曲；質柔軟，乾後則堅實，體重，不易折斷，斷面平坦，紫黑色或烏黑色而光亮，顯油潤，具粘性；氣微香，味微甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0032','獨活','Doubleteeth Angelicae Root','祛風勝濕；散寒止痛。用於風寒濕痹；腰膝疼痛；少陰伏風頭痛，頭痛齒痛','辛、苦，微溫','以條粗壯、油潤、香氣濃者為佳','根頭及主根粗短，略呈圓柱形，長1.5~4cm，直徑1.5~3.5cm，下部有數條彎曲的支根，長12~30cm，直徑0.5~1.5cm。表面粗糙，灰棕色，具不規則縱皺紋及橫裂紋，並有多數橫長皮孔及細根痕；根頭部有環紋，具多殖環狀葉柄痕，中內為凹陷的莖痕。質堅硬，斷面灰黃白色，形成層環棕色，皮部有棕色油點 (油管)，木部黃棕色；根頭橫斷面有大形賄部，亦有油點。香氣特異，味苦辛，微麻舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0033','防風','Divaricate Saposhnikovia','治外感風寒，頭痛，目眩，項強、風寒濕痹，骨節酸痛，四肢攣急，破傷風','辛、甘，微溫','以條粗壯、皮細而緊、無毛頭、斷面有棕色環、中心色淡黃者為佳','乾燥的根呈圓錐形或紡錘形，稍彎曲，長20~30cm，根頭部直徑約1cm，中部直徑1~1.5cm。表面灰黃色或灰棕色。根頭部有密集的細環節，節上有棕色粗毛，頂端有莖的殘痕；根部外皮皺縮而粗糙，有不整齊的縱皺及細橫紋，除散生汙黃色的橫長皮孔外，點狀突起的鬚根痕也隨處可見。質松而軟，易折斷，斷而不平坦，木部淡黃色，皮部黃棕色有裂隙，射線呈放射狀。氣微香，味微甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0034','防己','Fourstamen Stephania Root','利水消腫，祛風止痛。主治水腫腳氣，小便不利，濕疹瘡毒，風濕痹痛，高血壓症。一般認為，漢防己利水消腫作用較強，木防己祛風止痛作用較好','苦，寒','以質堅實、斷面白色、粉性足者為佳','根不規則圓柱形，形如“豬大腸”，剖切成半圓柱形或塊狀，常彎曲，彎曲處有深陷橫溝而呈結節狀，長5~15cm，直徑1~5cm。表面灰黃色，有細皺紋及橫向突起的皮孔。質堅重，斷面平坦，灰白色，有“蜘蛛網紋”，具粉性。氣微，味苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0035','附子','Prepared Common Monkshood Daughter Root','回陽救逆，補火助陽，散寒止痛。“為回陽救逆第一品藥”。用於陰盛格陽，大汗亡陽，吐瀉厥逆，肢冷脈微，心腹冷痛，冷痢，腳氣水腫，風寒濕痹，陽痿，宮冷，虛寒吐瀉，陰寒水腫，陽虛外感，陰疽瘡瘍以及一切沉寒痼冷之疾','甘、辛，大熱，有毒','白附片以片大、色白、半透明者為佳','淡附片：為縱切薄片，表面灰白色，質硬脆。氣微、味淡，無麻舌感', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0036','甘遂','Kansui Root','瀉水逐飲，消腫散結。用於水腫脹滿，胸腹積水，痰飲積聚，氣逆喘咳，二便不利，消腫散結：外用可治癰腫瘡瘍','苦，寒，有毒','以色白、肥大、粉性足者為佳','本品呈橢圓形、長圓柱形或連珠形，長1~5cm，直徑0.5~2.5cm。表面類白色或黃白色，凹陷處有棕色外皮殘留。質脆，易折斷，斷麵粉性，白色，木部微顯放射狀紋理；長圓柱狀者纖維性較強。氣微，味微甘而辣', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0037','高良薑','Lesser Galangal Rhizome','溫胃散寒，消食止痛。用於脘腹冷痛，胃寒嘔吐，噯氣吞酸','辛，熱','以氣香味辣、分枝少、紅棕色者為佳','該品呈圓柱形，多彎曲，有分枝，長5~9cm，直徑1~1.5cm。表面棕紅色至暗褐色，有細密的縱皺紋及灰棕色的波狀環節，節間長0.2~1cm，一面有圓形的根痕。質堅韌，不易折斷，斷面灰棕色或紅棕色，纖維性，中柱約占1/3。氣香，味辛辣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0038','葛根','Lobed Kudzuvine Root','解表退熱，生津，透疹，升陽止瀉。用於外感發熱頭痛、高血壓頸項強痛、口渴、消渴、麻疹不透、熱痢、泄瀉','甘、辛，涼','以白色、塊大、質堅實、粉性足、纖維少者為佳','本品呈縱切的長方形厚片或小方塊，長5~35cm，厚0.5~1cm。外皮淡棕色，有縱皺紋，粗糙。切面黃白色，紋理不明顯。質韌，纖維性強。氣微，味微甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0039','黃連','Chinese Goldthread Rhizome','清熱燥濕，瀉火解毒。用於濕熱痞滿，嘔吐吞酸，瀉痢，黃疸，高熱神昏，心火亢盛，心煩不寐，血熱吐衄，目赤，牙痛，消渴，癰腫疔瘡；外治濕疹，濕瘡，耳道流膿','苦，寒','均以條粗壯、質堅實、無殘莖毛須者為佳','雲連：藥材彎曲呈鉤狀，形如“蠍尾”，多為單枝，較細小。以乾燥、條細、節多、鬚根少，色黃者為佳品', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0040','黃芪','Membranous Milkvetch Root','補氣固表，利尿托毒，排膿，斂瘡生肌的功效。用於氣虛乏力，食少便溏，中氣下陷，久瀉脫肛，便血崩漏，表虛自汗，癰疽難潰，久潰不斂，血虛萎黃，內熱消渴','甘，溫','以根條粗長、菊花心鮮明、空洞小、破皮少者為佳；紅芪以皮色紅潤、根條均勻、堅實、粉性足者為佳','直根圓柱形、有的有分枝，上端較粗，長30~90釐米，直徑1~3.5釐米，表面縱皺色淡棕黃色或淡棕褐色，有不整齊的縱皺紋或縱溝質，硬而韌有粉性，皮部黃白較疏鬆；木部菊花紋理狀，氣似豆腥味微甜。老根中心偶有枯朽狀，黑褐色或呈空洞。氣微，味微甜，嚼之微有豆腥味', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0041','黃芩','Baikal Skullcap Root','清熱燥濕，瀉火解毒，止血，安胎，降血壓。用於濕溫、暑溫胸悶嘔惡，濕熱痞滿，瀉痢，黃疸，肺熱咳嗽，高熱煩渴，血熱吐衄，癰腫瘡毒，胎動不安','苦，寒','以根長、質堅實、色黃者為佳','該品呈圓錐形，扭曲，長8~25cm，直徑1~3cm。表面棕黃色或深黃色，有稀疏的疣狀細根痕，上部較粗糙，有扭曲的縱皺或不規則的網紋，下部有順紋和細皺。質硬而脆，易折斷，斷面黃色，中間紅棕色，通稱子芩，以清火養陰為主；老根中間呈暗棕色或棕黑色，枯朽狀或已成空洞，稱枯芩，以清火敗毒為主。氣微，味苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0042','胡黃連','Figwortflower Picrorhiza Rhizome','清熱，涼血，燥濕。 陰虛骨蒸；潮熱盜汗；小兒疳疾；濕熱瀉痢；黃疸；吐血；衄血；目赤腫痛；癰腫瘡瘍；痔瘡腫毒','苦，寒','以條粗、折斷時有粉塵、斷面灰黑色、味苦者為佳','根莖圓柱形，平直或彎曲，多不分枝，市售品多為小段，長2~9cm，直徑3~8mm。表面灰黃色至黃棕色，有光澤，粗糙，具縱皺及橫環紋，栓皮脫落處呈褐色；上端有殘留的葉跡，密集呈鱗片狀，暗紅棕色，或脫落後呈半圓狀的節痕。根痕圓點狀，近節處較多。質硬而脆，易折斷，折斷時有粉塵；斷面可見維管束小點4~7個，排列成環。氣微，味極苦而持久', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0043','桔梗','Balloonflower Root','宣肺、祛痰、利咽、排膿、利五臟、補氣血、補五勞、養氣。主治咳嗽痰多、咽喉腫痛、肺癰吐膿、胸滿脅痛、痢疾腹痛、口舌生瘡、目赤腫痛、小便癃閉','苦、辛，平','以條肥大、體堅實、色白者為佳','根長圓形或長紡錘形，稍扭曲，下部偶有分支，長6~20cm，直徑1~2cm。表面淡黃白色或淡黃棕色 (未去栓皮者)，皺縮，有扭轉的縱溝及橫長的皮孔斑痕，上部有橫紋；頂端蘆頭 (根莖) 長0.5~4cm，有半月形凹陷的莖痕，呈盤節狀。質堅實，橫斷面淡黃色，角質樣，形成層環棕色，皮部有稀少放射狀裂隙，木部較緊密。氣微，味微甜後苦。飲片性狀：桔梗為不規則圓形厚片，表面白色或淡黃白色，有一淺棕色環，周邊呈淡黃白色，有皺紋。無臭，味微甜後苦。蜜桔梗，形如桔梗生片，表面淡黃色至淡棕黃色，滋潤，微具蜜糖香氣。味甜而後苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0044','蘆根','Reed Rhizome','清熱生津，除煩，止嘔，利尿。用於熱病煩渴、胃熱嘔吐、肺熱咳嗽、肺癰吐膿、熱淋澀痛','甘，寒','以條粗壯、黃白色、有光澤、無鬚根、質嫩者為佳','乾蘆根呈壓扁的長圓柱形。表面有光澤，黃白色，節部較硬，顯紅黃色，節間有縱皺紋。質輕而柔韌，不易折斷，氣無，味微甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0045','麥冬','Dwarf Lilyturf Root Tuber','滋陰生津、潤肺止咳、清心除煩。主治熱病傷津、心煩、口渴、咽乾肺熱、咳嗽、肺結核','甘、微苦，涼','以飽滿、皮細、糖性足、木心細、內外淡黃白色不泛油者為佳','川麥冬塊根較短小，表面乳白色。質較堅硬，香氣小，味淡，少粘性', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0046','木香','Costusroot','行氣止痛；調中導滯，溫中消食','辛、苦，溫','以條勻、質堅實、沒性足、香氣濃郁者為佳','根圓柱形、平圓柱形，長5~15cm，直徑0.5~5.5cm。表面黃棕色、灰褐色或棕褐色，栓皮大多已除去，有明縱溝及側根痕，有時可見網狀紋理。質堅硬，難折斷，斷面稍平坦，灰黃色、灰褐色或棕褐色，散有深褐色油室小點，形成層環棕色，有放射狀紋理，老根中央多枯朽。氣芳香濃烈而特異，味先甜後苦，稍刺舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0047','茜草','Indian Madder Root','涼血，止血，祛瘀，通經，鎮咳，祛痰。用於吐血，衄血，崩漏，外傷出血，經閉瘀阻，關節痹痛，跌撲腫痛。現代醫學臨床研究：可以治療出血性疾患，慢性氣管炎，慢性腹瀉，風濕性關節炎，治療軟組織損傷，治療白細胞減少症','苦，寒','以條粗、外皮紅棕色、斷面黃棕色者為佳','該品根莖呈結節狀，叢生粗細不等的根。根呈圓柱形，略彎曲，長10~25cm，直徑0.2~1cm；表面紅棕色或暗棕色，具細縱皺紋及少數細根痕；皮部脫落處呈黃紅色。質脆，易折斷，斷面平坦皮部狹，紫紅色，木部寬廣，淺黃紅色，導管孔多數。無臭，味微苦，久嚼刺舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0048','羌活','Incised Notopterygium Rhizome and Root','散表寒；祛風濕；利關節；止痛。主治外感風寒、頭痛無汗、風寒濕痹、風水浮腫、瘡瘍腫毒','辛、苦，溫','均以條粗壯、有隆起曲折環紋、斷面質緊密、朱砂點多、香氣濃郁者為佳','條羌：為乾燥的根及支根。呈圓柱形或分枝，長3~17cm，直徑約0.7~1.7cm，頂端偶可見有根莖，表面棕褐色，有縱紋及疣狀突起的鬚根痕，上端較粗大，有稀疏隆起的環節，質疏鬆而脆、易折斷，斷面不平坦，皮部淺棕色，木部黃白色，有菊花紋，朱砂點不明顯，中央無髓。氣味較淡薄', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0049','前胡','Common Hogfennel Root','宣散風熱，降氣化痰。用於治療風熱感冒、咳嗽痰多、咯痰黃稠等症','辛、苦，微寒','均以條粗壯、質柔軟、香氣濃者為佳','紫花前胡：根頭部較粗短，根少有纖維狀葉鞘殘基。折斷面皮部易與木部分離。氣芳香，味微苦、辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0050','秦艽','Largeleaf Gentian Root','袪風濕，舒筋絡，清虛熱。用於風濕痹痛，筋脈拘攣，骨節酸痛，日晡潮熱，小兒疳積發熱','辛、苦，微寒','以質堅實、棕黃色、氣味濃者為佳','小秦艽：呈類圓錐形或類圓柱形，長8~15cm，直徑0.2~1cm。表面棕黃色。主根通常1 個，殘存的莖基有纖維狀葉鞘，下部多分枝。斷面黃白色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0051','射干','Blackberrglily Rhizome','清熱解毒，利咽喉，消痰涎。主治喉痹咽痛，咳逆上氣，痰涎壅盛，瘰鬁結核，瘧母，婦女經閉，癰腫瘡毒','苦，寒','以肥壯、肉色黃、無毛須者為佳','乾燥根莖呈不規則的結節狀，長約3~10cm，直徑1~1.5cm。表面灰褐色或有黑褐色斑，皺縮有斜向或扭曲的環狀皺紋，排列甚密，上面有圓盤狀凹陷莖痕，下面有殘留的細根及根痕。質堅硬，斷面黃色，顆粒狀。氣微，味苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0052','升麻','Skunk Bugbane Rhizome','發表透疹，清熱解毒，升舉陽氣。用於風熱頭痛，齒痛，口瘡，咽喉腫痛，麻疹不透，陽毒發斑；脫肛，子宮脫垂','辛、微辛，微寒','以體輕泡、質堅、表變黑褐色且個大者為佳','呈不規則的長形塊狀，多分枝，呈結節狀，長10~20cm，直徑2~4cm。表面黑褐色或棕褐色，粗糙不平，有堅硬的細鬚根殘留，上面有數個圓形空洞的莖基痕，洞內壁顯放射狀網紋；下面凹凸不平，具鬚根痕。體輕，質堅硬，不易折斷，斷面不平坦，有裂隙，纖維性，黃綠色或淡黃白色。氣微，味微苦而澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0053','石菖蒲','Tatarinow Sweerflag Rhizome','化濕開胃，開竅豁痰，醒神益智。用於脘痞不饑，噤口下痢，神昏癲癇，健忘耳聾','辛、苦，溫','以條粗、斷面色類白、香氣濃者為佳','根莖呈扁圓柱形，稍彎曲，常有分枝，長3~20cm，直徑0.3~1cm。表面棕褐色、棕紅色或灰黃色，粗糙，多環節，節間長2~8mm；上側有略呈扁三角形的葉痕，左右交互排列，下側有圓點狀根痕，節部有時殘留有毛鱗狀葉基。質硬脆，折斷面纖維性，類白色或微紅色；橫切面內皮層環明顯，可見多數“筋脈點”及棕色油點。氣芳香，味苦、微辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0054','天冬','Cochinchinese Asparagus Root Tuber','養陰清熱，潤燥生津。主治肺結核，支氣管炎，白喉，百日咳，口燥咽乾，熱病口渴，糖尿病，大便燥結；外用治瘡瘍腫毒，蛇咬傷','甘、苦，寒','以肥滿、緻密、黃白色、半透明者為佳','乾燥的塊根呈長圓紡錘形，中部肥滿，兩端漸細而鈍，長6~20cm，中部直徑0.5~2cm。表面黃白色或淺黃棕色，呈油潤半透明狀，有時有細縱紋或縱溝，偶有未除淨的黃棕色外皮。乾透者質堅硬而脆，未乾透者質柔軟，有粘性，斷面蠟質樣，黃白色，半透明，中間有不透明的細木心。臭微，味甘微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0055','天花粉','Snakegourd Root','清熱瀉火，生津止渴，排膿消腫。治熱病口渴、消渴、黃疸、肺燥咳血、癰腫、痔痿。對於治療糖尿病，常用它與滋陰藥配合使用，以達到標本兼治的作用','甘、微苦，微寒','以根肥大、白色、堅實、粉性足且橫斷面筋脈點少者為佳','該品呈不規則圓柱形、紡錘形或瓣塊狀，長8~16cm，直徑1.5~5.5cm。表面黃白色或淡棕黃色，有縱皺紋，細根痕及略凹陷的橫長皮孔，有的有黃棕色外皮殘留。質堅實，斷面白色或淡黃色，富粉性，橫切面可見黃色木質部，“筋脈點”略呈放射狀排列，縱剖面可見黃色縱條紋狀木質部。無臭，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0056','天南星','Reddish Jackinthepulpit Tuber','燥濕化痰，祛風定驚，消腫散結。主治中風半身不遂、癲癇、驚風、破傷風、跌打損傷、或蟲蟻咬傷等病症','苦、辛，溫，有毒','以個大，粉性足、色白者為佳','本品呈扁球形，高 1~2cm，直徑1.5~6.5cm 。表面類白色或淡棕色，較光滑，頂端有凹陷的莖痕，周圍有麻點狀根痕，有的塊莖周邊有小扁球狀側芽。質堅硬，不易破碎，斷面不平坦，白色，粉性。氣微辛，味麻辣', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0057','烏藥','Combined Spicebush Root','行氣止痛，溫腎散寒','辛，溫','以淺棕色、個大、肥壯、質嫩、香氣濃者為佳','多呈紡錘狀，略彎曲，有的中部收縮成連珠狀，長6~15cm，直徑1~3cm。表面黃棕色或黃褐色，有縱皺紋及稀疏的細根痕。質堅硬。切片厚0.2~2mm，切面黃白色或淡黃棕色，射線放射狀，可見年輪環紋，中心顏色較深。氣香，味微苦、辛，有清涼感', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0058','香附','Nutgrass Galingale Rhizome','理氣解鬱，調經止痛。用於肝鬱氣滯，胸、脅、脘腹脹痛，消化不良，月經不調，經閉痛經，寒疝腹痛，乳房脹痛','辛、微苦、微甘，平','以個大、堅實、氣香、毛須去淨者為佳','根莖多呈紡錘形，或略彎曲，長2~3.5cm，直徑0.5~1cm。表面棕褐色或黑褐色，有不規則縱皺紋，並有明顯而略隆重起的環節 6~10個，節間長2~6mm，節上有眾多朝向一方的棕色毛須，並殘留根痕；去淨毛須的較光滑，有細密的縱脊紋。質堅硬，蒸煮者斷面角質樣，棕黃色或棕紅色，生曬者斷麵粉性，類白色；內皮層環明顯，中柱色較深，維管束點清晰可見。氣芳香特異，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0059','薤白','Longstamen Onion Bulb','胸痹心痛徹背；胸脘痞悶；咳喘痰多；脘腹疼痛；泄痢後重；白帶；瘡癤癰腫；通陽散結，行氣導滯','辛、苦，溫','均以個大、飽滿、質堅、黃白色、半透明者為佳','天藍小根蒜：鱗莖近球形，直徑1~2cm', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0060','細辛','Manchurian Wildginger Herb','解表散寒；祛風止痛；溫肺化飲；通竅。主治風寒表證；頭痛，牙痛；風濕痹痛；痰飲咳喘；鼻塞；鼻淵；口瘡','辛，溫','均以根灰黃、葉綠、乾燥、味辛辣而麻舌者為佳','漢城細辛：根莖長1~10cm，直徑0.1~0.5cm，節間長約0.1~1cm，氣味同北細辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0061','西洋參','American Ginseng','補氣養陰，清熱生津。用於氣虛陰虧，內熱，咳喘痰血，虛熱煩倦，消渴，口燥咽乾。西洋參有抗疲勞、抗氧化、抗應激、抑制血小板聚集、降低血液凝固性的作用，另外，對糖尿病患者還有調節血糖的作用','甘、微苦，微寒','以條均勻、質硬、表面橫紋緊密、氣濃清香者為佳','本品呈紡錘形、圓柱形或圓錐形，長3~12cm，直徑0.8~2cm。表面淺黃褐色或黃白色，可見橫向環紋及線狀皮孔，並有細密淺縱皺紋及鬚根痕。主根中下部有一至數條側根；多已折斷。有的上端有根莖 (蘆頭)，環節明顯，莖痕 (蘆碗) 圓形或半圓形具不定根疔或已折斷。體重，質堅實，不易折斷，斷面平坦，淺黃白色，略顯粉性，皮部可見黃棕色點狀樹脂道，形成層環紋棕黃色，本部略呈放射狀紋理。氣微而特異，味微苦、甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0062','玄參','Figwort Root','清熱涼血，瀉火解毒，滋陰。用於溫邪入營，內陷心包，溫毒發斑，熱病傷陰、舌絳煩渴、津傷便秘、骨蒸勞嗽、目赤、咽痛、瘰鬁、白喉、癰腫瘡毒','甘、苦、鹹，微寒','以條粗壯、堅實、斷面烏黑者為佳','根類圓柱形，中間略粗或上粗下細，有的微彎曲，長6~20cm，直徑1~3cm。表面灰黃色或灰褐色，有不規則的縱溝、橫向皮孔及稀疏的橫裂紋和鬚根痕。質堅實，不易折斷，斷面黑色，微有光澤。氣特異似焦糖，味甘、微苦、鹹', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0063','延胡索','Yanhusuo Tuber','活血散瘀，行氣止痛。主治胸痹心痛，脅肋、脘腹諸痛，頭痛、腰痛、疝氣痛、筋骨痛、痛經、經閉，產後瘀腹痛，跌打損傷','辛、苦，溫','以個大、飽滿、質堅、色黃、內色黃亮者為佳','乾燥塊莖，呈不規則扁球形，直徑1~2cm，表面黃色或褐黃色，頂端中間有略凹陷的莖痕，底部或有疙瘩狀凸起。質堅硬而脆，斷面黃色，角質，有蠟樣光澤。無臭，味苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0064','銀柴胡','Lanceolate Dichotomous Starwort Root','清熱涼血。治虛勞骨蒸，陰虛久瘧，小兒瘠熱羸瘦','甘，微寒','以根長均勻、頂端具“珍珠盤”、外皮淡黃色、斷面黃白色者為佳','呈類圓柱形，偶有分枝，長15~40cm，直徑0.5~2.5cm。表面淺棕黃色至淺棕色，有扭曲的縱皺紋及支根痕，多具孔穴狀或盤狀凹陷，從砂眼處折斷可見棕色裂隙中有細砂散出，根頭部略膨大，有密集的呈疣狀突起的芽苞、莖或根莖的殘基。質硬而脆，易折斷，斷面不平坦，較疏鬆，有裂隙，皮部甚薄，木部有黃、白色相間的放射狀紋理。氣微，味甘。栽培品有分枝，下部多扭曲，直徑0.3~1.2cm。表面淺棕黃色或淺黃棕色，縱皺紋細膩明顯，細支根痕多呈點狀凹陷。根頭部有多數疣狀突起。幾無砂眼。折斷面質地較緊密，幾無裂隙，略顯粉性，木部放射狀紋理不甚明顯。味微甜', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0065','遠志','Thinleaf Milkwort Willd.','安神益智，祛痰，消腫。用於心腎不交引起的失眠多夢，健忘驚悸，神志恍惚，咳痰不爽，瘡瘍腫毒，乳房腫痛','苦、辛，微溫','以皮厚、條粗者為佳','該品呈圓柱形，略彎曲，長3~15cm，直徑0.3~0.8cm。表面灰黃色至灰棕色，有較密並深陷的橫皺紋、縱皺紋及裂紋，老根的橫皺紋較密更深陷，略呈結節狀。質硬而脆，易折斷，斷面皮部棕黃色，木部黃白色，皮部易與木部剝離。氣微，味苦、微辛，嚼之有刺喉感', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0066','玉竹','Fragrant Solomonseal Rhizome','滋陰潤肺；養胃生津。燥咳；勞嗽；熱病陰液耗傷之咽乾口渴；內熱消渴；陰虛外感；頭昏眩暈；筋脈攣痛','甘，平','以肥壯、條長、色黃白光潤、半透明、味甜者為佳','該品呈長圓柱形，略扁，少有分枝，長4~18cm，直徑0.3~1.6cm。表面黃白色或淡黃棕色，半透明，具縱皺紋及微隆起的環節，有白色圓點狀的鬚根痕和圓盤狀莖痕。質硬而脆或稍軟，易折斷，斷面角質樣或顯顆粒性。氣微，味甘，嚼之發黏', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0067','澤瀉','Oriental Waterplantain Tuber','利水滲濕；泄熱通淋。主小便不利；熱淋澀痛；水腫脹滿；泄瀉；痰飲眩暈；遺精','甘、淡，寒','以塊大、黃白色、光滑、質充實、粉性足者為佳','塊莖類球形、橢圓形或卵圓形、長2~7cm，直徑2~6cm。表面黃白色或淡黃棕色，有不規則的橫向環狀淺溝紋及多數細小突起的鬚根痕，底部有的有瘤狀芽痕。質堅實，斷面黃白色，粉性，有多數細孔。氣微，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0068','知母','Common Anemarrhena','清熱瀉火，生津潤燥。用治外感熱病，高熱煩渴，內治肺熱咳嗽，胃熱消渴，肺燥咳嗽；腸燥便秘；骨蒸潮熱','苦、甘，寒','均以質硬、條肥大、斷面黃白色者為佳','該品呈長條狀，微彎曲，略扁，偶有分枝，長3~15cm，直徑0.8~1.5cm，一端有淺黃色的莖葉殘痕。表面黃棕色至棕色，上面有一凹溝，具緊密排列的環狀節，節上密生黃棕色的殘存葉基，由兩側向根莖上方生長；下面隆起而略皺縮，並有凹陷或突起的點狀根痕。質硬，易折斷，斷面黃白色。氣微，味微甜、略苦，嚼之帶粘性', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0069','紫菀','Tatarian Aster Root and Rhizome','潤肺下氣，消痰止咳。用於痰多喘咳、新久咳嗽、勞嗽咳血','辛、苦，溫','以根長、紫紅色、無雜質、質柔韌者為佳','根莖不規則塊狀，大小不一，頂端有莖、葉的殘基，下端偶有末除盡的母根，質梢硬。根莖簇生多數細根，長3~15cm，直徑0.1~0.3cm，多編成辮狀；表面紫紅色或灰紅色，有縱皺紋；質較柔韌。氣微香，味甜、微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0070','甘草','Liquorice Root','益氣補中，清熱解毒，祛痰止咳，緩急止痛，調和藥性','甘，平','以皮細緊、色紅棕、質堅實、斷面色黃白、粉性足者為佳','圓柱形，外皮鬆緊不一。表面紅棕色或灰棕色，具顯著的縱皺紋、溝紋、皮孔及稀疏的細根痕。質堅實，斷面略顯纖維性，黃白色，粉性。根莖表面有芽痕，斷面中部有髓。氣微，味甜而特殊。飲片為斜切片', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0071','半夏','Ternate Pinellia','燥濕化痰，降逆止嘔，消痞散結。用於濕痰寒痰，咳喘痰多，痰飲 眩悸，風痰眩暈，痰厥頭痛.嘔吐反胃.胸院痞悶，梅核氣；外治痛腫痰核','辛、溫，有毒','以個大、皮淨、色白、質堅實、粉性足者為佳','本品呈類球形，有的稍偏斜，表面白色或淺黃色，頂端有凹陷的莖痕，周圍密佈麻點狀根痕；下面鈍圓，較光滑。質堅實、斷面潔白，富粉性。氣微，味辛辣、麻舌而刺喉', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0072','鉤藤','Sharpleaf Uncaria Stem with Hools','清熱平肝；熄風止痙。小兒驚風；夜啼；熱盛動風；子癇；肝陽眩暈；肝火頭脹痛','甘，涼','以莖細、帶雙鉤、鉤結實、光滑、紫紅色者為佳','莖枝圓柱形或類方柱形，直徑2~6mm。表面紅棕色至紫棕色或棕褐色，上有細縱紋，無毛。莖上具略突起的環節，對生兩個向下彎曲的鉤或僅一側有鉤，鉤長1~2cm，形如船鋪，先端漸尖，基部稍圓。鉤基部的枝上可見葉柄脫落後凹點及環狀的托葉痕。體輕，質硬。橫截面外層棕紅色，髓部淡棕色或淡黃色。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0073','桂枝','Cassiabarktree Twig','發汗解肌，溫通經脈，助陽化氣，平沖降氣。用於風寒感冒，脘腹冷痛，血寒經閉，關節痹痛，痰飲，水腫，心悸，奔豚','辛、甘，溫','以枝條細嫩均勻、棕黃色、氣香濃者為佳','呈長圓柱形，多分枝，長30~75cm，粗端直徑0.3~1cm。表面紅棕色至棕色，有縱棱線、細皺紋及小疙瘩狀的葉痕、枝痕、芽痕，皮孔點狀。質硬而脆，易折斷。切片厚2~4mm，斷面皮部紅棕色，木部黃白色至淺黃棕色，髓部略呈方形。有特異香氣，味甜、微辛，皮部味較濃', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0074','木通','Akabia Stem','清熱利尿；活血通脈。主小便赤赤；淋濁；水腫；胸中煩熱；喉喉疼痛；口舌生瘡；風濕痹痛；乳汁不通；經閉；痛經','苦，微寒','以條粗、均勻者為佳','白木通藤莖直徑5~8mm。表面黃棕色或暗棕色，有不規則縱溝紋；有枝痕。質堅韌，難折斷，斷面木部淡黃色，導管細密，排列不規則，射線約13條，淺黃色放射狀，髓類圓形。氣微，味徽苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0075','桑寄生','Chinese Taxillus Herb','祛風濕，益肝腎，強筋骨，安胎','苦、甘，平','以紅褐色、枝細嫩、葉多者為佳','莖枝呈圓柱形，長3~4cm，直徑0.2~1cm；表面紅褐色或灰色，具細縱紋，並有眾多細小皮孔，小枝有棕紅色細毛。有時逞葉，多捲縮，完整者呈卵圓形，全緣，棕色，革質，幼葉亦被棕紅色細毛。莖堅硬，斷面不整齊，皮部紅棕色，木櫚色較淺。無臭，味澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0076','通草','Rice Paper Plant Pith','清熱利濕；通乳，用於淋症澀痛；小便不利；水腫；黃疸；濕溫病；小便短赤；產後乳少；經閉；帶下','甘、淡，微寒','以條粗壯、色潔白、有彈性、空心有隔膜者為佳','莖賄呈圓柱形，長20~40cm，直徑1~2.5cm。表面白色或淡黃色，有淺縱溝紋。體輕，質鬆軟，稍有彈性，易折斷，斷面平坦，顯銀白色光澤，中內有直徑0.3~1.5cm的空心或半透明的薄膜，縱剖面呈梯狀排列，實心者 (僅在細小莖賄中的某小段) 少見。無臭，無味', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0077','竹茹','Bamboo Shavings','清熱化痰，除煩止嘔。用於痰熱咳嗽、膽火挾痰、煩熱嘔吐、驚悸失眠、中風痰迷、舌強不語、胃熱嘔吐、妊娠惡阻、胎動不安','甘，微寒','以身乾、黃綠色、細絲均勻、質柔軟者為佳','本品呈不規則的絲狀或薄帶狀，常捲曲扭縮而纏結成團或作創花狀，長短不一，寬0.5~0.7cm，厚0.3~0.5cm。全體淡黃白色、淺綠色、青黃色、灰黃色、灰黃綠色、黃而韌，有彈性。氣稍清香，味微甜', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0078','皂角刺','Chinese Honeylocust Spine','消腫托毒，排膿，殺蟲。用於痛疽初起或膿成不潰；外治疥癬麻風','辛，溫','以片薄、純淨、無核梗、色棕紫、切片中間棕紅色、慷心者為佳','本品為主刺及1~2次分枝的棘刺。主刺長3~15cm或更長，直徑0.3~1cm；分枝刺長1~6cm，刺端銳尖。表面紫棕色或棕褐色。體輕，質堅硬，不易折斷。切片厚0.1~0.3cm，常帶有尖細的刺端；木部黃白色，髓部疏鬆，淡紅棕色；質脆，易折斷。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0079','白扁豆','White Hyacinth Bean','補脾和中，化濕消暑。用於脾胃虛弱、食欲不振、大便溏瀉、白帶過多、暑濕吐瀉、胸悶腹脹','甘，微溫','以粒大、飽滿、色白者為佳','種子扁橢圓形或扁卵圓形，長0.8~1.3cm，寬6~9mm，厚約7mm。表面淡黃白色或淡黃色，平滑，稍有光澤，有的可見棕褐色斑點，一側邊緣有隆起的白色半月形種阜。長7~10mm，剝去後可見凹陷的種臍，緊接種阜的一端有珠孔，另端有種脊。質堅硬，種皮薄而脆，子葉2片，肥厚，黃白色。氣微，味淡，嚼之有豆腥氣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0080','白果','Ginkgo Seed','斂肺定喘；止帶縮尿。哮喘痰嗽；白帶；白濁；遺精；尿頻；無名腫毒； 皶鼻','甘、苦、澀，平，有小毒','以殼色黃白、種仁飽滿，斷面色淡黃者為佳','除去外種皮的種子卵形或橢圓形，長1.5~3cm，寬1~2.2cm。外殼 (中種皮) 骨質，光滑，表面黃白色或淡棕黃色，基部有一圓點狀突起，邊緣各有1條棱線，偶見3條棱線。內種皮膜質，紅褐色或淡黃棕色。種仁扁球形，淡黃色，胚乳肥厚，粉質，中間有空隙；胚極小。氣無，味微甘、苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0081','柏子仁','Chinese Arborvilae Seed','養心安神，潤腸通便。用於虛煩不眠，心悸怔忡，腸燥便秘等症','甘，平','以粒大，飽滿、油性大而不泛油、無皮殼雜質、黃白色者為佳','長卵形或長橢圓形，長0.3~0.7cm，直徑0.1~0.3cm。新貨黃白色或淡黃色，久置陳貨則呈黃棕色，並有油點滲出。種仁外面常包有薄膜質的種皮，頂端略尖，圓三棱形，基部鈍圓。質軟油潤，斷面黃白色，胚乳較多，子葉2枚，均含豐富的油質。氣微香，味淡而有油膩感', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0082','蓽茇','Long Pepper Fruit','溫中散寒，下氣止痛。用於脘腹冷痛、嘔吐、泄瀉、偏頭痛、鼻淵、外治牙痛、冠心病、心絞痛。治心腹冷痛，嘔吐吞酸，腸鳴泄瀉，冷痢，陰疝，頭痛，鼻淵，齒痛','辛，熱','以飽滿肥大、堅實、黑褐色、斷面稍紅、氣味濃者為佳','呈圓柱形，稍彎曲，由多數小漿果集合而成，長1.5~3.5cm，直徑0.3~0.5cm。表面黑褐色或棕色，有斜向排列整齊的小突起，基部有果穗梗殘存或脫落。質硬而脆，易折斷，斷面不整齊，顆粒狀。小漿果球形，直徑約0.1cm，斷面顆粒狀。有特異香氣，味辛辣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0083','檳榔','Betelnutpalm Seed','驅蟲；消積；下氣；行水；截瘧。蟲積；食滯；脘腹脹痛；瀉痢後重；腳氣；水腫；瘧疾','苦、辛，溫','以果大體重、堅實、不破裂者為佳','乾燥種子呈圓錐形或扁圓球形，高1.5~3cm，基部直徑2~3cm，表面淡黃棕色或黃棕色，粗糙，有顏色較淺的網形凹紋，並偶有銀色斑片狀的內果皮附著。基部中央有圓形凹陷的珠孔，其旁有淡色的疤痕狀的種臍。質堅實，縱剖面可見外緣的棕色種皮向內褶入，與乳白色的胚乳交錯，形成大理石樣花紋。基部珠孔內側有小形的胚，常呈棕色，乾枯皺縮不顯。氣無，味澀而微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0084','補骨脂','Malaytea Scurfpea Fruit','補腎助陽；納氣平喘；溫脾止瀉。主腎陽不足；下元虛冷；腰膝冷痛；陽痿遺精；尿頻；遺尿；腎不納氣；虛喘不止；脾腎兩虛；大便久瀉；白癜風；斑禿；銀屑病','辛、苦，溫','以粒大、飽滿、黑色者為佳','果實扁圓狀腎形，一端略尖，少有宿萼。懷補骨脂長4~5.5mm，寬約2~4mm，厚約1mm；川補骨脂較小。表面黑棕色或棕褐色，具微細網紋，在放大鏡下可見點狀凹。質較硬脆，剖開後可見果皮與外種皮緊密貼生，種子凹側的上端略下處可見點狀種臍，另一端有合點，種脊不明顯。外種皮較硬，內種皮膜質，灰白色；子葉2枚，肥厚，淡黃色至淡黃棕色，陳舊者色深，其內外表面常可見白色物質，於放大鏡下觀察為細小針晶；胚很小。宿萼基部連合，上端5裂，灰黃色，具毛茸，並密佈褐色腺點。氣芳香特異、味苦微辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0085','草豆蔻','Katsumada Galangal Seed','化濕消痞，行氣溫中，開胃消食。用於濕濁中阻，不思飲食，濕溫初起胸悶不饑，寒濕嘔逆，胸腹脹痛，食積不消','辛，溫','以種子飽滿、堅實、類球形、氣濃者為佳','該品為類球形的種子團，直徑1.5~2.7cm。表面灰褐色，中間有黃白色的隔膜，將種子團分成3 瓣，每瓣有種子多數，粘連緊密，種子團略光滑。種子為卵圓狀多面體，長3~5mm，直徑約3mm，外被淡棕色膜質假種皮，種脊為一條縱溝，一端有種臍；質硬，將種子沿種脊縱剖兩瓣，縱斷面觀呈斜心形，種皮沿種脊向內伸入部分約占整個表面積的1/2 ；胚乳灰白色。氣香，味辛，微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0086','草果','Tsaoko Amomum Fruit','燥濕除寒，祛痰截瘧，消食化食。主治瘧疾，痰飲痞滿，脘腹冷痛，反胃，嘔吐，瀉痢，食積','辛，溫','以個大、飽滿、色紅棕、氣味濃行為佳','果實橢圓形，長2~4.5cm，直徑1~2.5cm，表面棕色或紅棕色，具3鈍棱及明顯的縱溝及棱線，先端有圓形突起的柱基，基部有果柄或果柄痕，果皮堅韌，內分3室，每室含種子7~24粒，種子集結成團。種子多面形，直徑5~7mm，黃棕色或紅棕色，具灰白色膜質假種皮，中央有凹陷合點，較狹端腹面有圓窩狀種臍，種脊凹陷成1縱溝。氣芳香，味辛、辣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0087','陳皮','Tangerine Peel','理氣健脾，燥濕化痰。用於胸脘脹滿，食少吐瀉，咳嗽痰多','苦、辛，溫','以皮張大、完整、色鮮豔油潤、香氣濃者佳','常剝成數瓣，基部相連，有的呈不規則的片狀，厚1~4mm。外表面橙紅色或紅棕色，有細皺紋及凹下的點狀油室；內表面淺黃白色，粗糙，附黃白色或黃棕色筋絡狀維管束。質稍硬而脆。氣香，味辛、苦。廣陳皮：常3瓣相連，形狀整齊，厚度均勻，約1mm。點狀油室較大，對光照視，透明清晰。質較柔軟', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0088','車前子','Asiatic Plantain Seed','清熱利尿；滲濕止瀉；明目；祛痰。主小便不利；淋濁帶下；水腫脹滿；暑濕瀉痢；目赤障翳；痰熱咳喘','甘、淡，微寒','以粒大、均勻飽滿、色棕紅者為佳','種子略呈橢圓形或不規則長圓形，稍扁，長約2mm，寬約1mm。表面淡棕色或棕色，略粗糙不平。於擴大鏡下可見微細縱紋，于稍平一面的中部有淡黃色凹點狀種臍。質硬，切段面灰白色。種子放入水中，外皮有粘液釋出。氣微，嚼之帶粘液性', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0089','赤小豆','Rice Bean','利水除濕，和血排膿，消腫解毒。治水腫，腳氣，黃疸，瀉痢，便血，癰腫','甘、酸，平','以身乾，顆粒飽滿，色赤紅發暗者為佳','乾燥種子略呈圓柱形而稍扁，長5~7mm，直徑約3mm，種皮赤褐色或紫褐色，平滑，微有光澤，種臍線形，白色，約為全長的2/3，中間凹陷成一縱溝，偏向一端，背面有一條不明顯的棱脊。質堅硬，不易破碎，除去種皮，可見兩瓣乳白色於仁。氣微，嚼之有豆腥味', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0090','大腹皮','Areca Peel','下氣寬中，行水消腫之功效。現代研究，該品有興奮胃腸道平滑肌、促胃腸動力作用，並有促進纖維蛋白溶解等作用','辛，微溫','以色黃白、質柔韌、無雜質者為佳','略呈橢圓形或長卵形瓢狀，長4~7cm，寬2~3.5cm，厚0.2~0.5cm。 外果皮深棕色至近黑色，具不規則的縱皺紋及隆起的橫紋，頂端有花柱殘痕，基部有果梗及殘存萼片。內果皮凹陷，褐色或深棕色、光滑呈硬殼狀。體輕，質硬，縱向撕裂後可見中果皮纖維。氣微，味微澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0091','淡豆豉','Fermented Soybean','解肌發表；宣鬱除煩。主治外感表證；寒熱頭痛；心煩；胸悶；虛煩不眠','辛、甘、微苦，寒','以柔軟、無糟粒、香氣濃郁者為佳','該品呈橢圓形，略扁，長0.6~1cm，直徑0.5~0.7cm。表面黑色，皺縮不平。質柔軟，斷面棕黑色。具有膜狀種皮，氣香，味微甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0092','大棗','Common Jujube','補中益氣，養血安神。用於脾虛食少，乏力便溏，婦人臟躁','甘，溫','以個大、色紅、肉質油潤者為佳','本品呈橢圓形或球形，長2~3.5cm，直徑1.5~2.5cm。表面暗紅色，略帶光澤，有不規則皺紋。基部凹陷，有短果梗。外果皮薄，中果皮棕黃色或淡褐色，肉質，柔軟，富糖性而油潤。果核紡錘形，兩端銳尖，質堅硬。氣微香，味甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0093','瓜蔞','Mongolian Snakegourd Fruit','潤肺，化痰，散結，潤腸。治痰熱咳嗽，胸痹，結胸，肺痿咳血，消渴，黃疸，便秘，癰腫初起','甘、苦，寒','以顆粒飽滿、淡黃白色、整齊不碎、不出油、無核殼者為佳','果實呈卵狀扁平橢圓形，長11~16mm，寬6~12mm，厚2~3.5mm。表面淺棕色至棕褐色，平滑，邊緣有一圈溝紋，頂端尖有種臍，基部鈍圓或較狹。種皮堅硬，剖開後可見內種皮膜質，色灰白至灰綠色，含兩片黃白色子葉，富油性。瓜蔞子內種皮白色，外種皮棕褐色，子夜2', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0094','訶子','Medicine Terminalia','斂肺；澀腸；下氣；利咽，清涼解毒。主治久瀉；久痢；脫肛；喘咳痰嗽；久咳失音','苦、酸、澀，平','以棕黃色、個大、微皺而有光澤者為佳','果實呈卵形或橢圓形，長2.4cm，直徑2~2.5cm。表面棕褐色，略具光澤，有5~6條縱菱形及不規則的皺紋，在縱棱線之間有1~2條明顯或不明顯的縱凸起，可見細密橫向紋理，基部有圓形果柄痕。質堅實，剖開後，果肉厚2~4mm，黃棕色或黃褐色。果核長l.5~2.5cm，淺黃色，粗糙，堅硬、種子一粒，狹長紡錘形，長約1cm，直徑2~4mm，膜質種皮黃棕色，子葉2，白色，相互重疊卷旋。無臭，味酸澀而後甜', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0095','萊菔子','Garden Radish Seed','消食除脹，降氣化痰。用於飲食停滯、脘腹脹痛、大便秘結、積滯瀉痢、痰壅喘咳。','辛、甘，平','以飽滿粒大、堅實、紅棕色者為佳','種子類卵圓形或橢圓形，稍扁，長2.5~4mm，寬2~3mm。表面黃棕色、紅棕色或灰棕色，一端有深棕色圓形種臍，一側有數條縱溝。種皮薄而脆，子葉2，黃白色，有油性。味淡、微苦、辛', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0096','連翹','Weeping Forsythia Fruit','清熱解毒，消腫散結，疏散風熱，有“瘡家聖藥”之稱。治溫熱，丹毒，斑疹，癰瘍腫毒，瘰鬁，小便淋閉，清心火','苦、微寒','青翹以色綠、不開裂者為佳','青翹：呈狹卵形至卵形，兩端狹尖，多不開裂。表面青綠色，綠褐色，有兩條縱溝和凸起小斑點，內有縱隔。質堅硬。氣芳香，味苦。間有殘留果柄', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0097','龍眼肉','Dried Longan Pulp','補益心脾，養血安神。用於氣血不足、心悸怔忡、健忘失眠、血虛萎黃','甘，溫','以片大、肉厚、質細軟、棕黃色者為佳','為縱向破裂的不規則薄片，常數片粘結。長約1.5cm，寬2~4cm，厚約0.1cm。棕褐色，半透明，外表面皺縮不平，內面光亮而有細縱皺紋。質柔潤。氣微香，味甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0098','麥芽','Barley Sprout','行氣消食，健脾開胃，退乳消脹。用於食積不消，脘腹脹痛，脾虛食少，乳汗鬱積，乳房脹痛，婦女斷乳，生麥芽健脾和胃通乳。用於脾虛食少，乳汗鬱積','甘，平','以淡黃色、胚芽完整者為佳','本品呈梭形，長8~12mm，直徑3~4mm。表面淡黃色，背面為外稃包圍，具5脈，先端長芒已斷落；腹面為內稃包圍。除去內外稃後，腹面有1條縱溝；基部胚根處生出幼芽及鬚根，幼芽長披針狀條形，長約0.5cm。鬚根數條，纖細而彎曲。質硬，斷面白色，粉性。無臭，味微甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0099','蔓荊子','Sinplelaef Shrub Chastetree Fruit','疏散風熱，清利頭目。用於風熱感冒頭痛，齒齦腫痛，目赤多淚，目暗不明，頭暈目眩','辛、苦，微寒','以粒大飽滿、氣味濃者為佳','本品呈球形，直徑4~6mm。表面灰黑色或黑褐色，被灰白色粉霜狀茸毛，有縱向淺溝4條，頂端微凹，基部有灰白色宿萼及短果梗。萼長為果實的1/3~2/3，5齒裂，其中 2裂較深，密被茸毛。體輕，質堅韌，不易破碎。橫切面可見4室，每室有種子1枚。氣特異而芳香，味淡、微辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0100','木瓜','Common Floweringquine Fruit','平肝舒筋，和胃化濕。用於濕痹拘攣，腰膝關節酸重疼痛，吐瀉轉筋，腳氣水腫','酸，溫','以外皮皺縮、肉厚、堅實、內外紫紅色味酸者為佳','本品為為長圓形，多縱剖為兩半。外表面紫紅色或者紅褐色，有不規則的深皺紋。剖面邊緣向內捲曲，果肉紅棕色，中心部分向下凹陷，為棕黃色。種子為扁長的三角形。飲片為條狀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0101','青皮','Immature Tangerine Fruit','疏肝破氣、消積化滯。用於胸肋脘脹痛，乳癰、疝痛，食積氣滯','苦、辛，溫','個青皮以個勻、外皮黑綠色、質硬、體重、肉厚、瓤小、香氣濃者為佳','個青皮：呈類球形，直徑0.5~2cm。表面灰綠色或黑綠色，微粗糙，有細密凹下的油室，頂端有稍突起的柱基，基部有圓形果梗痕。質硬，斷面果皮黃白色或淡黃棕色，厚0.1~0.2cm，外緣有油室1~2列。瓤囊8~10 瓣，淡棕色。氣清香，味酸、苦、辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0102','肉豆蔻','Nutmeg','溫中澀腸；行氣消食。用於虛瀉；冷痢；脘腹脹痛；食少嘔吐；宿食不消','辛、苦，溫','以個大、表面具紫褐色光澤、仁飽滿、色白者為佳','該品呈卵圓形或橢圓形，長2~3cm，直徑1.5~2.5cm。表面灰棕色或灰黃色，有時外被白粉 (石灰粉末) 。全體有淺色縱行溝紋及不規則網狀溝紋。種臍位於寬端，呈淺色圓形突起，合點呈暗凹陷。種脊呈縱溝狀，連接兩端。質堅，斷面顯棕黃色相雜的大理石花紋，寬端可見乾燥皺縮的胚，富油性。氣香濃烈，味辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0103','山楂','Chinese Hawthorn Fruit','開胃消食、化滯消積、活血散瘀、化痰行氣。用於肉食滯積、症瘕積聚、腹脹痞滿、瘀阻腹痛、痰飲、泄瀉、腸風下血等','甘、酸，微溫','以果大、肉厚、核少、皮紅者為佳','果實較小，類球形，直徑0.8~1.4cm，有的壓成餅狀。表面棕色至棕紅色，並有細密皺紋，頂端凹陷，有花萼殘跡，基部有果梗或已脫落', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0104','絲瓜絡','Loofah, Towel Gourd Vegetable Sponge','通絡，活血，祛風。用於痹痛拘攣、胸脅脹痛、乳汁不通','甘，平','以個大長條、去除外皮、網狀維管束黃白色者為佳','藥材為絲狀維管束交織而成，多呈長棱形或長圓筒形，略彎曲，長30~70cm，直徑7~10cm。表面淡黃白色。體輕，質韌，有彈性，不能折斷。橫切面可見子房3室，呈空洞狀。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0105','桃仁','Peach Seed','活血祛瘀，潤腸通便，止咳平喘。用於經閉，痛經，癓瘕痞塊，跌撲損傷，腸燥便秘','苦、甘，平','以顆粒均勻、紅棕色、飽滿者為佳','種子扁卵形或橢圓形，一端尖，另端鈍圓而偏斜，邊緣較薄，長1.2~2cm，寬1~1.2cm，厚3~5mm。表面黃棕色或紅棕色，有縱脈紋及密佈細粒狀突起，近尖端側邊有長4~6mm的線形種臍。種皮薄，子葉兩片肥大，黃白色，富油質。味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0106','葶藶子','Pepperweed Seed','瀉肺降氣；祛痰平喘；利水消腫；泄逐邪。主治痰涎壅肺之喘咳痰多；肺癰；水腫；胸腹積水；小便不利；慢性肺源性心臟病；心力衰竭之喘腫；瘰鬁結核','辛、苦，大寒','以子粒充實、均勻、紅棕色者為佳','北葶藶子：種子扁卵形，長1~1.5-mm，寬0.5~1mm。表面黃棕色或紅棕色，微有光澤，具多數細微顆粒狀突起，並可見2條縱列的淺槽，其中一條較明顯，一端鈍圓，另端漸尖而微凹，種臍位於凹下處，但不明顯。無臭，味微苦辛，粘性較強', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0107','菟絲子','Chinese Dodder Seed','補腎益精、養肝明目、固胎止泄','甘，溫','以粒飽滿者為佳','菟絲子種子類圓形，腹棱線明顯，兩側常凹陷，長徑1.4~1.6mm，短徑0.9~1.1mm。表面灰棕色或黃棕色，因具有細密突起的小點兒微粗糙，種皮堅硬，不易破碎，除去種皮可中央為卷旋3周的胚，胚乳膜質套狀，位於胚周圍，氣微，味微苦、澀', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0108','五味子','Chinese Magnoliavine Fruit','收斂固澀，益氣生津，補腎寧心。用於久嗽虛喘，夢遺滑精，遺尿尿頻，久瀉不止，自汗，盜汗，津傷口渴，短氣脈虛，內熱消渴，心悸失眠','酸、甘，溫','以紫紅色、粒大、肉厚、有油性及光澤者為佳','乾燥果實略呈球形或扁球形，直徑5~8mm。外皮鮮紅色，紫紅色或暗紅色。顯油潤，有不整齊的皺縮。果肉柔軟，常數個粘連一起；內含種子1~2枚，腎形，棕黃色，有光澤，堅硬，種仁白色。果肉氣微弱而特殊，味酸。種子破碎後有香氣，味辛而苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0109','吳茱萸','Medicinal Evodia Immature Fruit','散寒止痛、降逆止嘔。用於治療肝胃虛寒、陰濁上逆所致的頭痛或胃脘疼痛等症','辛、苦，熱，有小毒','以綠色、粒小、飽滿堅實、香氣濃者為佳','果實呈五角狀扁球形，直徑2~5mm。表面暗黃綠色至褐色，粗糙，有點狀突起或凹下的油點。頂端有五角星狀的裂隙，基部殘留被有黃色茸毛的果梗。質硬而脆。氣芳香濃郁，味辛辣而苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0110','小茴香','Fennel Fruit','開胃進食，理氣散寒，有助陽道。主治：中焦有寒，食欲減退，噁心嘔吐，腹部冷痛；疝氣疼痛，睾丸腫痛；脾胃氣滯，脘腹脹滿作痛','辛，溫','以粒大飽滿、黃綠色、香氣濃者為佳','果實為雙懸果，呈圓柱形，有的稍彎曲，兩端略尖，長4~8mm，直徑1.5~2.5mm。表面黃綠或淡黃色，頂端殘留有黃棕色突起的柱基，基部有時有細小的果梗。分果呈長橢圓形，背面有縱棱5條，接合面平坦而較寬。橫切面略呈5邊形，背面的4邊約等長。有特異茴香氣，味微甜、辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0111','罌粟殼','Opium Poppy Peel','斂肺、澀腸、止痛。用於久咳、久瀉，脫肛，脘腹疼痛','酸、澀，平，有毒','以完整、豐滿者為佳','呈橢圓形或瓶狀卵形，多已破碎成片狀，直徑1.5~5cm，長3~7cm外表面黃白色、淺棕色至淡紫色，平滑，略有光澤，有縱向或橫向的割痕。頂端有 6~14條放射狀排列呈圓盤狀的殘留柱頭；基部有短柄。體輕，質脆。內表面淡黃色，微有光澤。有縱向排列的假隔膜，棕黃色，上面密佈略突起的棕褐色小點。氣微清香，味微苦', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0112','薏苡仁','Ma - yuen Jobstears Seed','健脾滲濕，除痹止瀉。薏米可用於治療水腫、腳氣、小便不利、濕痹拘攣、脾虛泄瀉','甘、淡，微寒','以粒大充實、色白、無皮碎者為佳','種仁寬卵形或長橢圓形，長4~8mm，寬3~6mm。表面乳白色，光滑，偶有殘存的黃褐色種皮。一端鈍圓，另端較寬而微凹，有1淡棕色點狀種臍。背面圓凸，腹面有1條羅寬而深的縱溝。質堅實，斷面白色粉性。氣微，味微甜。以粒大充實、色白、無皮碎者為佳', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0113','枳殼','Submature Bitter Orange','理氣寬中，行滯消脹','辛、苦、酸，溫','以外果皮色綠褐、果肉厚、質堅硬、香氣濃者為佳','果實呈半球形，直徑3~5.5cm。外皮綠褐色或棕褐色，略粗糙，散有眾多小油點，中央有明顯的花柱基痕或圓形果柄痕。切面中果皮厚0.6~1.2cm，黃白色較光滑，略向外翻，有維管束散佈，邊緣有棕黃色油點l~2列。質堅硬，不易折斷，瓤囊7~12瓣，少數至15瓣，囊內汁胞幹縮，棕黃色或暗棕色，質軟，內藏種子。中軸堅實，寬5~9mm，黃白色，有一圈斷續環列的維管束點。氣香，味苦、微酸', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0114','枳實','Immature Bitter Orange','破氣消積，化痰散痞。用於積滯內停；痞滿脹痛；大便秘結；瀉痢後重；結胸；胃下垂；子宮脫垂；脫肛','苦、辛、酸，溫','以皮青黑、果肉厚色白、囊小、堅實者為佳','該品呈半球形，少數為球形，直徑0.5~2.5cm。外果皮黑綠色或暗棕綠色，具顆粒狀突起和皺紋，有明顯的花柱殘跡或果梗痕。切面中果皮略隆起，黃白色或黃褐色，厚0.3~1.2cm，邊緣有1~2列油室，瓤囊棕褐色。質堅硬。氣清香，味苦、微酸', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0115','梔子','Common Gardenia Fruit','瀉火除煩；清熱利濕；涼血解毒主治熱病心煩；肝火目赤；頭痛；濕熱黃疸；淋證；血痢尿血；口舌生瘡；瘡瘍腫毒；扭傷腫痛','苦，寒','以皮薄、飽滿、色紅黃者為佳','果實倒卵形、橢圓形或長橢圓形，長1.4~3.5cm，直徑0.8~1.8cm。表面紅棕色或紅黃色，微有光澤，有翅狀縱棱6~8條，每二翅棱間有縱脈1條，先端有暗黃綠色殘存宿萼，先端有6~8條長形裂片，裂片長1~2.5cm，寬2~3mm，多碎斷，果實基部收縮成果柄狀，末端有圓形果柄痕。果皮薄而脆，內表面鮮黃色或紅黃色。有光澤，具隆起的假隔膜2~3條。折斷面鮮黃色，種子多數，扁橢圓形或扁矩圓形，聚成球狀團塊，棕紅色，表面有細而密的凹入小點；胚乳角質；胚長形，具心形子葉2片。氣微，味微酸苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0116','紫蘇子','Cultivated Puple Perilla Fruit','降氣消痰，平喘，潤腸。用於痰壅氣逆，咳嗽氣喘，腸燥便秘。解表散寒，行氣和胃。用於風寒感冒，咳嗽氣喘，妊娠嘔吐，胎動不安。又可解魚蟹中毒','辛，溫','以均勻飽滿、色灰褐、油性足者為佳','該品呈卵圓形或類球形，直徑約1.5mm。表面灰棕色或灰褐色，有微隆起的暗紫色網紋，基部稍尖，有灰白色點狀果梗痕。果皮薄而脆，易壓碎。種子黃白色，種皮膜質，子葉2，類白色，有油性。壓碎有香氣，味微辛', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0117','枸杞子','Babury Wolfberry Fruit','滋補肝腎，益精明目','甘，平','以粒大，色澤鮮亮者為佳','呈類紡錘形或橢圓形，表面紅色或暗紅色，項端有小突起狀的花柱痕，基部有白色的果梗痕。果皮柔韌，皺縮；果肉肉質，柔潤。種子20~50粒，類腎形。扁而翹，表面淺黃色或棕黃色。氣微，味甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0118','芡實','Gordon Euryale Seed','益腎固精，補脾止渭，除濕止帶。用於遺精滑精，遺尿尿頻，脾虛久瀉，自濁，帶下','甘、澀。平','以顆粒飽滿均勻、粉性足、無碎末及皮殼者為佳','類球形，多為破粒。表面有棕紅色內種皮，一端黃自色，約占全體1/3、有凹點狀的種臍痕，除去內種皮顯白色。質較硬，斷面白色，粉性。氣微，味淡', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0119','山茱萸','Common Macrocarpium Fruit','補益肝腎，澀精固脫。用於眩暈耳鳴，腰膝酸痛，陽痿遺精，遺尿尿頻，崩漏帶下，大汗虛脫，內熱消渴','酸、澀，微溫','以皮肉厚，色鮮豔，味酸濃者佳','本品呈不規則的片狀或囊狀。表面紫紅色至紫黑色，皺縮，有光澤。頂端有的有圓形宿萼痕，基部有果梗痕。質柔軟。氣微，味酸、澀、微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0120','酸棗仁','Spine Date Seed','養心補肝，寧心安神，斂汗，生津。用於慮煩不眠，驚悸多夢，體虛多汗，津傷口渴','甘，酸，平','以粒大飽滿、外皮紫紅色、無核殼者為佳','乾燥成熟的種子呈扁圓形或橢圓形，表面紫紅色或紫褐色，平滑有光澤，有的有裂紋。有的兩面均承圓隆狀突起，有的一面較平州。中間或有1條隆起的縱線紋；另一面稍突起。一端凹陷，可見線形種臍，另端有細小突起的合點。種皮較脆，乳白色。子葉2，淺黃色，富油性。 氣微弱，味淡', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0121','烏梅','Smoked Plum','斂肺，澀腸，生津，安蛔。用於肺虛久咳，久痢滑腸，虛熱消渴，蛔厥嘔吐腹痛，膽道蛔蟲症','酸、澀，平','以個大、肉厚、柔潤、味極酸者為佳','本品呈類環形或扁球形，直徑1.5~3cm。表面烏黑色或棕黑色，皺縮不平，基部有圓形果梗痕。果核堅硬，橢圓形，棕黃色，表面有凹點；種子扁卵形，淡黃色。氣微，味極酸', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0122','川楝子','Szechwan Chinaberry Fruit','舒肝行氣止痛，驅蟲。用於胸脅、脘腹脹痛，疝痛，蟲積腹痛','苦，寒，有小毒','以個大、飽滿、外皮金黃色、果肉黃白色者為佳','果實類球形，直徑2~3cm。表面金黃色至棕黃色，微有光澤，具深棕色小點。頂端有花柱殘基，基部凹陷有果梗痕。外果皮革質，與果肉間常成空隙，果肉鬆軟，淡黃色，遇水潤濕顯粘性。果核球形或卵圓形，質堅硬，兩端平截，有6~8條縱棱，內分6~8室，每室含黑棕色長圓形的種子1粒。氣特異，味酸、苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0123','牛蒡子','Great Burdock Fruit','疏散風熱，宣肺透疹，解毒利咽。用於風熱感冒，咳嗽痰多，麻疹，風疹，咽喉腫痛，痄腮丹毒，癰腫瘡毒','辛、苦，寒','以粒大、飽滿、色灰褐者為佳','本品呈長倒卵形，略扁，微彎曲，長5~7mm，寬2~3mm。表面灰褐色，帶紫黑色斑點，有數條縱棱，通常中間1~2條較明顯。頂端鈍圓，稍寬，頂面有圓環，中間具點狀花柱殘跡；基部略窄，著生面色較淡。果皮較硬，子葉2，淡黃白色，富油性。無臭，味苦後微辛而稍麻舌', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0124','砂仁','Villous Amomum Fruit','化濕開胃，溫脾止瀉，理氣安胎。用於濕濁中阻，脘痞不饑，脾胃虛寒，嘔吐泄瀉，妊娠惡阻，胎動不安','辛，溫','以個大、堅實、仁飽滿、氣香濃者為佳','海南砂：呈長橢圓形或卵圓形，有明顯的三棱，長1.5~2cm，直徑0.8~1.2cm。表面被片狀、分枝的軟刺，基部具果梗痕。果皮厚而硬。種子團較小，每瓣有種子3~24粒；種子直徑1.5~2mm。氣味稍淡', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0125','薄荷','Wild Mint Herb','疏散風熱，清利頭目，透疹。具有疏散風熱、清利頭目、利咽、透疹、疏肝解鬱之功效。現代醫學常將其用於治療風熱感冒、頭痛、咽喉痛、口舌生瘡、風疹、麻疹、胸腹脹悶和抗早孕等。另外，薄荷還具有消炎止痛作用','辛，涼','以色深綠、葉多、氣濃者為佳','本品莖呈方柱形，有對生分枝，長15~40cm，直徑0.2~0.4cm；表面紫棕色或淡綠色，棱角處具茸毛，節間長2~5cm；質脆，斷面白色，髓部中空。葉對生，有短柄；葉片皺縮捲曲，完整者展平後呈寬披針形、長橢圓形或卵形，長2~7cm，寬1~3cm；上表面深綠色，下表面灰綠色，稀被茸毛，有凹點狀腺鱗。輪傘花序腋生，花萼鐘狀，先端5齒裂，花冠淡紫色。揉搓後有特殊清涼香氣，味辛涼', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0126','大薊','Japanese Thistle','止血涼血、祛瘀消腫。主治吐血，衄血，尿血，血淋，血崩，帶下，腸風，腸癰，癰瘍腫毒，疔瘡','甘、苦，涼','根以條粗、乾燥者為佳','大薊根：呈長紡錘形，常簇生而扭曲，長5~15cm，直徑0.2~0.6cm。表面暗褐色，有不規則的縱皺紋。質硬而脆，易折斷，斷面粗糙，灰白色。氣微，味甘、微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0127','小薊','Field Thistle','涼血止血，祛瘀消腫。用於衄血，吐血，尿血，便血，崩漏下血，外傷出血，癰腫瘡毒','甘、苦，涼','以灰綠色、葉多者為佳','本品莖呈圓柱形，有的上部分枝，長5~30cm，直徑0.2~0.5cm；表面灰綠色或帶紫色，具縱棱及白色柔毛；質脆，易折斷，斷面中空。葉互生，無柄或有短柄；葉片皺縮或破碎，完整者展平後呈長橢圓形或長圓狀披針形，長3~12cm，寬0.5~3cm；全緣或微齒裂至羽狀深裂，齒尖具針刺；上表面綠褐色，下表面灰綠色，兩面均具白色柔毛。頭狀花序單個或數個頂生；總苞鐘狀，苞片5~8層，黃綠色；花紫紅色。氣微，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0128','荊芥','Fineleaf Schizonepeta Herb','解表散風，透疹，消瘡，止血。用於感冒，麻疹透發不暢，便血、崩漏、鼻衄','辛，微溫','以色淡黃綠、香氣濃、穗長而密者為佳','本品莖呈方柱形，上部有分枝，長50~80cm，直徑0.2~0.4cm；表面淡黃綠色或淡紫紅色，被短柔毛；體輕，質脆，斷面類白色。葉對生，多已脫落，葉片3~5羽狀分裂，裂片細長。穗狀輪傘花序頂生，長2~9cm，直徑約7mm。花冠多脫落，宿萼鐘狀，先端5齒裂，淡棕色或黃綠色，被短柔毛；小堅果棕黑色。氣芳香，味微澀而辛涼', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0129','麻黃','Chinese Ephedrs Herb','發汗散寒，宣肺平喘，利水消腫','辛、微苦，溫','均以淡綠色或黃綠色，內心紅棕色、味苦澀、手拉不脫節者為佳','中麻黃：多分枝，直徑1.5~3cm，有粗糙感。節間長2~6cm，膜質鱗葉長2~3mm，裂片3 (稀2)，先端銳尖。斷面髓部呈三角狀圓形', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0130','青蒿','Sweet Wormwood Herb','清透虛熱，涼血除蒸，除蒸，截瘧。用於暑邪發熱，陰虛發熱，夜熱早涼，骨蒸勞熱，瘧疾寒熱，濕熱黃疸','苦、辛，寒','以色綠、葉多、香氣濃者為佳','莖圓柱形，上部多分枝，長30~80cm，直徑0.2~0.6cm，表面黃綠色或棕黃色，具縱棱線；質略硬，易折斷，斷面中部有髓。葉互生，暗綠色或棕綠色，捲縮，碎，完整者展平後為三回羽狀深裂，裂片及小裂片矩圓形或長橢圓形，兩面被短毛。氣香特異，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0131','瞿麥','Fringed Pink Herb','利尿通淋，破血通經。用於熱淋、血淋、石淋、小便不通、淋瀝澀痛','苦，寒','以色青綠，花未開放者為佳','瞿麥：莖圓柱形，長30~60cm，節部膨大；表面淡綠色或黃綠色，略有光澤，無毛。葉多皺縮，對生，黃綠色，展平後葉片長條披針形，長2~7cm，寬1~4mm；葉尖稍反卷，基部短鞘狀抱莖。花棕紫色或棕黃色，長3~4cm，單生或數朵簇生；具宿萼，萼筒長2.5~3.5cm，約為全花的3/4；萼下有小苞片，長約為萼筒的1/4，先端急尖或漸尖，外表有規則的縱紋；花瓣先端深裂呈流蘇狀。莖質硬脆，折斷面中空。氣無，味甘', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0132','肉蓯蓉','Desertliving Cistanche Herb','具有補腎陽，益精血，潤腸通便的功效。主治腎陽虛衰，精血虧損，陽痿，遺精，腰膝冷痛，耳鳴目花，帶濁，尿頻，月經愆期，崩漏，不孕不育，腸燥便秘','甘、咸，溫','以條粗壯、密生鱗葉、質柔潤者為佳','管花肉蓯蓉：呈扁圓柱形、扁紡錘形、扁卵圓形、扁圓形等不規則形，長6~8cm，直徑4~6.5cm，表面紅棕色、灰黃棕色或棕褐色，多扭曲。密被略呈覆瓦狀排列的肉質鱗片，上部密下部疏、鱗片先端多已斷落，殘基部寬多在l釐米以上，整個鱗片略呈長三角形，高約1cm。體重、質堅硬，無韌性，難折斷，斷面顆粒性，多呈灰棕色，有的外圈呈黑色硬膠質樣。黑褐色點狀維管束眾多，不規則散在，有的有小裂隙。氣微，味甜、微苦', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0133','石斛','Noble Dendrobium Stem Herb','養陰清熱，益胃生津。用於熱傷津液，低熱煩渴，舌紅少苔；胃陰不足，口渴咽乾，嘔逆少食，胃脘隱痛，舌光少苔；腎陰不足，視物昏花','甘，微寒','以金黃色、有光澤、質柔韌者為佳','馬鞭石斛：莖細長圓錐形，上部有少數分枝，長30~150cm，直徑2~8mm，節間長2~4.5cm。表面棕黃色，有8~9條縱溝。質疏鬆，斷面纖維性。氣微，味微苦。商品常切成1.5~3cm長段，切面灰白色', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0134','香薷','Chinese Mosla Herb','發汗解暑，行水散濕，溫胃調中。主治：夏月感寒飲冷，頭痛發熱，惡寒無汗，胸痞腹痛，嘔吐腹瀉，水腫，腳氣','辛、甘，溫','以枝嫩、穗多、香氣濃者為佳','全體長14~30cm，被白以短茸毛。莖多分枝，四方柱形，近基部圓形，直徑0.5~5mm；表面黃棕以，近基部常呈棕紅色，節明顯，節間長2~5cm；質脆，易折斷，斷面淡黃色，葉對生，多脫落，皺縮或破碎，完整者展平後呈狹長披針形，長0.7~2.5cm，寬約4mm，邊緣有疏鋸齒，黃綠色或暗綠以；質脆，易碎。花輪密集成頭狀；苞片被白色柔毛；花萼鐘狀，先端5裂；花冠皺縮或脫落。小是對果4，包於宿萼內，香氣濃，味辛涼。栽培品全體長35~60cm，疏被較長的茸毛；莖較粗，節間長4~7cm', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0135','益母草','Common Motherwort Herb','活血、祛淤、調經、消水。治療婦女月經不調，胎漏難產，胞衣不下，產後血暈，瘀血腹痛，崩中漏下，尿血、瀉血，癰腫瘡瘍','辛、苦，涼','以枝嫩、黃綠色、帶葉花者為佳','乾益母草：莖表面灰綠色或黃綠色；體輕，質韌，斷面中部有髓。葉片灰綠色，多皺縮、破碎，易脫落。輪傘花序腋生，小花淡紫色，花萼筒狀，花冠二唇形。切段者長約2cm', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0136','茵陳','Capillary Wormwood Herb','清熱利濕；退黃。主治：黃疸、小便不利、濕瘡瘙癢、傳染性黃疸型肝炎','苦、辛，微寒','以質嫩、綿軟、色灰白、香氣濃者為佳','茵陳蒿：莖呈圓柱形，多分枝，長30~100cm，直徑2~8mm；表面淡紫色或紫色，有縱條紋，被短柔毛；體輕，質脆，斷面類白色。葉密集，或多脫落；下部葉二至三回羽狀深裂，裂片條形或細條形，兩面密被白色柔毛；莖生葉一至二回羽狀全裂，基部抱莖，裂片細絲狀；頭狀花序卵形，多數集成圓錐狀，長1.2~1.5mm，直徑1~1.2mm，有短梗；總苞片3~4層，卵形，苞片3裂；外層雌花6~10個，可多達15個，內層兩性花2~10個。瘦果長圓形，黃棕色。氣芳香，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0137','丁香','Clove','暖胃，溫腎。治胃寒痛脹、呃逆、吐瀉、痹痛、疝痛、口臭、牙痛','甘，溫','以個大、粗壯、鮮紫棕色、香氣強烈、油多者為佳','乾燥的花蕾略呈短棒狀，長1.5~2cm，紅棕色至暗棕色；下部為圓柱狀略扁的萼管，長1~1.3cm，寬約5mm，厚約3mm，基部漸狹小，表面粗糙，刻之有油滲出，萼管上端有4片三角形肥厚的萼；上部近圓球形，徑約6mm，具花瓣4片，互相抱合。將花蕾剖開，可見多數雄蕊，花絲向中心彎曲，中央有一粗壯直立的花柱，質堅實而重，入水即沉；斷面有油性，用指甲劃之可見油質滲出；氣強烈芳香，味辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0138','槐花','Black Locust Flower','涼血止血，清肝瀉火。主治腸風便血，痔血，血痢，尿血，血淋，崩漏，吐血，衄血，肝火頭痛，目赤腫痛，喉痹，失音，癰疽瘡瘍','苦，微寒','以黃綠色、粒大、緊實者為佳','皺縮而捲曲，花瓣多散落，完整者花萼鐘狀，黃綠色，花瓣黃色或黃白色。體輕。味微苦。花蕾 (槐米) 卵形或橢圓形。花萼黃綠色，上方為未開放的黃白色花瓣，內呈黃褐色。質輕。味微苦澀', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0139','金銀花','Japanese Honysuckle Flower Bud','宣散風熱，清熱解毒。用於各種熱性病，如身熱、發疹、發斑、熱毒瘡癰、咽喉腫痛等證','甘，寒','以花蕾多、色淡、柔軟氣清香者為佳','本品呈棒狀，上粗下細，略彎曲，長2~3cm，上部直徑3mm，下部直徑1.5mm，表面黃白色或綠白色，密被短柔毛。偶見葉狀苞片，花萼綠色、先端5裂，裂片有毛，長約2mm，開放者花冠筒狀，先端二唇形，雄蕊5附於筒壁，黃色；雌蕊1個，子房無毛，氣清香，味淡微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0140','菊花','Florists Dendranthema','清熱解毒，平肝明目；疏風散熱','苦，微寒','以花朵完整、顏色鮮豔、清香者為佳','滁菊：呈不規則球形或扁球形，直徑1.5~2.5cm，舌狀花類白色，不規則扭曲，內卷，邊緣皺縮，有時可見淡褐色的腺點，管狀花大多隱藏。是菊花中花瓣最為緊密的一種', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0141','款冬花','Common Coltsfoot Flower','化痰止咳，鎮咳下氣，潤肺祛痰，降逆止嘔。主治咳嗽，氣喘，肺痿，咳吐痰血等症','辛、微苦，溫','以2~3朵並連、蕾大、身乾、色紫紅、梗極短、無開放花朵者為佳','款冬花花蕾呈捧狀或長橢圓形，單一或2~3並生，有時可達5朵，俗稱“連三朵”。一般長約1~3cm，直徑約0.5~0.8cm。花蕾及花柄上包有粉紫 色或淡棕褐色鱗狀苞片數層。鱗狀苞片包裹著黃棕色未成形的細小舌狀及管狀花如蜘蛛絲樣的紫狀物。氣清香，味微苦辛，嚼之如絮', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0142','蒲黃','Cattail Pollen','止血，化瘀，通淋。用於吐血、衄血、咯血、崩漏、外傷出血、經閉、痛經、脘腹刺痛、跌打腫痛、血淋濕痛','甘、平','以粉細、純淨、體輕、色鮮黃、滑膩感強者為佳','花粉為黃色粉末。體輕，放水中則飄浮水面。手撚有骨膩感，易附著手指上，氣微，味淡。花粉粒類圓形或橢圓形，直徑17~29μm，表面有網狀雕紋，周邊輪廓線光滑，呈凸波狀或齒輪狀，具單孔，不甚明顯', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0143','芫花','Lilac Daphe Flower Bud','瀉水逐飲，解毒殺蟲。用於水腫脹滿，胸腹積水，痰飲積聚，氣逆喘咳，二便不利；外治疥癬禿瘡，凍瘡。根皮：消腫解毒，活血止痛。用於急性乳腺炎，癰癤腫毒，淋巴結結核，腹水，風濕痛，牙痛，跌打損傷','甘、苦，溫，有毒','以花蕾多而整齊、淡紫色、無破碎者為佳','該品常3~7朵簇生於短花軸上，基部有苞片1~2片，多脫落為單朵。單朵呈棒槌狀，多彎曲，長1~1.7cm，直徑約1.5mm；花被筒表面淡紫色或灰綠色，密被短柔毛，先端4裂，裂片淡紫色或黃棕色。質軟', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0144','紅花','Safflower','活血通經，散瘀止痛，用於閉經，痛經，惡露不行，症瘕痞塊，胸痹心痛，癡滯腹痛，胸脅刺痛，跌撲損傷，瘡瘍腫痛','辛，溫','以花色紅黃、鮮豔、乾燥、質柔軟者為佳','本品為不帶子房的管狀花，表面紅黃色或紅色，花冠筒細長，先端5裂，裂片呈狹條形，雄蕊5，花藥聚合成筒狀，黃白色；柱頭長圓柱形，頂端微分叉。質柔軟。氣微香，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0145','旋覆花','Japanese Inula Flower','降氣，消痰，行水，止嘔。用於風寒咳嗽，痰飲蓄結，胸膈痞滿，喘咳痰多，嘔吐噫氣，心下痞硬','苦，辛、咸，微溫','以朵大、金黃色、有白絨毛、無枝梗者為佳','本品呈扁球形或類球形，直徑1~2cm。總苞由多數苞片組成，呈覆瓦狀排列，苞片披針形或條形，灰黃色，長4~11mm；總苞基部有時殘留花梗，苞片及花梗表面被白色茸毛，舌狀花1列，黃色，長約1cm，多捲曲，常脫落，先端3齒裂；管狀花多數，棕黃色，長約5mm，先端5齒裂；子房頂端有多數白色冠毛，長5~6mm。有的可見橢圓形小瘦果。體輕，易散碎。氣微，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0146','側柏葉','Chinese Arborviae Twig and Leaf','涼血，止血，祛風濕，散腫毒。治吐血、衄血、尿血、血痢、腸風、崩漏，風濕痹痛，細菌性痢疾，高血壓，咳嗽，丹毒，痄腮，燙傷','苦、澀，寒','以葉嫩、青綠色，無碎末者為佳','多有分支，小且長短不一，為鱗片狀。顏色為紅褐色。表面可見葉相互對生，斷面黃白色。質地鬆脆、易被折斷。莖枝類圓柱形，紅棕色；小枝扁平，直徑1~2mm。葉細小鱗片狀，交互對生，貼伏於枝上，深綠色或黃綠色。質脆。氣清香，味苦澀、微辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0147','荷葉','Hindu Lotus Leaf','清熱解暑，升發清陽，涼血止血。用於暑熱煩渴，暑濕泄瀉，脾虛泄瀉，血熱吐衄，便血崩漏','苦，平','以葉大、整潔、色綠者為佳','荷葉葉多折成半圓形或扇形，展開後呈類圓形，直徑20~50cm，全緣或稍波狀。上表面深綠色或黃綠較粗糙；下表面淡灰棕色，較光滑，有粗脈21~22條，處中心向四周射出，中心有突起的葉西峽錢基。質脆，易破碎。微有清香氣，味微苦', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0148','枇杷葉','Loquat Leaf','清肺止咳，降逆止嘔。　肺熱咳嗽，氣逆喘急，胃熱嘔吐，噦逆','苦，微寒','以完整、葉厚、色綠者佳','葉片長橢圓形，長12~30cm，寬4~9cm。上表面淡棕綠色、黃綠色或紅棕色，有光澤。下表面灰綠色或棕黃色，密佈灰棕色絨毛。葉脈呈羽毛狀兩側斜生，中間主脈呈棕黃或棕紅色，顯著突起。葉先端漸尖，周邊有疏鋸齒。葉柄極短，被黃棕色或棕黑色絨毛。葉厚革質，質脆易碎。微有清香氣，味微苦', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0149','桑葉','Mulberry Leaf','疏散風熱，清肺潤燥，平抑肝陽，清肝明目，涼血止血','甘、苦，寒','以色黃綠且葉大者為佳','多皺縮，破碎。完整者有柄，葉片上面黃綠色或淺黃棕色，有的有小疣狀突起；下表面色較淺，葉脈突起，小脈網狀，脈上被疏毛，脈基具簇毛。質脆。氣微，味淡、微苦、澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0150','石韋','Japanese Felt Fern','利尿通淋，清熱止血。用於熱淋，血淋，石淋，小便不通，淋瀝澀痛，吐血，衄血，尿血，崩漏，肺熱喘咳','甘、苦，微寒','以葉片完整、葉厚而大、背面色發紅且有小點者為佳','有柄石韋：葉片多捲曲呈筒狀，展平後呈長圓形或卵狀長圓形，長3~8cm，寬1~2.5cm。基部楔形，對稱。下表面側脈不明顯，佈滿孢子囊群。葉柄長3~12cm，直徑約1mm', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0151','紫蘇葉','Cultibated Purple Perilla Leaf','發表，散寒，理氣，和營。治感冒風寒，惡寒發熱，咳嗽，頭痛無汗，氣喘，胸腹脹滿，嘔惡腹瀉，咽中梗阻，妊娠惡阻，胎動不安。並能解魚蟹毒','辛，微溫','以葉大、色紫、不碎、香氣濃、無枝梗者為佳','乾燥完整的葉呈卵形或圓卵形，多數皺縮捲曲，或已破碎，兩面均棕紫色，或上面灰綠色，下面棕紫色，兩面均有稀毛；先端尖，邊緣有鋸齒，基部近圓形，有柄，質薄而脆。切碎品多混有細小莖枝。莖四方形，有槽，外皮黃紫色，有時剝落，木質部黃白色，中央有白色疏鬆的髓。氣芳香，味微辛', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0152','百合','Liy Bulb','養陰潤肺，清心安神。用於陰虛久咳，痰中帶血，虛煩驚悸，失眠多夢，精神恍惚','甘，寒','以瓣勻肉厚、色黃白、質堅、筋少者為佳','細葉百合：鱗葉長約5.5cm，寬約2.5cm，厚至3.5mm，色較暗，脈紋不太明顯', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0153','地骨皮','Chinese Wolfberry Root - bark','涼血除蒸，清肺降火。用於陰虛潮熱、骨蒸盜汗、肺熱咳嗽、咯血、衄血','甘，寒','以塊大、肉厚、無木心與雜質者為佳','乾燥根皮為短小的筒狀或槽狀卷片，大小不一，一般長3~10cm，寬0.6~1.5cm，厚約3mm。外表面灰黃色或棕黃色，粗糙，有錯雜的縱裂紋，易剝落。內表面黃白色，較平坦，有細縱紋。質輕脆，易折斷，斷面不平坦，外層棕黃色，內層灰白色。臭微。味微甘', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0154','杜仲','Eucommia Bark','補肝腎，強筋骨，安胎。治腰脊酸疼，足膝痿弱，小便余瀝，陰下濕癢，胎漏欲墮，胎動不安，高血壓','甘，溫','以皮厚而大，糙皮刮淨，外面黃棕色，內面黑褐色而光，折斷時白絲多者為佳','乾燥樹皮，為平坦的板片狀或卷片狀，大小厚薄不一，一般厚約3~10mm，長約40~100cm。外表面灰棕色，粗糙，有不規則縱裂槽紋及斜方形橫裂皮孔，有時可見淡灰色地衣斑。但商品多已削去部分糙皮，故外表面淡棕色，較平滑。內表面光滑，暗紫色。質脆易折斷，斷面有銀白色絲狀物相連，細密，略有伸縮性。氣微，味稍苦，嚼之有膠狀殘餘物', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0155','黃柏','Amur Corktree Bark','清熱燥濕，瀉火除蒸，解毒療瘡。用於濕熱瀉痢，黃疸，帶下，熱淋，腳氣，骨蒸勞熱，盜汗，遺精，瘡瘍腫毒，濕疹瘙癢','苦，寒','以皮厚斷面黃色者為佳','呈板片狀或淺槽狀，長寬不一，厚3~6mm。外表面黃褐色或黃棕色，平坦或具縱溝紋，有的可見皮孔痕及殘存的灰褐色粗皮。內表面暗黃色或淡棕色，具細密的縱棱紋。體輕，質硬，斷面纖維性，呈裂片狀分層，深黃色。氣微，味甚苦，嚼之有粘性', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0156','厚樸','Officinal Magnolia Bark','行氣消積；燥濕除滿；降逆平喘。主治食積氣滯；腹脹便秘；濕阻中焦，脘痞吐瀉；痰壅氣逆；胸滿喘咳','苦、辛，溫','均以皮厚、肉細、油性大，斷面紫棕色、有小亮星、氣味濃厚者為佳','枝皮 (枝樸) ：呈單筒狀，長10~20cm，厚1~2mm。外表面灰褐色，內表面黃棕色。質脆，易折斷，斷面纖維性', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0157','牡丹皮','Tree Peony Root - bark','清熱涼血；活血散瘀。溫熱病熱入血分；發斑；吐衄；熱病後期熱伏陰分發熱；陰虛骨蒸潮熱；血滯經閉；痛經；癰腫瘡毒；跌撲傷痛；風濕熱痹','苦、辛，微寒','以條粗長、皮厚、無木心、斷面粉白色、具粉性、“亮銀星”多、香氣濃者為佳','呈筒狀或半筒狀，有縱剖開的縫，略向內捲曲或張開，長5~20cm，直徑0.5~1.2cm，厚0.1~0.4cm。原丹皮外表面灰褐色或黃褐色，有多數橫長皮孔及細根痕，栓皮脫落處粉紅色；刮丹皮粉紅色或淡紅色。內表面淡灰黃色或淺棕色，有明顯的細縱紋，常見發亮的結晶 (系針、柱狀牡丹酚結晶) 。質硬而脆，易折斷。斷面較平坦，淡粉紅色，粉性，紋理不明顯。氣芳香，味微苦而澀，有麻舌感 ', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0158','秦皮','Ash Bark','清熱燥濕，清肝明目，收澀止痢，止帶。用於熱毒瀉痢，帶下陰癢，肝熱目赤腫痛，目生翳障','苦，寒','以條長、外皮薄而光滑者為佳','幹皮：為長條狀塊片，厚3~6mm。外表面灰棕色，有紅棕色圓形或橫長的皮孔及龜裂狀溝紋。質堅硬，斷面纖維性較強', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0159','肉桂','Cassia Bark','補火助陽，引火歸源，散寒止痛，活血通經。暖脾胃，除積冷，通血脈。治命門火衰，肢冷脈微，亡陽虛脫，腹痛泄瀉，寒疝奔豚，腰膝冷痛，經閉症瘕，陰疽，流注，及虛陽浮越，上熱下寒','辛、甘，大熱','以完整不碎、皮厚體重、外表面具細皺紋，油性大、香氣濃者為佳','桂碎：大小不規則片塊狀或短捲筒狀，外皮灰棕色，斷面和內皮呈棕色或棕褐色，氣香，味甜辣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0160','桑白皮','White Mulberry Root - bark','瀉肺平喘，利水消腫。用於肺熱咳喘，面目浮腫，小便不利等症','甘，寒','以色白、皮厚、粉性足者為佳','長片狀槽狀形，左右兩邊向內捲曲，卷邊呈半筒形，槽的中呈長而扭曲的板片狀，筒狀或兩邊向內卷成槽狀，長短寬窄不一，厚0.1~0.5cm。外表面淡黃白色，有少數棕黃色或紅棕色斑點 (殘留栓皮)，內表面黃白色或灰黃色，平滑，有細縱紋，有的縱向裂開，露出纖維。體輕質韌，難折斷，易縱向撕裂，撕裂時有白色粉塵飛出，氣微，味微甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0161','茯苓','Tuckahoe','滲濕利水，健脾和胃，寧心安神。小便不利；水腫脹滿；痰飲咳逆；嘔吐；脾虛食少；泄瀉；心悸不安；失眠健忘；遺精白濁','甘、淡，平','以體重堅實、外皮棕褐色、皮紋細、無裂隙、斷面白色細膩、粘牙力強者為佳','常見者為其菌核體。多為不規則的塊狀，球形、扁形、長圓形或長橢圓形等，大小不一，小者如拳，大者直徑達20~30cm，或更大。表皮淡灰棕色或黑褐色，呈瘤狀皺縮，內部白色稍帶粉紅，由無數菌絲組成。子實體傘形，直徑0.5~2mm，口緣稍有齒；有性世代不易見到，蜂窩狀，通常附菌核的外皮而生，初白色，後逐漸轉變為淡棕色，孔作多角形，擔子棒狀，擔孢子橢圓形至圓柱形，稍屈曲，一端尖，平滑，無色。有特殊臭氣', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0162','豬苓','Agaric','利水滲濕。用於小便不利，水腫，泄瀉，淋濁，帶下','甘、淡，平','以個大、體結、質重、皮黑光亮、肉白、粉性足者為佳','豬苓呈條形、類圓形或扁塊狀，有的有分枝，長5~25cm，直徑2~6cm。體輕，質硬，略呈顆粒狀。表面黑色、灰黑色或棕黑色，皺縮或有瘤狀突起，斷面類白色或黃白色。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0163','沒藥','Myrrh','散血去瘀，消腫定痛','辛、苦，平','以塊大、色紅棕、半透明、香氣濃而持久、雜質少者為佳','膠質沒藥：成不規則塊狀，多黏結成大小不等的團塊。表面深棕色或黃棕色，不透明；質堅實或疏鬆。味苦而有黏性', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0164','乳香','Frankincense','調氣活血，定痛，追毒。治氣血凝滯、心腹疼痛，癰瘡腫毒，跌打損傷，痛經，產後瘀血刺痛','辛、苦，溫','以淡黃色、顆粒狀、半透明、無砂石樹皮雜質、粉末粘手、氣芳香者為佳','多呈小形乳頭狀、淚滴狀顆粒或不規則的小塊，長0.5~3cm，有時粘連成團塊。淡黃色，常帶輕微的綠色、藍色或棕紅色。半透明。表面有一層類白色粉塵，除去粉塵後，表面仍無光澤。質堅脆，斷面蠟樣，無光澤，亦有少數呈玻璃樣光澤。氣微芳香，味微苦。嚼之，初破碎成小塊，迅即軟化成膠塊，粘附牙齒，唾液成為乳狀，並微有香辣感。遇熱則變軟，燒之微有香氣 (但不應有松香氣)，冒黑煙，並遺留黑色殘渣。與少量水共研，能形成白色乳狀液', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0165','鱉甲','Turtle Carapace','滋腎潛陽，軟堅散結。主治骨蒸勞熱、瘧母、脅下堅硬、腰痛，經閉症瘕等症','鹹，寒','以身乾、個大、無殘肉、潔淨者為佳','為卵圓形或橢圓形的骨片，背部微隆起，前後端微向內捲曲。長約10~23cm，寬8~17cm，厚約5mm。背甲中央有不顯明的骨節隆起，兩側各有八條左右對稱的橫凹紋。背面為灰褐色並有皺褶及突起狀斑點。甲的邊緣呈齒狀，類白色。腹面灰白色，有骨隆起明顯，兩側對稱的肋各8條。質堅硬。臭微腥，味鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0166','蟬蛻','Cicada Slough','散風除熱，利咽，透疹，退翳，解痙。用於風熱感冒，咽痛，音啞，麻疹不透，風疹瘙癢，目赤翳障，驚風抽搐，破傷風','甘，寒','以體形完整、亮黃色者為佳','全形似蟬而中空，稍彎曲。長約4cm，寬約2cm。表面黃棕色，半透明，有光澤。頭部有絲狀觸角1對，多已斷落，複眼突出，頸部先端突出，口吻發達，上唇寬短，下唇伸長成管狀。胸部背面呈十字形裂片，裂口向內捲曲，脊背兩旁具有小翅2對；腹面有足3對，被黃棕色細毛。腹部鈍圓，共9節。體輕，中空，易碎。無臭，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0167','地龍','Earthworm','清熱定驚，通絡，平喘，利尿。用於高熱神昏，驚癇抽搐，關節痹痛，肢體麻木，半身不遂，肺熱喘咳，尿少水腫，高血壓','鹹，寒','以條大、肉厚者為佳','滬地龍：長8~15cm，寬0.5~1.5cm。全體具環節，背部棕褐色至黃褐色，腹部淺黃棕色；受精囊孔3對，在6/7至8/9環節間。第14~16環節為生殖帶，較光亮。第18環節有一對雄生殖孔。通俗環毛蚓的雄交配腔能全部翻出，呈花菜狀或陰莖狀；威廉環毛蚓的雄交配腔孔呈縱向裂縫狀；櫛盲環毛蚓的雄生殖孔內側有1或多個小乳突', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0168','阿膠','Ass-hide Gelatin','補血，止血，滋陰潤燥','甘，平','以色勻、質脆、半透明、斷面光亮者為佳','正品阿膠為長方形或方形塊，質硬而脆，無油孔、氣孔及明顯刀紋。表面平滑有光澤，斷面對光照視呈棕色半透明狀，膠塊表面當以黃透如琥珀色，光黑如漆。氣微，味微甘', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0169','龜甲','Tortoses Carapae and Plastron','滋陰潛陽，益腎強骨，養血補心。用於陰虛潮熱，骨蒸盜汗，頭暈目眩虛風內動，筋骨痿軟，心虛健忘','咸、甘，微寒','以塊大、無殘肉、板有血跡者為佳','該品背甲及腹甲由甲橋相連，背甲稍長於腹甲，與腹甲常分離。背甲呈長橢圓形拱狀，長7.5~22cm，寬6~18cm；外表面棕褐色或黑褐色，脊棱3條；頸盾1 塊，前窄後寬；椎盾5 塊，第1椎盾長大於寬或近相等，第2~4椎盾寬大於長；肋盾兩側對稱，各4塊，緣盾每側11塊，臀盾2塊。腹甲呈板片狀，近長方橢圓形，長6.4~21cm，寬5.5~17cm；外表面淡黃棕色至棕黑色，盾片12塊，每塊常具紫褐色放射狀紋理，腹盾、胸盾和股盾中縫均長，喉盾、肛盾次之，肱盾中縫最短；內表面黃白色至灰白色，有的略帶血跡或殘肉，除淨後可見骨板9 塊，呈鋸齒狀嵌接；前端鈍圓或平截，後端具三角形缺刻，兩側殘存呈翼狀向斜上方彎曲的甲橋。質堅硬。氣微腥，味微鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0170','海螵蛸','Sepium','收斂止血，澀精止帶，制酸，斂瘡。用於胃痛吞酸，吐血衄血，崩漏便血，遺精滑精，赤白帶下；潰瘍病。外治損傷出血，瘡多膿汁','咸、澀，溫','以潔淨色白者為佳','金烏賊：長13~23cm，寬約至6.5cm。背面疣點明顯，略呈層狀排列；腹面的細密波狀橫層紋占全體大部分，中間有縱向淺槽；尾部角質緣漸寬，向腹面翹起，末端有1骨針，多已斷落', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0171','僵蠶','Stiff Silkworm','祛風定驚，化痰散結。用於驚風抽搐，咽喉腫痛，頜下淋巴結炎，面神經麻痹，皮膚瘙癢','咸、辛，平','以質硬、色白、條粗者為佳','本品略呈圓柱形，多彎曲皺縮。長2~5cm，直徑0.5~0.7cm。表面灰黃色，被有白色粉霜狀的氣生菌絲和分生孢子。頭部較圓，足8對，體節明顯，尾部略呈二分歧狀。質硬而脆，易折斷，斷面平坦，外層白色，中間有亮棕色或亮黑色的絲腺環4個。氣微腥。味微鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0172','羚羊角','Antelope Hom','平肝息風，清肝明目，散血解毒。用於高熱驚癇，神昏痙厥，子癇抽搐，癲癇發狂，頭痛眩暈，目赤翳障，溫毒發斑，癰腫瘡毒','鹹，寒','以質嫩、色白、光潤、內涵紅色斑紋且無裂紋者佳','羚羊角縱片：為縱向條狀薄片，類白色或黃白色，表面光滑，半透明，有光澤。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0173','牡蠣','Common Oyster Shell','重鎮安神，潛陽補陰，軟堅散結。用於驚悸失眠，眩暈耳鳴，瘰鬁痰核，症瘕痞塊。煆牡蠣收斂固澀。用於自汗盜汗，遺精崩帶，胃痛吞酸','鹹，微寒','以質堅、內面光潔、色白者為佳','近江牡蠣：呈圓形、卵圓形或三角形等。右殼外面稍不平，有灰、紫、棕、黃等色，環生同心鱗片，幼體者鱗片薄而脆，多年生長後鱗片層層相疊，內面白色，邊緣有的淡紫色', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0174','牛黃','Bezoar','清心，豁痰，開竅，涼肝，息風，解毒。用於熱病神昏，中風痰迷，驚癇抽搐，癲癇發狂，咽喉腫痛，口舌生瘡，癰腫疔瘡','甘，涼','以完整鬆脆、棕黃色、斷面層紋清晰細膩者為佳','該品多呈卵形、類球形、三角形或四方形等，大小不一，直徑0.6~3(4.5)cm，少數呈管狀或碎片。表面黃紅色至棕黃色，有的表面掛有一層黑色光亮的薄膜，有的粗糙，具疣狀突起，有的具龜裂紋。體輕，質酥脆，易分層剝落，斷面金黃色，可見細密的同心層紋，有的夾有白心。氣清香，味苦而後甘，有清涼感，嚼之易碎，不粘牙', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0175','全蠍','Scorpion','息風鎮痙，攻毒散結，通絡止痛。用於小兒驚風，抽搐痙攣，中風口歪，半身不遂，破傷風，風濕頑痹，偏正頭痛，瘡瘍，瘰鬁','辛，平，有毒','以體大、肥壯、尾全、不破碎、腹中雜物少者為佳','該品頭胸部與前腹部呈扁平長橢圓形，後腹部呈尾狀，皺縮彎曲，完整者體長約6cm。頭胸部呈綠褐色，前面有1對短小的螯肢及1對較長大的鉗狀腳須，形似蟹螯，背面覆有梯形背甲，腹面有足4對，均為7節，末端各具2爪鉤；前腹部由 7節組成，第七節色深，背甲上有5 條隆脊線。背面綠褐色，後腹部棕黃色，6節，節上均有縱溝，末節有銳鉤狀毒刺，毒刺下方無距。氣微腥，味鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0176','桑螵蛸','Mantis Egg-case','益腎固精，縮尿，止濁。用於遺精滑精，遺尿尿頻，小便白濁','甘、咸，平','以完整、色黃、體輕帶韌性、卵未孵出者為佳','黑螵蛸：略呈平行四邊形，長2~4cm，寬1.5~2cm。表面灰褐色，上面帶狀隆起明顯，兩側有斜向紋理，近尾端微向上翹。質硬而韌', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0177','麝香','Abelmosk','開竅醒神，活血通經，消腫止痛。用於熱病神昏，中風痰厥，氣鬱暴厥中惡昏迷，經閉，癓瘕，難產死胎，心腹暴痛，癰腫瘰鬁，咽喉腫痛，跌撲傷痛，痹痛麻木','辛，溫','以飽滿、皮薄、有彈性、香氣濃者為佳','麝香仁：野生者質軟，油潤，疏鬆；其中顆粒狀者習稱“當門子”，呈不規則圓球形或顆粒狀，表面多呈紫黑色，油潤光亮，微有麻紋，斷面深棕色或黃棕色；粉末狀者多呈棕褐色或黃棕色，並有少量脫落的內層皮膜和細毛。飼養者呈顆粒狀、短條形或不規則的團塊；表面不平，紫黑色或深棕色，顯油性，微有光澤，並有少量毛和脫落的內層皮膜。氣香濃烈而特異，味微辣、微苦帶鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0178','石決明','Sea-ear Shell','平肝潛陽，清肝明目。用於頭痛眩暈，目赤翳障，視物昏花，青盲雀目','鹹，寒','以個大整齊、無破碎、殼厚、內面光彩鮮豔者為佳','白鮑：呈卵圓形，長11~14cm，寬8.5~11cm，高3~6.5cm。表面磚紅色，光滑，殼頂高於殼面，生長線頗為明顯，螺旋部約為殼面的1/3，疣狀突起30餘個，末端9個開孔，孔口與殼平', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0179','水牛角','Buffalo Horn','清熱，涼血，定驚，解毒。治傷寒溫疫熱入血分，驚狂，煩躁，譫妄，斑疹，發黃，吐血，衄血，下血，癰疽腫毒','苦、鹹，寒','以紋理緻密者為佳','形狀彎曲呈弧形，根部方形或略呈三角形，中空，一側表面有多數平行的凹紋，角端尖銳。色黑褐，質堅硬，剖面紋細而不顯，氣腥。一般多用其角尖部', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0180','磁石','Magnetite','平肝潛陽；安神鎮驚；聰耳明目；納氣平喘。主眩暈；目花；耳聾；耳鳴；驚悸；失眠，腎虛喘逆','鹹，寒','以斷面緻密有光澤、灰黑色、能吸鐵者為佳','晶體呈八面體、十二面體。晶面有條紋。多為粒塊狀集合體。鐵黑色，或具暗藍靛色。條痕黑，半金屬光澤。不透明。無解理。斷口不平坦。硬度5.5~6.5。密度5.16~5.18g/cm3。具強磁性。性脆。無臭，無味', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0181','滑石','Talc','利尿通淋，清熱解暑，祛濕斂瘡。用於熱淋，石淋，尿熱澀痛，暑濕煩渴，濕熱水瀉；外治濕疹，濕瘡，痱子','甘、淡，寒','以滑潤、色白者為佳','本品多為塊狀集合體。呈不規則的塊狀。白色、黃白色或淡藍灰色，有蠟樣光澤。質軟細膩，手摸有滑潤感，無吸濕性，置水中不崩散。無臭，無味', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0182','芒硝','Glauber’s Salt','破痞，溫中，消食，逐水，緩瀉。用於胃脘痞，食痞，消化不良，浮腫水腫，乳腫，閉經，便秘','鹹、苦，寒','以條塊狀結晶、無色透明者為佳','單斜晶系，晶體呈短柱狀或針狀；通常成緻密塊狀、纖維狀集合體。無色或白色，玻璃光澤，具完全的板面解理，莫氏硬度1.5~2，比重1.48。味清涼略苦咸，極易潮解，在乾燥的空氣中逐漸失去水分而轉變為白色粉末狀的無水芒硝。本品為棱柱狀、長方形或不規則塊狀及粒狀。無色透明或類白色半透明。質脆，易碎，斷面呈下班樣光澤。無臭，味鹹', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0183','雄黃','Red Orpiment','解毒殺蟲，燥濕祛痰，截瘧。用於癰腫疔瘡，蛇蟲咬傷，蟲積腹痛，驚癇，瘧疾','辛，溫，有毒','以塊大、紅色、質鬆脆為佳',') 和砷華，不溶于水和鹽酸，可溶於硝酸，溶液呈黃色', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0184','朱砂','Cinnabar','清心鎮驚，安神解毒，用於心悸易驚，失眠多夢，癲癇發狂，小兒驚風視物昏花，口瘡，喉痹，瘡瘍腫毒','甘，微寒，有小毒','以色鮮紅、有光澤、體重、質脆者為佳','三方晶系。為粒狀或塊狀集合體，呈顆粒狀或塊片狀。鮮紅色或暗紅色條痕紅色至褐紅色，具光澤。有平行的完全解理。斷口呈半貝殼狀或參差狀。硬度2~2.5。比重8.09~8.2。體重，質脆，片狀者易破碎，粉末狀者有閃爍的光澤，無味。金剛、半金屬、暗淡光澤。其中呈細小顆粒或粉末狀，色紅明亮，觸之不染手者，習稱“朱寶砂”；呈不規則板片狀、斜方形或長條形，大小厚薄不一，邊緣不整齊，色紅而鮮豔，光亮如鏡面而為透明，質較鬆脆者，習稱“鏡面砂”；方塊較大，方圓形或多角形，色發暗或呈灰褐色，質重而堅，不易碎者習稱“豆瓣砂”', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0185','石膏','Gypsum','清熱瀉火，除煩止渴。用於外感熱病，高熱煩渴。肺熱喘咳，胃火亢盛，頭痛，牙痛','甘、辛，大寒','以色白，體重，質軟。縱斷面具絹絲樣光澤者為佳','本品為纖維狀的集合體，呈長塊狀、板塊狀或不規則塊狀。白色、灰白色或淡黃色，有的半透明。體重，質軟。縱斷面具絹絲樣光澤。氣微，味淡', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0186','青黛','Natural Indigo','清熱，涼血消斑，解毒，清肝瀉火，定驚。主治溫病熱盛，斑疹，吐血咯血，小兒驚癇，瘡腫，丹毒，蛇蟲咬傷','鹹，寒','以藍色均勻、能浮於水面、火燒產生紫紅色煙霧時間較長者為佳','本品為極細的粉末，灰藍色或深藍色，質輕，易飛揚，可粘手粘紙。具草腥氣，味微酸', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0187','冰片','Synthetic Borneol','開竅醒神，清熱止痛。用於熱病神昏、痙厥，中風痰厥，氣鬱暴厥，中惡昏迷，目赤，口瘡，咽喉腫痛，耳道流膿','辛、苦，微寒','以片大、色潔白、質鬆脆、氣清香者為佳','梅花冰片：為半透明似梅花瓣塊狀、片狀的結晶體，故稱“梅片”；直徑0.1~0.7cm，厚約0.1cm類白色至淡灰棕色，氣清香，味清涼，嚼之慢慢溶化。燃燒時無黑煙或微有黑煙', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0188','五倍子','Chinese Nut-gall','斂肺；止汗；澀腸；固精；止血；解毒。主治肺虛久咳；自汗盜汗；久痢久瀉；脫肛；遺精；白濁；各種出血；癰腫瘡癤','酸、澀，寒','以個大、完整、壁厚、灰褐色者為佳','肚倍：呈長圓形或紡錘形囊狀，長2.5~9cm，直徑1.5~4cm。表面灰褐色或灰棕色，微有柔毛。質硬而脆，易破碎，斷面角質樣，有光澤，壁厚0.2~0.3cm，內壁平滑，有黑褐色死蚜蟲及灰色粉狀排泄物。氣物異，味澀', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0189','沉香','Tambac','行氣止痛，溫中止嘔，納氣平喘。用於胸腹脹悶疼痛，胃寒嘔吐呃逆，腎虛氣逆喘急','辛、苦，微溫','以體重、色棕黑油潤，燃之有油滲出、香氣濃烈者為佳','該品為不規則的塊狀、片狀或盔帽狀，有的為小碎塊。質較堅實。氣芳香，苦味。燃燒時有濃烈的香氣，並有黑色油狀物滲出', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0190','南棗','South Jujube','滋腎養肝、健腦安神、補脾養胃、活血強心、養顏烏髮、改善微循環和抗癌保健、潤心肺、止咳嗽、補五脈、治虛損之效','甘，温','皮色烏亮透紅，花紋細緻，肉質金黃，個大均勻，為棗中之珍品','果實橢圓形或球形，長2~3.5cm，直徑1.5~2.5cm。表面暗紅色，略帶光澤，有不規則皺紋。基部凹陷，有短果柄。外果皮薄，中果皮棕黃色或淡褐色，肉質，柔軟，富糖性而油潤。果核紡錘形，兩端銳尖，質堅硬。氣微香，味甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0191','黑杞子','Black Wolfberry Fruit','補腎益精、護肝明目、增進視力、美容養顏、改善皮膚','甘，平','青海出產的九葉藍野生黑枸杞為最佳','紫黑色，球狀，有時頂端稍凹陷，直徑4-9毫米', '0')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0192','黨參','Pilose Asiabell Root','補中益氣，健脾益肺。用於脾肺虛弱，氣短心悸，食少便溏，虛喘咳嗽，內熱消渴','甘、微酸，性平','以條粗長、質柔潤、氣味濃，“化渣”者為佳','呈長圓柱形，稍彎曲，長10~35cm，直徑0.4~2cm。根上端1~3cm部分有環紋，質稍軟，斷面裂隙少。味微酸。根頭部有多數疣狀突起的莖痕的頂端呈凹下的圓點狀；根頭下有緻密的環狀橫紋，向下漸稀疏，有的達全長的一半，栽培品環紋少或無；全體有縱皺紋及散在的橫長皮孔，支根斷落處常有黑褐色膠狀物。質稍硬或略帶韌性，斷面稍平坦，有裂隙或放射狀紋理，皮部淡黃白色至淡棕色，木部淡黃色。有特殊香氣，味微甜', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0193','夜交藤','Tuber Fleeceflower Stem','養心安神，祛風，通絡。 用於失眠，多夢，血虛身痛，肌膚麻木，風濕痺痛，風疹瘙癢。 ','味甘、微苦，性平。 ','枝條粗壯，均勻，外皮棕紅色者為佳','藤莖長圓柱形，稍扭曲，長短不一，直徑3-7mm。表面棕紅色或棕褐色，粗糙，有明顯扭曲的縱皺紋及細小圓形皮孔。節部略膨大，有分枝痕。外皮菲薄，可剝離。質脆，易折斷，斷面皮部棕紅色，木部淡黃色，導管孔明顯，中央為白色疏鬆的髓部。氣無，味微苦、澀。以枝條粗壯，均勻，外皮棕紅色者為佳', '1')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape, $colHaveIcon) VALUES('0194','熟地黃','Processed Rehmannia Root','熟地黃滋陰補血，益精填髓。可用于陰虛發熱，消渴，吐血，衄血，血崩，月經不調，胎動不安，陰傷便秘等症','熟地黃甘，微溫','熟地黃以軟塊大、內外烏黑有光澤者為佳','熟地黃：為不規則的塊片、碎塊，大小、厚薄不一。表面烏黑色，有光澤，粘性大。質柔軟而帶韌性，不易折斷，端面烏黑色，有光澤。味甜', '1')");


    await db.execute(
        'CREATE TABLE $formulaeTable($formula_id TEXT PRIMARY KEY, $formula_chinese_name TEXT, $formula_phonetic TEXT, $formula_english_name TEXT, $formula_classification TEXT, $formula_source TEXT, $formula_combination TEXT, $formula_method TEXT, $formula_action TEXT, $formula_indication TEXT, $formula_pathogenesis TEXT, $formula_clarification TEXT, $formula_application TEXT, additonal_$formulaeTable TEXT, $formula_formula_song TEXT)');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("1","麻黃湯","Ma Huang Tang","Ephedra Decoction","解表劑","《傷寒論》","麻黃三兩 (9g) 桂枝二兩 (6g) 杏仁七十個 (6g) 炙甘草 一兩 (3g)","先煮麻黃，去上沫，內諸藥，水煎，溫服，覆取微汗","發汗解表，宣肺平喘","外感風寒表實證。惡寒發熱，頭疼身痛，無汗而喘，舌苔薄白，脈浮緊","本方證由外感風寒，肺氣失宣所致。風寒襲表，衛陽被遏，腠理閉塞，營陰鬱滯，經脈不通，故惡寒，發熱，無汗，頭身痛。肺主氣屬衛，外合皮毛。寒邪束表，影響肺氣正常宣降，表鬱則肺氣亦鬱，故上逆為喘。舌苔薄白，脈浮緊為風寒外束之征。治當發汗解表，宣肺平喘","","1. 辨證要點：本方為治療外感風寒表實證的代表方和基礎方。臨床以惡寒發熱，無汗而喘，脈浮緊為辨證要點。 2. 現代運用: 本方常用於感冒、流行性感冒、上呼吸道感染、急性支氣管炎、支氣管哮喘、鼻炎等辨證屬風寒表實證者。 3. 注意事項：本方為辛溫發汗之峻劑，故不可過服，以免耗氣傷津。凡風寒表虛證、風熱表證及正虛外感風寒等皆不宜使用","1. 麻黃加朮湯《金匱要略》麻黃去節，三兩 (9g) 桂枝去皮，二兩 (6g) 炙甘草，一兩 (3g) 杏仁去皮尖，七十個 (6g) 白朮四兩 (12g) 上五味，以水九升，先煮麻黃，減二升，去上沫，內諸藥，煮取二升半，去滓，溫服八合，覆取微似汗。功用：發汗解表，散寒祛濕。主治：風寒夾濕痹證。身體煩疼，無汗等。 2. 麻黃杏仁薏苡甘草湯《金匱要略》麻黃去節，湯泡，半兩 (6g) 杏仁去皮尖，炒，十個 (6g) 薏苡仁半兩 (12g) 炙甘草，一兩 (3g) 上銼，如麻豆大，每服四錢 (12g)。以水一盞半，煎至八分，去滓溫服。有微汗，避風。功用：發汗解表，祛風利濕。主治：風濕在表，濕鬱化熱證。一身盡疼，發熱，日晡所劇者。 3. 大青龍湯《傷寒論》麻黃去節，六兩 (12g) 桂枝去皮，二兩 (6g) 炙甘草，二兩 (6g) 杏仁去皮尖，四十枚 (6g) 石膏如雞子大，碎 (12g) 生薑切，三兩 (9g) 大棗十二枚，擘 (3g) 上七味，以水九升，先煮麻黃，減二升，去上沫，內諸藥，煮取三升，去滓，溫服一升。取微似汗，汗出多者，溫粉撲之；一服汗者，停後服；若復服，汗多亡陽，遂虛，惡風，煩躁，不得眠也。功用：發汗解表，兼清裏熱。主治：外感風寒，裏有鬱熱證。惡寒發熱，頭身疼痛，無汗，煩躁，口渴，脈浮緊。 4. 三拗湯《太平惠民和劑局方》甘草不炙 麻黃不去根節 杏仁不去皮尖 各等分 (30g)，上為粗末，每服五錢 (15g)，水一盞半，薑五片，同煎至一盞，去滓，通口服。以衣被蓋覆睡，取微汗為度。功用：宣肺解表。主治：外感風寒，肺氣不宣證。鼻塞聲重，語音不出，咳嗽胸悶。 5. 華蓋散《博濟方》紫蘇子炒 麻黃去根節 杏仁去皮尖 陳皮去白 桑白皮 赤茯苓去皮，各一兩 (30g) 甘草半兩 (15g) 上為末，每服2錢 (6g)，水一盞，煎至六分，食後溫服。功用：宣肺解表，祛痰止咳。主治：素體痰多，肺感風寒證。咳嗽上氣，呀呷有聲，吐痰色白，胸膈痞滿，鼻塞聲重，惡寒發熱，苔白潤，脈浮緊","麻黃湯中用桂枝，杏仁甘草四般施， 發熱惡寒頭項痛，喘而無汗服之宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("2","桂枝湯","Gui Zhi Tang","Cinnamon Twig Decoction","解表劑","《傷寒論》","桂枝三兩 (9g) 芍藥三兩 (9g) 炙甘草 二兩 (6g) 生薑三兩 (9g) 大棗十二枚 (3g)","水煎，溫服。啜熱粥，溫覆以助取汗，以微汗為度","解肌發表，調和營衛","外感風寒表虛證。惡風發熱，汗出，頭痛，鼻鳴乾嘔，苔白不渴，脈浮緩或浮弱者","本方之外感風寒表虛證，《傷寒論》言其 「太陽中風」，「營弱衛強」。所謂 「衛強」，是指風寒外襲，衛陽抗邪，經脈不利之發熱，頭痛，脈浮，有邪氣實之意；所謂 「營弱」，是衛陽不固，營陰失守，津液外泄之汗出，惡風，脈緩，有正氣虧之意。此證的病機為外感風寒，營衛不和，治宜解肌發表，調和營衛","1. 本方證中已有汗出，何以又用桂枝湯發汗？蓋本證之自汗，是由風寒外襲，衛陽不固，營陰失守，津液外泄所致。故外邪不去，營衛不和，則汗不能止。桂枝湯雖曰 「發汗」，實寓解肌發表與調和營衛雙重用意，外邪去而肌表固密，營衛和則津不外泄。故如法服用本方，於遍身微汗之後，則原證之汗出自止。 2. 關於桂枝與白芍的配伍：方中桂枝散解邪，助衛陽、通經絡，祛在表之風邪，兼治經脈不利之頭痛，是為 「衛強」 而設；白芍益陰斂營，既補其因汗出耗損之營陰，又酸收以斂固外泄之營陰，是為 「營弱」 而配。桂芍等量合用，一則，針對衛強營弱，體現營衛同治，邪正兼顧，是相輔相成之配伍形式；二則散中有收，汗中寓補，是相制相成之配伍形式。二藥一治 「衛強」，一治 「營弱」；一助衛陽，一益營陰，故為調營衛、調陰陽的基本結構。仲景調氣血陰陽的方每配用此結構。 3. 關於服法：本方服法要求啜熱粥與溫覆取微汗。藥後啜熱稀粥。一則借水穀之精氣，溫養中焦，培益汗源，易於釀汗：二則藉穀氣內充，鼓舞胃氣，以助衛陽驅邪外出。溫覆可以保暖/為取汗創造條件；出汗以全身微汗為佳，如此，既不傷正氣，又可使邪從汗解。 4. 關於 「病汗」 與 「藥汗」 的區別：外感風寒表虛證之汗出為 「病汗」，服桂枝湯後之汗出為 「藥汗」。二者的區別是病汗常帶涼意，伴惡風、頭痛等症，多為局部出汗；藥汗則帶熱意，為遍身微汗，汗出病癒","1. 辨證要點：本方為治療外感風寒表虛證的基礎方，又是調和營衛、調和陰陽治法的代表方。臨床應用以惡風，發熱/汗出，脈浮緩為辨證要點。 2. 現代運用：普通感冒、流行性感冒、上呼吸道感染屬於外感風寒表虛證者；以及風濕性關節炎、多形紅斑、蕁麻疹、皮膚瘙癢症、過敏性鼻炎、妊娠嘔吐等辨證屬營衛不和者。 3. 注意事項：凡外感風寒表實無汗者禁用。服藥期間禁食生冷、粘膩、酒肉、臭惡等物","1. 桂枝加葛根湯《傷寒論》桂枝去皮，二兩 (6g) 芍藥二兩 (6g) 生薑切，三兩 (9g) 炙甘草，二兩 (6g) 大棗擘，十二枚 (3枚) 葛根四兩 (12g) 上六味，以水一斗，先煮葛根，減二升，內諸藥，煮取三升，去滓，溫服一升。覆取微似汗，不須啜粥，餘如桂枝法將息及禁忌。功用：解肌發表，升津舒筋。主治：風寒客於太陽經輸，營衛不和證。桂枝湯證兼項背強而不舒者。 2. 桂枝加厚樸杏子湯《傷寒論》桂枝去皮，三兩 (9g) 芍藥三兩 (9g) 生薑切，三兩 (9g) 炙甘草，二兩 (6g) 大棗擘，十二枚 (3枚) 厚樸炙，去皮，二兩 (6g) 杏仁去皮尖，五十枚 (6g) 上七味，以水七升，微火煮取三升，去滓。溫服一升，覆取微似汗。功用：解肌發表，降氣平喘。主治：宿有喘病，又感風寒而見桂枝湯證者；或風寒表證誤用下劑後，表證未解而微喘者","桂枝湯治太陽風，芍藥甘草薑棗同， 解肌發表調營衛，表虛有汗此為功")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("3","九味羌活湯","Jiu Wei Qiang Huo Tang","Nine Ingredients Notopterygium Decoction","解表劑","《張元素方》錄自《此事難知》","羌活一兩半 (9g) 防風一兩半 (9g) 蒼朮一兩半 (9g) 細辛五分 (3g) 川芎一兩 (6g) 香白芷一兩 (6g) 生地黃一兩 (6g) 黃芩一兩 (6g) 甘草一兩 (6g)","水煎，溫服。若急汗，熱服，以羹粥投之；若緩汗，溫服之，而不用湯投之","發汗祛濕，兼清裏熱","外感風寒濕邪，內有蘊熱證。惡寒發熱，無汗，頭痛項強，肢體酸楚疼痛，口苦微渴，舌苔白或微黃，脈浮或浮緊","本方證由外感風寒濕邪，兼內有蘊熱所致。風寒濕邪侵犯肌表，鬱遏衛陽，閉塞腠理，阻滯經絡，氣血運行不暢，故惡寒發熱，肌表無汗，頭痛項強，肢體酸楚疼痛。裏有蘊熱，故口苦微渴。苔白或微黃、脈浮，是表證兼裏熱之佐證。治當發散風寒濕邪為主，兼清裏熱為輔","1. 關於 「分經論治」：宋金元之前，表證皆從仲景太陽論治。然外感風寒濕邪，太陽雖首當其衝，但六經皆可累及。方中羌活主入太陽；蒼朮主入太陰；細辛主入少陰；川芎主入厥陰；白芷主入陽明；黃芩主入少陽，合用則既兼治內外，又分屬六經。於此，原書強調 「以上九味，雖為一方，然亦不可執」。具體運用時，「當視經絡前後左右之不同，從其多少、大小、輕重之不一，增損用之」，方能 「其效如神」。現代應用，若頭痛以後頭痛牽連項部為特點，重用羌活；以前額部為甚，重用白芷；頭頂痛或兩側頭痛明顯，重用川芎；頭痛牽引牙痛者，每重用細辛。 2. 關於服法：方劑功效的發揮與服法密切相關，臨證應用本方尚須據病情輕重，通過服法控制其解表發汗的強弱。若寒邪較甚，表證較重，宜熱服本方，藥後應啜粥以助藥力，以便釀汗祛邪；若寒邪不甚，表證較輕，則不必啜粥，溫服本方即可微發其汗","1. 辨證要點：本方是主治外感風寒濕邪而兼有內熱證的常用方，亦是體現 「分經論治」 思想的代表方。臨床應用以惡寒發熱，頭痛無汗，肢體酸楚疼痛，口苦微渴為辨證要點。 2. 現代運用：本方常用於感冒、急性肌炎、風濕性關節炎、偏頭痛、腰肌勞損等屬外感風寒濕邪，兼有裏熱者。 3. 注意事項：本方雖有生地、黃芩之寒，但總屬辛溫燥烈之劑，故風熱表證及陰虛內熱者不宜使用","大羌活湯《此事難知》卷上，羌活 獨活 防風 細辛 防已 黃芩 黃連 蒼朮 炙甘草 白朮各三錢 (9g) 知母 川芎 地黃各一兩 (30g) 每服半兩 (15g)，水二盞，煎至一盞半，去渣，得清藥一大盞，熱飲之；不解，再服三、四盞解之亦可，病癒則止。功用：發散風寒，祛濕清熱。主治：外感風寒濕邪兼有裏熱證。頭痛身重，發熱惡寒，口乾煩滿而渴，舌苔白膩，脈浮數","九味羌活用防風，細辛蒼芷與川芎， 黃芩生地同甘草，分經論治宜變通")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("4","香蘇散","Xiang Su San","Cyperus and Perilla Powder","解表劑","《太平惠民和劑局方》","香附子 紫蘇葉 各四兩 (120g) 炙甘草 一兩 (30g) 陳皮二兩 (60g)","煮散劑，每服9g，熱服，不拘時候；亦可作湯劑，水煎服，用量按原方比例酌減","疏散風寒，理氣和中","外感風寒，氣鬱不舒證。惡寒身熱，頭痛無汗，胸脘痞悶，不思飲食，舌苔薄白，脈浮","風寒之邪，四時皆有。本方是為外感風寒，受邪輕淺，內兼氣滯證而設。惡寒發熱，頭痛無汗，舌苔薄白，脈浮，與一般表證無異；胸脘痞悶，不思飲食，則為氣鬱不舒之徵象。治宜解表理氣。因感邪較輕，當 「以輕鬆流利為佳，不必動輒峻劑也」《醫方論》卷1","","1. 辨證要點：本方為治療外感風寒而兼氣滯的常用方。臨床應用以惡寒發熱，頭痛無汗，胸脘痞悶，苔薄白，脈浮為辨證要點。 2. 現代運用：本方多用於胃腸型感冒屬感受風寒兼氣機鬱滯者","1. 香蘇蔥豉湯《重訂通俗傷寒論》制香附一錢半至二錢 (4.5-6g) 新會皮一錢半至二錢 (4.5-6g) 鮮蔥白二三枚 (3枚) 紫蘇一錢半至三錢 (4.5-9g) 清炙草六分至八分 (2-2.5g) 淡香豉三錢至四錢 (9-12g) 水煎服。功用：發汗解表，調氣安胎。主治：妊娠傷寒。惡寒發熱，無汗，頭身痛，胸脘痞悶，苔薄白，脈浮。 2. 加味香蘇散《醫學心悟》卷2 紫蘇葉一錢五分 (5g) 陳皮 香附各一錢二分 (各4g) 炙甘草，七分 (2.5g) 荊芥 秦艽 防風 蔓荊子各一錢 (各3g) 川芎五分 (1.5g) 生薑三片 上銼一劑。水煎，溫服。微覆似汗。功用：發汗解表，理氣解鬱。主治：外感風寒，兼有氣滯證，頭痛項強，鼻塞流涕，身體疼痛，發熱惡寒或惡風，無汗，胸脘痞悶，苔薄白，脈浮","香蘇散內草陳皮，疏散風寒又理氣， 外感風寒兼氣滯，寒熱無汗胸脘痞")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("5","小青龍湯","Xiao Qing Long Tang","Minor Green Dragon Decoction","解表劑","《傷寒論》","麻黃三兩 (9g) 芍藥三兩 (9g) 細辛三兩 (6g) 乾薑三兩 (6g) 炙甘草 三兩 (6g) 桂枝三兩 (9g) 半夏半升 (9g) 五味子半升 (6g)","水煎，溫服","解表散寒，溫肺化飲","外寒裏飲證。惡寒，發熱，頭身疼痛，無汗，喘咳，痰涎清稀而量多，胸痞，或乾嘔，或痰飲喘咳，不得平臥，或身體疼重，頭面四肢浮腫，舌苔白滑，脈浮","本方主治之證乃素有水飲，復感風寒所致。惡寒發熱，無汗，身體疼痛，為風寒束表，衛陽被遏，營陰鬱滯的表實證。素有水飲之人，一旦感受外邪，每致表寒引動內飲。寒飲射肺，肺失宣降，故咳喘痰多而稀；水停心下，阻滯氣機，故胸痞；水留胃中，胃氣上逆，故乾嘔；飲溢肌膚，故浮腫身重。舌苔白滑，脈浮，是為外寒裏飲之佐證。此時，不化飲而專散表邪，則水飲不除；不疏表而單蠲水飲，則表邪難解，唯有解表化飲，內外合治，才是正法","關於五味子、芍藥的配伍：大凡外感之證，多忌酸收之品，而兼痰嗽者尤忌之，本方何以配用酸收之五味子、白芍？小青龍湯證為素有內飲，復感風寒，外寒引動內飲所致。外感風寒，毛竅閉塞，本應辛溫發散，但素有寒飲之人，脾肺本虛，若以峻劑發汗，則有耗散肺氣，劫陰損津之弊，應當發散與酸收並用，氣陰兼顧，方為兩全。方中以麻、桂相須為用，發汗祛邪；薑、辛、夏溫肺化飲，五藥皆為辛散性溫之品，而五味子功能斂肺止咳，芍藥功能斂陰養血，二藥與前五藥相配，則辛散發汗而不耗氣傷津；酸斂而不留邪，相反相成，相得益彰。況且五味子、白芍的配伍，不僅是佐制之用，更有佐助之效，本方止咳平喘功效的發揮，與二藥的配入有關。五味子止咳平喘之功，古代本草書籍已有定論；現代中藥藥理研究證實，白芍能緩解支氣管痙攣而具平喘之效。可見，二藥的配伍能增強本方平喘之力","1. 辨證要點：本方是治療外感風寒，寒飲內停喘咳的常用方劑。臨床應用以惡寒發熱，無汗，喘咳，痰多而稀，舌苔白滑，脈浮為辨證要點。 2. 現代運用：本方常用於支氣管炎、支氣管哮喘、肺炎、百日咳、肺心病、過敏性鼻炎、卡他性眼炎、卡他性中耳炎等屬於外寒裏飲證者。 3. 注意事項：本方因其辛散溫化之力較強，應以確屬水寒相搏於肺者，方宜使用，且視病人體質強弱酌定劑量。陰虛乾咳無痰或痰熱證者，不宜使用","射干麻黃湯《金匱要略》射干三兩 (9g) 麻黃四兩 (9g) 生薑四兩 (6g) 細辛三兩 (6g) 紫菀三兩 (6g) 款冬花三兩 (6g) 大棗七枚 (3枚) 半夏大者洗，半升 (9g) 五味子半升 (3g) 上九味，以水一斗二升，先煮麻黃兩沸，去上沫，內諸藥，煮取三升，分溫三服。功用：宣肺祛痰，下氣止咳。主治：痰飲鬱結，氣逆喘咳。咳而上氣，喉中有水雞聲者","小青龍湯最有功，風寒束表飲停胸， 辛夏甘草和五味，薑桂麻黃芍藥同")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("6","止嗽散","Zhi Sou San","Cough-Stopping Powder","解表劑","《醫學心悟》","桔梗 荊芥 紫菀 百部 白前 各二斤 (1kg) 甘草炒 十二兩 (375g) 陳皮一斤 (500g)","散劑，每服9g，食後、臨臥開水調下；初感風寒，生薑湯調下；亦可作湯劑，水煎服，用量按原方比例酌減","宣利肺氣，疏風止咳","風邪犯肺證。咳嗽咽癢，咯痰不爽，或微有惡風發熱，舌苔薄白，脈浮緩","本方治證為外感咳嗽，經服解表宣肺藥後而咳仍不止者。風邪犯肺，肺失宣肅，雖經發散，其邪未盡，故仍咽癢咳嗽，此時外邪十去八九，故微有惡風發熱。治法重在理肺止咳，微加疏表之品","","1. 辨證要點：本方為治療表邪未盡，肺氣失宣而致咳嗽的常用方。臨床以咳嗽咽癢，微惡風發熱，苔薄白為辨證要點。 2. 現代運用：本方常用於上呼吸道感染、支氣管炎、百日咳等屬表邪未盡，肺氣失宣者。 3. 注意事項：本方藥性溫潤，以溫為主，故陰虛勞嗽或肺熱咳嗽者，不宜使用","金沸草散《博濟方》旋覆花三兩 (90g) 麻黃去節，三兩 (90g) 前胡三兩 (90g) 荊芥穗四兩 (120g) 炙甘草，一兩 (30g) 半夏洗淨，薑汁浸，一兩 (30g) 赤芍藥一兩 (30g) 上為末，每服二錢 (6g)，水一盞，加生薑、大棗，同煎至六分，熱服。如汗出並三服。功用：發散風寒，降氣化痰。主治：傷風咳嗽。惡寒發熱，咳嗽痰多，鼻塞流涕，舌苔白膩，脈浮","止嗽散內用桔梗，紫菀荊芥百部陳， 白前甘草共為末，薑湯調服止嗽頻")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("7","正柴胡飲","Zheng Chai Hu Yin","Bupleurum Correction Beverage","解表劑","《景嶽全書》","柴胡一至三錢 (9g) 防風一錢 (3g) 陳皮一錢半 (4.5g) 芍藥二錢 (6g) 甘草一錢 (3g) 生薑三至五片","水煎，溫服","解表散寒","外感風寒輕證。微惡風寒，發熱，無汗，頭痛，身痛，舌苔薄白，脈浮","惡寒，發熱，無汗，頭身痛，苔薄，脈浮，為風寒束表之徵象，因感邪較輕，故其症以微惡風寒，發熱為特點。治當解表散寒","","1. 辨證要點：本方為張介賓所創制的平散風寒之代表方。臨床應用以發熱惡寒，頭痛身痛，苔白，脈浮為辨證要點。 2. 現代運用：本方常用感冒、流行性感冒、瘧疾初起以及婦女經期、妊娠、產後感冒等屬外感風寒而氣血不虛者","","正柴胡飲平散方，芍藥防風陳草薑， 輕疏風邪解熱痛，表寒輕證服之康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("8","銀翹散","Yin Qiao San","Lonicera and Forsythia Powder","解表劑","《溫病條辨》","連翹一兩 (30g) 金銀花一兩 (30g) 桔梗六錢 (18g) 薄荷六錢 (18g) 竹葉四錢 (12g) 生甘草五錢 (15g) 荊芥穗四錢 (12g) 淡豆豉五錢 (15g) 牛蒡子六錢 (18g)","煮散，每服18g，入鮮蘆根15g同煎，香氣大出，即取服，勿過煮；亦可作湯劑，水煎服，用量按原方比例酌減","辛涼透表，清熱解毒","溫病初起。發熱，微惡風寒，無汗或有汗不暢，頭痛口渴，咳嗽咽痛，舌尖紅，苔薄白或薄黃，脈浮數","「溫邪上受，首先犯肺。」《外感溫熱篇》溫邪自口鼻而入，上犯於肺，肺衛相通，衛氣被鬱，開合失司，則發熱，微惡風寒，無汗或有汗不暢；肺氣失宣，則咳嗽；肺系不利，則咽痛。溫邪傷津，故口渴。舌尖紅、苔薄白或微黃，脈浮數，均為溫病初起之佐證。本方證之病機為溫病初起，邪鬱肺衛，以邪鬱衛表，邪熱較重為特點，治宜辛涼透表，清熱解毒","","1. 辨證要點：《溫病條辨》稱本方為 「辛涼平劑」，是治療風溫初起之風熱表證的常用方。臨床應用以發熱，微惡寒，咽痛，口渴，脈浮數為辨證要點。 2. 現代運用：本方廣泛用於急性發熱性疾病的初起階段，如感冒、流行性感冒、急性扁桃體炎、上呼吸道感染、肺炎、麻疹、流行性腦膜炎、乙型腦炎、腮腺炎等辨證屬溫病初起，邪鬱肺衛者。皮膚病如濕疹、風疹、蕁麻疹、瘡癰癤腫，亦多用之。 3. 注意事項：凡外感風寒及濕熱病初起者禁用。因方中藥物多為芳香輕宣之品，不宜久煎","","銀翹散主上焦屙，竹葉荊牛豉薄荷， 甘桔蘆根涼解法，清疏風熱煮無過")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("9","桑菊飲","Sang Ju Yin","Mulberry Leaf and Chrysanthemum Beverage","解表劑","《溫病條辨》","桑葉二錢五分 (7.5g) 菊花一錢 (3g) 杏仁二錢 (6g) 連翹一錢五分 (5g) 薄荷八分 (2.5g) 苦桔梗二錢 (6g) 生甘草八分 (2.5g) 蘆根二錢 (6g)","水煎，溫服","疏風清熱，宣肺止咳","風溫初起，表熱輕證。但咳，身熱不甚，口微渴，脈浮數","風溫襲肺，肺氣失宣，故見咳嗽；因受邪輕淺，津傷亦輕，所以身不甚熱，口渴亦微。本方證屬溫病初起，肺失宣肅的表熱輕證，故立疏風清熱，宣肺止咳為法","","1. 辨證要點：本方是主治風熱犯肺之咳嗽證的常用方劑。臨床應用以咳嗽，發熱不甚，微渴，脈浮數為辨證要點。因其為 「辛涼輕劑」，故肺熱甚者，當予加味後運用，否則病重藥輕，藥不勝病；若系風寒咳嗽，不宜使用。 2. 現代運用：本方常用於感冒、急性支氣管炎、上呼吸道感染、肺炎、急性結膜炎、角膜炎等屬風熱犯肺或肝經風熱者。 3. 注意事項：方中藥物均系輕清之品，故不宜久煎","","桑菊飲中桔杏翹，蘆根甘草薄荷饒， 清疏肺衛輕宣劑，風溫咳嗽服之消")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("10","麻黃杏仁甘草石膏湯","Ma Huang Xing Ren Gan Cao Shi Gao Tang","Ephedra/ Apricot Kernel/ Licorice and Gypsum Decoction","解表劑","《傷寒論》","麻黃四兩 (9g) 杏仁五十個 (9g) 炙甘草 二兩 (6g) 石膏半斤 (18g)","水煎，溫服","辛涼疏表，清肺平喘","外感風邪，邪熱壅肺證。身熱不解，咳逆氣急，甚則鼻煽，口渴，有汗或無汗，舌苔薄白或黃，脈浮而數者","本方證是表邪入裏化熱，壅遏於肺，肺失宣降所致。風熱襲表，表邪不解而入裏，或風寒之邪鬱而化熱入裏，邪熱充斥內外，故身熱不解，汗出，口渴，苔黃，脈數；熱壅於肺，肺失宣降，故咳逆氣急，甚則鼻煽；無汗，苔薄白，脈浮是表邪未盡之征。治當辛涼透邪，清肺平喘","","1. 辨證要點：本方為治療表邪未解，邪熱壅肺之喘咳的基礎方。因石膏倍麻黃，其功用重在清宣肺熱，不在發汗，所以臨床應用以發熱，喘咳，苔薄黃，脈數為辨證要點。 2. 現代運用：本方常用於治療感冒、上呼吸道感染、急性支氣管炎、支氣管肺炎、大葉性肺炎、支氣管哮喘、麻疹合併肺炎等屬表證未盡，熱邪壅肺者。 3. 注意事項：風寒咳喘、痰熱壅盛者，本方均非所宜","越婢湯《金匱要略》麻黃六兩 (18g) 石膏半斤 (24g) 生薑三兩 (9g) 甘草二兩 (6g) 大棗十五枚 (5枚) 上五味，以水六升，先煮麻黃，去上沫，內諸藥，煮取三升，分溫三服。功用：發汗利水。主治：風水夾熱證。惡風，一身悉腫，脈浮不渴，續自汗出，無大熱者","傷寒麻杏甘石湯，汗出而喘法度良， 辛涼宣洩能清肺，定喘除熱效力彰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("11","柴葛解肌湯","Chai Ge Jie Ji Tang","Bupleurum and Pueraria Muscle-Resolving Decoction","解表劑","《傷寒六書》","柴胡 (6g) 乾葛 (9g) 甘草 (3g) 黃芩 (6g) 羌活 (3g) 白芷 (3g) 芍藥 (6g) 桔梗 (3g) 石膏 (3g)","水煎，生薑三片，大棗二枚同煎，溫服","解肌清熱","外感風寒，鬱而化熱證。惡寒漸輕，身熱增盛，無汗頭痛，目疼鼻乾，心煩不眠，咽乾耳聾，眼眶痛，舌苔薄黃，脈浮微洪","本方所治證候乃太陽風寒未解，鬱而化熱，漸次傳入陽明，波及少陽之三陽合病。太陽風寒未解，故惡寒，無汗頭痛。陽明經脈起於鼻兩側，上行至鼻根部，經眼眶下行；少陽經脈行於耳後，進入耳中，出於耳前，並行至面頰部，到達眶下部。入裏之熱初犯陽明、少陽，故目疼鼻乾，眼眶痛，咽乾耳聾。脈浮而微洪是外有表邪，裏有熱邪之佐證。治宜辛涼解肌，兼清裏熱","","1. 辨證要點：本方是治療太陽風寒未解，入裏化熱，初犯陽明或三陽合病的常用方。臨床應用以發熱重，惡寒輕，頭痛，眼眶痛，鼻乾，脈浮微洪為辨證要點。 2. 現代運用：本方常用於感冒、流行性感冒、牙齦炎、急性結膜炎等屬外感風寒，邪鬱化熱者。 3. 注意事項：若太陽表邪未入裏者，不宜用本方，恐其引邪入裏；若裏熱而見陽明腑實證 (大便秘結不通) 者，亦不宜用","柴葛解肌湯《醫學心悟》柴胡一錢二分 (6g) 葛根一錢五分 (6g) 黃芩一錢五分 (6g) 赤芍一錢 (6g) 甘草五分 (3g) 知母一錢 (5g) 生地二錢 (9g) 丹皮一錢五分 (3g) 貝母一錢 (6g) 水煎服。心煩加淡竹葉十片 (3g) ；譫語加石膏三錢 (12g)。功用：解肌清熱。主治：外感風熱，裏熱亦盛證。不惡寒而口渴，舌苔黃，脈浮散","陶氏柴葛解肌湯，邪在三陽熱勢張， 芩芍桔甘羌活芷，石膏大棗與生薑")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("12","升麻葛根湯","Sheng Ma Ge Gen Tang","Cimicifuga and Pueraria Decoction","解表劑","《太平惠民和劑局方》","升麻 芍藥 炙甘草 各十兩 (300g) 葛根十五兩 (450g)","煮散劑，每服9g，溫服，不拘時候，以病氣去，身清涼為度；亦可作湯劑，水煎服/ 用量按原方比例酌減","解肌透疹","麻疹初起。疹發不出，身熱頭痛，咳嗽，目赤流淚，口渴，舌紅，苔薄而乾，脈浮數","麻疹之疾，是由小兒肺胃蘊熱，又感時疫之邪所致。初起調護失慎，感受外邪，肌表閉鬱，以致疹發不出，或疹出不暢。肺胃本有蘊熱，又遇外邪襲表，邪正相爭，肺失清肅，故初起可見肺衛症狀：如身熱頭痛、咳嗽、目赤流淚、脈浮數等；熱灼津傷，則口渴，舌紅苔乾。麻疹以外出為順，內陷為逆。麻疹初起，疹發不出，治當因勢利導助其透發；已有蘊熱，又宜清熱解毒，兩相兼顧","關於方中芍藥的選擇：方中芍藥，原書未標明是赤芍或是白芍，因宋時芍藥尚未分赤白。多數醫家注解本方時，雖言芍藥，但多按白芍之義分析，如汪昂、王泰林、費伯雄等，亦有言芍藥而按赤芍之義分析者，如吳昆等。本方之芍藥究竟用赤芍為宜，還是白芍為妥？基於赤芍性味苦寒入血，清熱涼血而又活血，可清解血絡熱毒，有利於透疹解毒；而白芍的酸收，不利於麻疹的透發。我們認為，治麻疹及其他發疹性疾病，以赤芍為宜；治痢疾既可赤、白合用，也可單用白芍或赤芍，用白芍取其緩急止痛之功，用赤芍取其涼血活血之效","1. 辨證要點：本方為麻疹未發，或發而不透的基礎方。臨床應用以疹發不出或出而不暢，舌紅，脈數為辨證要點。 2. 現代運用：本方除用治麻疹外，亦治帶狀皰疹、單純性皰疹、水痘、腹瀉、急性細菌性痢疾等病屬邪鬱肌表，肺胃有熱者。 3. 注意事項：若麻疹已透，或疹毒內陷而見氣急而粗，喘息抬肩，鼻翼煽動者，則當禁用","竹葉柳蒡湯《先醒齋醫學廣筆記》西河柳五錢 (15g) 荊芥穗一錢 (3g) 乾葛一錢五分 (4.5g) 蟬蛻一錢 (3g) 薄荷葉一錢 (3g) 鼠粘子炒，研，一錢五分 (4.5g) 知母蜜炙，一錢 (3g) 玄參二錢 (6g) 甘草一錢 (3g) 麥門冬去心，三錢 (9g) 竹葉三十片 (3g) (甚者加石膏五錢 冬米一撮) 水煎服。功用：透疹解表，清熱生津。主治：痧疹初起，透發不出。喘嗽，鼻塞流涕，惡寒輕，發熱重，煩悶躁亂，咽喉腫痛，唇乾口渴，苔薄黃而乾，脈浮數","閻氏升麻葛根湯，芍藥甘草合成方， 麻疹初期發不透，解肌透疹此為良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("13","敗毒散","Bai Du San","Toxin-Resolving Powder","解表劑","《太平惠民和劑局方》","柴胡 前胡 川芎 枳殼 羌活 獨活 茯苓 桔梗 人參 甘草 各三十兩 (900g)","煮散劑，每服6g，加生薑、薄荷各1g同煎，不拘時服，寒多則熱服，熱多則溫服；亦作湯劑煎服，用量按原方比例酌減","散寒祛濕，益氣解表","氣虛外感風寒濕表證。憎寒壯熱，頭項強痛，肢體痛，無汗，鼻塞聲重，咳嗽有痰，胸膈痞滿，舌淡苔白，脈浮而按之無力","本方所治證候系正氣素虛，又感風寒濕邪。憎寒壯熱，頭項強痛，肢體酸痛，無汗，是風寒濕邪，襲於肌表，客於經絡之征。鼻塞聲重，咳嗽有痰，胸膈痞悶，為風寒犯肺，肺系不利，肺氣不宣，津聚為痰，痰阻氣滯之候。舌苔白膩，脈浮按之無力，正是虛人外感風寒兼濕之佐證。治當散寒祛濕，益氣解表","1. 關於人參的配伍：素體氣虛而外感，若只祛邪而不扶正，不僅無力鼓邪外出，即使表邪暫解，亦恐正氣不足而邪氣復入；另外，正氣虛弱之人感受外邪，若單純以解表藥汗之，藥雖外行，而中氣不足，輕則汗半出不出，外邪仍不能解；重則外邪反乘元氣之虛而入裏，以致發熱無休，病情纏綿難愈。故於祛風散寒藥中佐少量的人參益氣以扶其正，一則扶助正氣以驅邪外出，並寓防邪入裏之義，二則散中有補，不致耗傷真元。 2. 關於 「逆流挽舟」：喻嘉言常用本方治外邪陷裏而成痢疾者，後人稱之為 「逆流挽舟」 法。痢疾之成，多因濕熱疫毒，壅滯腸道，其病勢向內向下，治宜因勢利導，當清熱化濕解毒，兼以調氣和血導滯，此乃治痢之常法，而 「逆流挽舟」 法是治痢的變法。本法所治痢疾，由表邪內陷於裏，腸道壅滯，氣血失調而成。此時病勢雖向內向下，但導致腸道壅滯的根本原因是表邪內陷，不宜順其病勢而用常法，只宜採取逆其病勢的解表法治之。故 「逆」 者，逆其病勢、逆其常法也。應用解表藥物，使內陷之外邪從表而解，宛如逆流之中挽舟上行，故稱 「逆流挽舟」 法。從病勢來看，實屬 「逆挽」，但從病因、病機分析，則屬 「順推」，二者反映了本質與現象的關係","1. 辨證要點：本方是一首益氣解表的常用方。臨床應用以憎寒壯熱，肢體酸痛，無汗，脈浮按之無力為辨證要點。 2. 現代運用：本方常用於感冒、流行性感冒、支氣管炎、風濕性關節炎、痢疾、過敏性皮炎、濕疹等屬外感風寒濕邪兼氣虛者。 3. 注意事項：方中藥物多為辛溫香燥之品，外感風熱及陰虛外感者，均忌用。若時疫、濕溫、濕熱蘊結腸中而成之痢疾，切不可用","1. 荊防敗毒散《攝生眾妙方》羌活 柴胡 前胡 獨活 枳殼 茯苓 荊芥 防風 桔梗 川芎各一錢五分 (4.5g) 甘草五分 (1.5g) 用水一盅半，煎至八分，溫服。功用：發汗解表，消瘡止痛。主治：瘡腫初起。紅腫疼痛，惡寒發熱，無汗不渴，舌苔薄白，脈浮數。 2. 倉廩散《普濟方》人參 茯苓 甘草 前胡 川芎 羌活 獨活 桔梗 枳殼 柴胡 陳倉米各等分 (9g) 加生薑、薄荷煎，熱服。功用：益氣解表，祛濕和胃。主治：噤口痢，下痢，嘔逆不食，食入則吐，惡寒發熱，無汗，肢體痛，苔白膩，脈浮濡","人參敗毒茯苓草，枳桔柴前羌獨芎， 薄荷少許薑三片，時行感冒有奇功")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("14","參蘇飲","Shen Su Yin","Ginseng and Perilla Beverage","解表劑","《太平惠民和劑局方》","人參 紫蘇葉 乾葛 半夏 前胡 茯苓 各三分 (6g) 枳殼 桔梗 木香 陳皮 炙甘草 各半兩 (4g)","加生薑七片，大棗一個，水煎，溫服，不拘時候","益氣解表，理氣化痰","氣虛外感風寒，內有痰濕證。惡寒發熱，無汗，頭痛，鼻塞，咳嗽痰白，胸脘滿悶，倦怠無力，氣短懶言，舌苔白，脈弱","本方證由素體脾肺氣虛，內有痰濕，復感風寒而成。風寒客於肌表，肺系不利，故見惡寒發熱，無汗頭痛，鼻塞；痰濕壅肺，阻滯氣機，故咳嗽痰白，胸脘滿悶。倦怠無力，氣短懶言，脈浮是氣虛外感之征。治當益氣解表，理氣化痰","","1. 辨證要點：本方為治氣虛外感風寒，內有痰濕證的常用方。臨床應用以惡寒發熱，無汗頭痛，咳痰色白，胸脘滿悶，倦怠乏力，苔白，脈弱為辨證要點。 2. 現代運用：本方常用來治療感冒、上呼吸道感染等屬氣虛外感風寒兼有痰濕者","","參蘇飲內用陳皮，枳殼前胡半夏齊， 乾葛木香甘桔茯，氣虛外感最相宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("15","麻黃細辛附子湯","Ma Huang Fu Zi Xi Xin Tang","Ephedra/ Aconite and Asarum Decoction","解表劑","《傷寒論》","麻黃二兩 (6g) 附子炮 一枚 破八片 (9g) 細辛二兩 (3g)","水煎，溫服","助陽解表","1. 素體陽虛，外感風寒證。發熱，惡寒甚劇，雖厚衣重被，其寒不解，神疲欲寐，脈沉微。 2. 暴啞。突發聲音嘶啞，甚至失音不語，或咽喉疼痛，惡寒，發熱，神疲欲寐，舌淡苔白，脈沉無力","本方是為素體陽虛，復感風寒的證候而設。發熱，並見惡寒甚劇，雖厚衣重被，其寒不解，是外受風寒，邪正相爭所致；脈沉無力，兼見神疲欲寐，素體陽虛之候。治當助陽與解表並行","1. 關於麻黃與附子配伍：外感表證，治應汗解，但因陽虛不能鼓邪外出，且慮已虛之陽隨汗而泄，恐有亡陽之變，必須助陽與解表結合運用，方能祛邪而不傷正，扶正而不礙邪。方中麻黃行表以開泄皮毛，逐邪於外；附子在裏以振奮陽氣，鼓邪於外，二藥配合，相輔相成。麻黃為發汗之峻品，凡陽虛之人用之則易損氣耗陽，附子不僅能助陽鼓邪外出，且可固護陽氣，相伍則無過汗亡陽之虞，故為助陽解表的常用組合。 2. 關於本方治暴啞之理：喉為肺系之門戶，少陰腎經循喉嚨，至舌根。若為暴啞，乃大寒直犯肺腎，上窒竅隧，下閉腎氣所致。方中麻黃散寒宣肺；附子溫壯腎陽；細辛協二藥辛通上下，三藥合用則具宣上溫下，開竅啟閉之功。此為以表裏同治之方，易作上下同治之法，乃靈活運用，異病同治之體現","1. 辨證要點：本方既是主治少陰陽虛，外感風寒的代表方、基礎方，又是治療大寒客犯肺腎所致咽痛聲啞的常用方。臨床應用以惡寒甚，發熱輕，神疲欲寐，脈沉為辨證要點。 2. 現代運用：本方常用於感冒、流行性感冒、支氣管炎、病竇綜合征、風濕性關節炎、過敏性鼻炎、暴盲、暴喑、喉痹、皮膚瘙癢等屬陽虛外感者。 3. 注意事項：若少陰陽虛而見下利清穀，四肢厥逆，脈微欲絕等症，則應遵仲景 「先溫其裏，乃攻其表」 的原則，否則誤發其汗，必致亡陽危候，不可不慎","1. 麻黃附子甘草湯《傷寒論》麻黃去節，二兩 (6g) 炙甘草，二兩 (6g) 附子炮，去皮，一枚，破八片 (9g) 上三味，以水七升，先煮麻黃一兩沸，去上沫，內諸藥，煮取三升，去滓。溫服一升，日三服。功用：助陽解表。主治：少陰陽虛，外感風寒。惡寒身疼，無汗，微發熱，脈沉微者，或水病身面浮腫，氣短，小便不利，脈沉而小。 2. 再造散《傷寒六書》卷3 黃芪 (6g) 人參 (3g) 桂枝 (3g) 甘草 (1.5g) 熟附子 (3g) 細辛 (2g) 羌活 (3g) 防風 (3g) 川芎 (3g) 煨生薑 (3g) 水二盅，加大棗二個，煎一盅。槌法再加炒白芍一撮，煎三沸，溫服。功用：助陽益氣，解表散寒。主治： 陽氣虛弱，外感風寒證。惡寒發熱，熱輕寒重，無汗肢冷，倦怠嗜臥，面色蒼白，語聲低微，舌淡苔白，脈沉無力或浮大無力","麻黃附子細辛湯，助陽解表法優良， 少陰脈沉反發熱，邪寒外解不傷陽")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("16","加減葳蕤湯","Jia Jian Wei Rui Tang","Solomon\'s Seal Variant Decoction","解表劑","《通俗傷寒論》","生葳蕤 (玉竹) 二至三錢 (9g) 生蔥白二至三枚 (6g) 桔梗一錢至錢半 (4.5g) 東白薇五分至一錢 (3g) 淡豆豉三至四錢 (12g) 蘇薄荷一錢至錢半 (4.5g) 炙甘草五分 (1.5g) 紅棗二枚","水煎，溫服","滋陰解表","陰虛外感風熱證。頭痛身熱，微惡風寒，無汗或有汗不多，咳嗽，心煩，口渴，咽乾，舌紅，脈數","本方主治陰虛之體外感風熱者。外感風熱，故見頭痛身熱，微惡風寒，無汗或有汗不暢，咳嗽，口渴等症。陰虛之體，感受外邪，易於熱化，且陰虛者亦多生內熱，故除上述邪襲肺衛的見症外，尚有咽乾，心煩，舌赤，脈數之症。治當辛涼解表，滋陰清熱","","1. 辨證要點：本方專為素體陰虛，感受風熱之證而設。臨床應用以身熱微寒，咽乾口燥，舌紅，苔薄白，脈數為辨證要點。本方是滋陰解表之劑，若無陰虛證候則不宜使用，否則表邪留連難去。 2. 現代運用：本方常用於治療老年人及產後感冒、急性扁桃體炎、咽炎等屬陰虛外感者","蔥白七味飲《外臺秘要》蔥白連根切，一升 (9g) 乾葛切，六合 (9g) 新豉綿裹，一合 (6g) 生薑切，二合 (6g) 生麥門冬去心，六合 (9g) 乾地黃六合 (9g) 勞水八升，以杓揚之一千過。上藥用勞水煎之三分減二，去渣，分三次溫服，相去行八九裏。如覺欲汗，漸漸覆之。功用：養血解表。主治：血虛外感風寒證。病後陰血虧虛，調攝不慎，感受外邪。或失血 (吐血、便血、咳血、衄血) 之後，感冒風寒，頭痛身熱，微寒無汗","加減葳蕤用白薇，豆豉生薑桔梗隨， 草棗薄荷共八味，滋陰發汗功可慰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("17","大承氣湯","Da Cheng Qi Tang","Major Purgative Decoction","瀉下劑","《傷寒論》","大黄四两 (12g) 厚朴半斤 (24g) 枳实五枚 (12g) 芒硝三合 (9g)","水煎服。先煎厚樸、枳實，後下大黃，芒硝溶服。分2次溫服，以利為度","峻下熱結","1. 陽明腑實證。大便不通，頻轉矢氣，脘腹痞滿，腹痛拒按，按之則硬，甚或潮熱譫語，手足濈然汗出，舌苔黃燥起刺，甚或焦黑燥裂，脈沉實。 2. 熱結旁流證。下利清水，色純青，其氣臭穢，臍腹疼痛，按之堅硬有塊，口舌乾燥，脈滑實。 3. 裏熱實證之熱厥、痙病或發狂等","本方證的病機為陽明熱盛，灼傷津液，燥屎形成，邪熱與燥屎互結成實，腑氣不通。其病機特點可歸納為 「痞、滿、燥、實」 四字。「痞」，即胸脘悶塞不通，有重壓感；「滿」，指脘腹脹滿，按之有抵抗感；「燥」，指腸中有燥屎，乾結難下；「實」，是實熱內結，腹痛拒按，大便不通，或雖然下利清水而腹滿痛不減，以及潮熱譫語，脈實等。或氣機阻滯，陽氣被遏，不能達於四肢而為熱厥；或熱盛傷津，筋脈失養而攣急，而發為痙病；或陽明邪熱上擾心神，神明昏亂而發狂。症候表現雖然各異，然而其病機則同，皆是熱結裏實之重證，治當峻下熱結，釜底抽薪，以存陰液","1. 本方治熱結旁流，下利清水，為何還用大承氣湯攻下？本證之下利清水，是因燥屎堅結於裏，胃腸欲排出而不能，逼迫腸中津液從燥屎之旁流下。雖然見下利，但其氣味臭穢，伴臍腹疼痛，按之堅硬有塊。可見下利是假像，燥屎堅結才是真情。因此，當用大承氣湯攻下，使胃腸燥屎得去，則下利可止，是 「通因通用」 之法。 2. 本方治熱厥的機理：是因四肢厥逆是假像，熱結裏實是本質，所謂 「熱深者，厥亦深」。四肢雖厥冷，但必見大便秘結，腹痛拒按，口乾舌燥，脈滑實等熱結裏實之症候。用本方峻下，使熱結得下，氣機宣暢，陽氣敷布外達，則四肢自溫。這種用寒下之法治厥冷之證，亦稱為 「寒因寒用」。 3. 本方治痙病，為何不配伍涼肝熄風，滋陰舒筋之品？因本所治之痙病，是由實熱內結，胃腸熱盛，灼傷津液，筋脈失養而攣急所致，但必見大便秘結，口乾舌燥，脈滑數實等實熱證候，用本方急下存陰，使熱去津回，筋脈得養，則痙厥可止，是治本之法。 4. 關於大黃生用、後下的意義：本方之旨在於峻下，大黃生用、後下則瀉下之力峻，熟用、久煎則瀉下之力緩","1. 辨證要點：本方為治療陽明腑實證的基礎方，又是寒下法的代表方。臨床應用以痞、滿、燥、實四證及舌紅苔黃、脈沉實為辨證要點。 2. 現代運用：本方常用於急性單純性腸梗阻、粘連性腸梗阻、蛔蟲性腸梗阻、急性膽囊炎、急性胰腺炎、幽門不完全性梗阻等屬於陽明腑實，以及某些熱性病過程中出現的高熱、神昏或者譫語、驚厥、發狂而見大便不通，苔黃脈實者。 3. 注意事項：凡氣虛陰虧，燥結不甚，以及年老、體弱等均應慎用；孕婦禁用；並注意中病即止，不宜過劑，以免傷正","1. 小承氣湯《傷寒論》大黃酒洗，四兩 (12g) 厚樸去皮，炙，二兩 (6g) 枳實炙，三枚大者 (9g) 以水四升，煮取一升二合，去滓，分溫二服。初服當更衣，不爾者，盡飲之。若更衣者，勿服之。功用：輕下熱結。主治：陽明腑實輕證。譫語，潮熱，大便秘結，胸腹痞滿，舌苔老黃，脈滑而疾；或痢疾初起，腹中脹痛，裏急後重者。 2. 謂胃承氣湯《傷寒論》大黃去皮，清酒洗，四兩 (12g) 炙甘草，二兩 (6g) 芒硝半升 (9g) 以水三升，煮二物至一升，去滓，內芒硝，更上微火一二沸，溫頓服之，以調胃氣。功用：緩下熱結。主治：陽明病胃腸燥熱證。大便不通，口渴心煩，蒸蒸發熱，或腹中脹滿，或為譫語，舌苔正黃，脈滑數；以及胃腸熱盛而致發斑吐衄，口齒咽喉腫痛等。 3. 複方大承氣湯《中西醫結合治療急腹症》厚樸 (15~20g) 炒萊菔子 (15~30g) 枳殼 (15g) 桃仁 (9g) 赤芍 (15g) 大黃後下 (9~15g) 芒硝沖服 (9~15g) 水煎服。最好用胃管注入，經2~3小時後，可再用本方灌腸，以加強攻下之力，有助於梗阻之解除。功用：通裏攻下，行氣活血。主治：單純性腸梗阻，屬於陽明腑實而氣脹較明顯者","大承氣湯用硝黃，配以枳樸瀉力強， 陽明腑實真陰灼，急下存陰第一方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("18","大黃牡丹湯","Da Huang Mu Dan Tang","Rhubarb and Cortex Moutan Decoction","瀉下劑","《金匱要略》","大黃四兩 (12g) 牡丹一兩 (3g) 桃仁五十個 (9g) 冬瓜仁半升 (30g) 芒硝三合 (9g)","水煎服，芒硝溶服","瀉熱破瘀，散結消腫","腸癰初起，濕熱瘀滯證。右少腹疼痛拒按，按之其痛如淋，甚則局部腫痞，或右足屈而不伸，伸則痛劇，小便自調，或時時發熱，自汗惡寒，舌苔薄膩而黃，脈滑數","本方所治之腸癰為濕熱與氣血互結而成。右少腹疼痛拒按，甚或腫痞，是濕熱瘀滯，腸絡不通。喜屈右足而不伸，伸則痛劇，為縮腳腸癰。按之痛如淋，而小便自調，是與淋證的鑒別。或時時發熱，自汗惡寒，是腸癰已成，氣血鬱滯，營衛不和使然。舌苔黃膩，脈滑數，是濕熱之征。濕熱瘀滯之腸癰，治當瀉熱利濕，破瘀消癰","1. 本方治腸癰為何用下法？本方所治之腸癰，是因濕熱瘀滯腸中成實所致。腸為六腑之一，六腑以通為用，不通則痛，通則不痛；治病務使邪有出路，而腸腑之實邪，必從大便而去。故用硝、黃，瀉熱通便，既使濕熱瘀毒從大便速下，又使腸腑通暢，通則不痛。 2. 關於本方適用於腸癰的哪個階段？《金匱要略》中曾說：「脈洪大者，膿已成，不可下也」。但在本方的用法中又說：「有膿當下，如無膿當下血」。以致後世醫家對此認識不一，但現在一般認為腸癰屬濕熱瘀滯之實證者，膿未成或膿已成而未潰，均可用之","1. 辨證要點：本方為治療濕熱血瘀腸癰的常用方。臨床應用以右下腹疼痛拒按，舌苔黃膩，脈滑數為辨證要點。 2. 現代運用：本方常用於急性單純性闌尾炎、腸梗阻、急性膽道感染、膽道蛔蟲、胰腺炎、急性盆腔炎、輸卵管結紮後感染等屬濕熱瘀滯者。 3. 注意事項：凡腸癰潰後以及老人、孕婦、產後或體質過於虛弱者均應慎用或忌用","1. 清腸飲《辨證錄》銀花三兩 (90g) 當歸二兩 (60g) 地榆一兩 (30g) 麥冬一兩 (30g) 玄參一兩 (30g) 生甘草三錢 (9g) 薏仁五錢 (15g) 黃芩二錢 (6g) 水煎服。功用：活血解毒，滋陰瀉火。主治：大腸癰。 2. 闌尾化瘀湯《新急腹證學》銀花 川楝子 (各15g) 大黃後下 牡丹皮 桃仁 延胡索 木香 (各9g) 水煎服。功用：行氣活血，清熱解毒。主治：瘀滯型闌尾炎初期。發熱，脘腹脹悶，腹痛，右下腹局限性壓痛，反跳痛；或闌尾炎症消散後，熱象不顯著，而見脘腹脹悶，噯氣納呆。 3. 闌尾清化湯《新急腹證學》銀花 蒲公英 牡丹皮 大黃 川楝子 赤芍 桃仁 生甘草 水煎服。功用：清熱解毒，行氣活血。主治：急性闌尾炎蘊熱期，或膿腫早期，或輕型腹膜炎。見低熱，或午後發熱，口乾渴，腹痛，便秘，尿黃。 4. 闌尾清解湯《新急腹證學》金銀花 (60g) 大黃 (25g) 冬瓜仁 蒲公英 (各30g) 牡丹皮 (15g) 川楝子 生甘草 (各10g) 木香 (6g) 水煎服。功用：清熱解毒，攻下散結，行氣活血。主治：急性闌尾炎熱毒期。發熱惡寒，面紅目赤，唇乾舌燥，口渴欲飲，噁心嘔吐，腹痛拒按，腹肌緊張，有反跳痛，大便秘結，舌質紅，苔黃燥或黃膩，脈洪大滑數","金匱大黃牡丹湯，桃仁瓜子芒硝襄， 腸癰初起腹按痛，苔黃脈數服之康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("19","大陷胸湯","Da Xian Xiong Tang","Major Chest Draining Decoction","瀉下劑","《傷寒論》","大黃六兩 (10g) 芒硝一升 (10g) 甘遂一錢匕 (1g)","水煎服。先煮大黃，芒硝溶，沖甘遂末服","瀉熱逐水","水熱互結之結胸。心下疼痛，拒按，按之硬，或從心下至少腹硬滿疼痛，手不可近。伴見短氣躁煩，大便秘結，舌上燥而渴，日晡小有潮熱，舌紅，苔黃膩或兼水滑，脈沉緊或沉遲有力","本證的病機為邪熱與水飲互結成實。水熱互結，壅塞不通，故見心下硬滿而痛，拒按，甚則從心下至少腹硬滿而痛，手不可近；水熱結實，胃腸阻滯，則大便秘結，日晡小有潮熱，或短氣煩燥；水熱互結，津液不得上承，則舌燥口渴；舌紅，苔黃膩，脈沉緊，按之有力，為水熱結實於裏之征。水熱結實於裏之證，治當瀉熱逐水","大黃先煎的意義：本證之病位偏上，在胸脘。大黃先煮，意在減緩其瀉下之力，乃取其 「治上者治宜緩」 之意","1. 辨證要點：本方為治療大結胸證的常用方。臨床應用以心下硬滿，疼痛拒按，便秘，舌燥，苔黃，脈沉有力為辨證要點。 2. 現代運用：本方常用於急性胰腺炎、急性腸梗阻、肝膿瘍、滲出性胸膜炎、膽囊炎、膽石症等屬於水熱互結者。 3. 注意事項：凡平素虛弱，或病後不任攻伐者，均應禁用。且應中病即止，以免過劑傷正","","大陷胸湯用硝黃，甘遂為末共成方， 專治熱實結胸證，瀉熱逐水效非常")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("20","大黃附子湯","Da Huang Fu Zi Tang","Rhubarb and Aconite Decoction","瀉下劑","《金匱要略》","大黃三兩 (9g) 炮附子三枚 (12g) 細辛二兩 (3g)","水煎服","溫裏散寒，通便止痛","寒積裏實證。腹痛便秘，脅下偏痛，發熱，手足厥冷，舌苔白膩，脈弦緊","本方證的病機為陰寒與積滯互結於腸道成實。陰寒盛於裏，陽氣失於溫通，氣血被阻，故見腹痛或脅下偏痛，手足厥冷：寒積阻於腸道，腑氣不通，則大便秘結。舌苔白膩，脈弦緊為寒實之佐證。寒積結實於裏，治當溫裏散寒，通便攻積","治寒積裏實證，方中為何用苦寒之大黃？大黃雖為苦寒之品，但本方仍不失其溫下之法。因與大辛大熱之附子配伍，且附子之用量大，為《傷寒論》中用量之最，又有細辛為助，大黃之寒性已被制約，取其瀉下攻積之功，是 「去性取用」 之配伍","1. 辨證要點：本方為溫下法的代表方，又是治療冷積便秘實證的常用方。臨床應用以腹痛便秘，手足不溫，苔白膩，脈弦緊為辨證要點。 2. 現代運用：本方常用於急性闌尾炎、急性腸梗阻、睾丸腫痛、膽絞痛、膽囊術後綜合征、慢性痢疾以及尿毒癥等屬寒積裏實者。 3. 注意事項：熱結裏實證忌用。且大黃用量不宜超過附子","","大黃附子細辛湯，脅下寒凝疝痛方， 冷積內結成實證，溫下寒實可復康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("21","溫脾湯","Wen Pi Tang","Spleen-Warming Decoction","瀉下劑","《備急千金要方》","大黃五兩 (15g) 當歸 乾薑各三兩 (各9g) 附子人參 芒硝 甘草各二兩 (各6g)","水煎服","攻下冷積，溫補脾陽","陽虛寒積證。腹痛便秘，臍下絞結，繞臍不止，手足不溫，苔白不渴，脈沉弦而遲","本證病機為脾陽不足，寒積內阻。大便秘結，臍腹絞痛，為寒實冷積阻於腸中，腑氣不通；手足不溫，神疲乏力，為脾陽不足，失於溫養。苔白不渴，脈沉弦而遲，是陽虛寒積之佐證。治當攻下寒積，溫補脾陽","","1. 辨證要點：本方為治療脾陽不足，寒積內停的常用方。臨床應用以腹痛，便秘，手足不溫，苔白，脈沉弦為辨證要點。 2. 現代運用: 常用於急性單純性腸梗阻或不全性梗阻，以及尿毒癥等屬中陽虛寒，寒積內停者。 3. 注意事項：熱結裏實及陰虛血少之便秘忌用","","溫脾附子大黃硝，當歸乾薑人參草， 攻下寒積溫脾陽，陽虛寒積腹痛療")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("22","麻子仁丸 (脾約丸)","Ma Zi Ren Wan (Pi Yue Wan)","Cannabis Fruit Pill (Spleen Confinement Pill)","瀉下劑","《傷寒論》","麻子仁二升 (500g) 芍藥半斤 (250g) 枳實半斤 (250g) 大黃一斤 (500g) 厚樸一尺 (250g) 杏仁一升 (250g)","上為末，為蜜丸劑，每次9g，每日1~2次，溫開水送服。亦可水煎服，按原方用量比例酌減，沖蜂蜜服","潤腸泄熱，行氣通便","胃腸燥熱，“脾約”便秘證。大便乾結，小便頻數，舌紅，苔微黃少津，脈數","本方證的病機為胃腸燥熱，脾陰不足，《傷寒論》稱之為 「脾約」。「約」 者，約結、約束之意。脾主為胃行其津液，轉輸上下，以灌輸四旁。今腸胃燥熱，脾陰不足，脾土過燥，不能為胃行其津液，約束津液不能四布，但輸膀胱，則小便頻數；腸失潤降，則大便乾結。舌紅苔黃少津，脈數，為胃腸燥熱，津液不足之征。治當潤腸泄熱通便","1. 方中用杏仁宣降肺氣的意義：肺與大腸相表裏，腸腑的通降，有賴於肺氣的宣降。肺氣宣降，則腸腑通降，大便易行，為宣肺降氣通腑之法。 2. 本方劑型與服法：本證雖有胃腸燥熱，但病情輕緩，且無脘腹痞滿脹痛等大實之證，只宜潤下緩攻，蜜丸劑最為適宜。既取蜂蜜甘潤緩和，又取 「丸者緩也」。且原服法中每次只服如梧桐子大的小丸10丸，日服3次，不效才逐漸加量，以大便通利為度，亦在於緩下潤腸通便","1. 辨證要點：本方為治療胃腸燥熱，脾津不足之 「脾約」 證的常用方，又是潤下法的代表方。臨床應用以大便乾結，小便頻數，舌苔微黃少津為辨證要點。 2. 現代運用：常用於虛人及老人腸燥便秘、習慣性便秘、產後便秘、痔瘡術後便秘等屬胃腸燥熱津虧者。 3. 注意事項：年老體虛、津虧血少、或脾胃虛弱等而無燥熱者，不宜服用，孕婦慎用","五仁丸《世醫得效方》桃仁 杏仁 麩炒，去皮尖，各一兩 (各30g) 松子仁一錢二分半 (5g) 柏子仁半兩 (15g) 鬱李仁一錢 (3g) 陳皮另研末，四兩 (120g) 將五仁別研為膏，入陳皮末同研勻，煉蜜為丸，如梧桐子大，每服五十丸 (9g)，食前米飲下。現代用法：五仁研為膏，陳皮為末，煉蜜為丸，每服9g，每日1~2次溫開水送下。功用：潤腸通便。主治：津枯腸燥證。大便艱難，以及年老和產後血虛便秘。舌燥少津，脈細澀","麻子仁丸治脾約，枳樸大黃麻杏芍， 土燥津枯便難解，腸潤熱瀉諸症卻")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("23","濟川煎","Ji Chuan Jian","Fluid-Replenishing Decoction","瀉下劑","《景嶽全書》","當歸三至五錢 (9~15g) 牛膝二錢 (6g) 肉蓯蓉二至三錢 (6~9g) 澤瀉一錢半 (4.5g) 升麻五分至七分或一錢 (1.5~3g) 枳殼一錢 (3g)","水煎服","溫腎益精，潤腸通便","腎陽虛衰，精虧血少證。大便秘結，小便清長，腰膝酸軟，頭目眩暈，舌淡苔白，脈沉遲無力","本證之便秘之病機為腎陽虛弱，精虧血少，開合失職。腎主五液，開竅於二陰而司二便。腎陽不足，氣化失司，津液不布，膀胱失約，則小便清長；津液不布於大腸，且精血不足，腸失潤降，故大便秘結難解。腰膝酸軟，頭目眩暈，舌淡苔白，脈象沉遲或沉細，為腎陽不足，精虧血少之佐證。治當溫腎益精，潤腸通便","","1. 辨證要點：本方為治療腎虛精虧便秘的常用方。臨床應用以大便秘結，小便清長，腰膝酸軟，舌淡苔白，脈沉遲無力為辨證要點。 2. 現代運用：本方常用於習慣性便秘、老年便秘、產後便秘等屬於腎虛精虧者。 3. 注意事項：凡熱邪傷津及陰虛便秘均不宜用","","濟川歸膝肉蓯蓉，澤瀉升麻枳殼從， 腎虛津虧腸中燥，寓通於補法堪宗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("24","十棗湯","Shi Zao Tang","Ten Jujubes Decoction","瀉下劑","《傷寒論》","芫花 甘遂 大戟各等分","作散劑，裝入膠囊，每服0.5~1g，每日1次，以大棗10枚煎湯送服，清晨空腹服下。得快下利後，糜粥自養","攻逐水飲","1. 懸飲。咳唾胸脅引痛，心下痞硬脹滿，乾嘔短氣，頭痛目眩，或胸背掣痛不得息，舌苔滑，脈沉弦。 2. 水腫。一身悉腫，尤以身半以下為重，腹脹喘滿，二便不利","本方所治懸飲或水腫，病機為水飲壅盛，結實於裏。水飲停聚胸脅，氣機阻滯，則胸脅疼痛，或咳唾時牽引胸脅作痛，甚或胸背牽引疼痛不敢深呼吸；水飲迫肺，肺氣不利，則短氣咳唾；水飲停留心下，氣結於中，胃失和降，則心下硬滿，乾嘔；飲邪阻遏清陽，清陽不升，則頭痛目眩。水飲外溢肌膚，內壅臟腑，氣機不暢，三焦阻滯，則一身都腫，腹脹喘滿，二便不利。苔白滑，脈沉弦，為水飲結聚於裏之征。此證非一般化飲利水之法所能及，當攻逐水飲，使之速去","","1. 辨證要點：本方為峻下逐水的代表方，又是治療懸飲及水腫實證的常用方。臨床應用以咳唾胸脅引痛，或水腫腹脹，二便不利，脈沉弦為辨證要點。 2. 現代運用：本方常用於滲出性胸膜炎、結核性胸膜炎、肝硬化、慢性腎炎所致的胸水、腹水或全身水腫，以及晚期血吸蟲病所致的腹水等屬於水飲內停裏實者。 3. 注意事項：一是方中大戟、甘遂、芫花宜用散劑，不宜煎湯去渣服用。二是宜清晨空腹服，每日1次，不可多服，且只宜暫用，不可久服；而且還應從小劑量開始，若服後下少，水飲不去，則逐漸增加劑量，最大量一般不超過3g。三是服藥得快利後，宜食糜粥以養胃氣。四是本方只宜於正盛邪實者，年老體弱者慎用；若正虛邪實，非攻不足以去其水，可以用本方與益氣健脾和胃之劑交替使用，或先補後攻，或先攻後補，但虛證水腫及孕婦忌用","控涎丹 (又名妙應丸、子龍丸。《三因極一病證方論》卷13) 甘遂去心 紫大戟 白芥子各等分 上藥為末，煮糊丸如梧桐子大，曬乾。食後，臨臥，淡薑湯或熟水下五七丸至十丸。如痰猛氣實，加丸數不妨 (現代用法：共為細末，水泛為丸，如綠豆大。每服1~3g，晨起以溫開水送服)。功用：祛痰逐飲。主治：痰伏胸膈證。忽然胸背、頸項、胯隱痛不可忍，筋骨牽引釣痛，走易不定，或手足冷痹，或令頭痛不可忍，或神志昏倦多睡，或飲食無味，痰唾稠粘，夜間喉中痰鳴，多流涎唾等證。現常用於治療頸淋巴結核、淋巴腺炎、胸腔積液、腹水、精神病、關節痛及慢性支氣管炎、哮喘等屬痰涎水飲內停胸膈者","十棗逐水效堪誇，大戟甘遂與芫花， 懸飲內停胸脅痛，水腫腹脹用無差")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("25","黃龍湯","Huang Long Tang","Yellow Dragon Decoction","瀉下劑","《傷寒六書》","大黃 (9g) 芒硝 (12g) 枳實 (6g) 厚樸 (3g) 當歸 (9g) 人參 (6g) 甘草 (3g) (原書未著用量)","水煎服。加桔梗3g，生薑3片，大棗2枚，芒硝溶服","攻下通便，補氣養血","陽明腑實，氣血不足證。自利清水，色純青，或大便秘結，脘腹脹滿，腹痛拒按，譫語，身熱口渴，神疲少氣，譫語，甚則循衣摸床，撮空理線，神昏肢厥，舌苔焦黃或焦黑，脈虛","本方證因邪熱與燥屎內結，腑氣不通，氣血不足所致。邪熱入裏，與腸中燥屎互結，腑氣不通，故大便秘結，脘腹脹滿，疼痛拒按，身熱口渴，舌苔焦黃或焦黑，或自利清水，色純青之「熱結旁流」等陽明腑實之證。或因素體氣血不足，或因裏熱成實而延誤失治，耗傷氣血，故神疲少氣，脈虛。裏熱熾盛，熱擾心神，神明昏亂而正氣欲脫，則見神昏譫語，肢厥，循衣撮空等危侯。本證裏實而正虛，治當瀉熱通便，補氣養血，邪正兼顧","本方既用大承氣湯之意，大黃的煎法為何不後下？本證熱結裏實雖重，但氣血不足，正氣欲脫。如攻下過猛，恐有元氣下脫之虞。攻實要防脫，治病要留人，故本方雖有大承氣湯的組成，而大黃不後下，則攻下之力較大承氣湯緩和，是 「治之以峻，行之以緩」 的用法","1. 辨證要點：本方為攻補兼施的代表方，又是治療陽明腑實兼氣血不足證的常用方。臨床應用以大便秘結，或自利清水，脘腹脹滿，身熱口渴，神倦少氣，舌苔焦黃或黑，脈虛為辨證要點。 2. 現代運用：本方常用於傷寒、副傷寒、流行性腦脊髓膜炎、流行性乙型腦炎、老年性腸梗阻等屬於陽明腑實而兼氣血不足者。 3. 注意事項：寒積便秘以及氣虛、陰虛、血少之虛秘均禁用","新加黃龍湯《溫病條辨》細生地五錢 (15g) 生甘草二錢 (6g) 人參另煎，一錢五分 (4.5g) 生大黃三錢 (9g) 芒硝一錢 (3g) 玄參五錢 (15g) 麥冬連心，五錢 (15g) 當歸一錢五分 (4.5g) 海參洗二條，薑汁六匙，以水八杯，煮取三杯。先用一杯，沖參汁五分，薑汁二匙，頓服之。如腹中有響聲，或轉矢氣者，為欲便也，候一、二時不便，再如前法服一杯；候二十四刻不便，再服第三杯。如服一杯，即得便，止後服。酌服益胃湯一劑。餘參或可加入。功用：泄熱通便，滋陰益氣。主治：熱結裏實，氣陰不足證。大便秘結，腹中脹滿而硬，神倦少氣，口乾咽燥，唇裂舌焦，苔焦黃或焦黑燥裂","黃龍湯枳樸硝黃，參歸甘桔棗生薑， 陽明腑實氣血弱，攻補兼施效力強")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("26","小柴胡湯","Xiao Chai Hu Tang","Minor Bupleurum Decoction","和解劑","《傷寒論》","柴胡半斤 (24g) 黃芩三兩 (9g) 人參三兩 (9g) 甘草三兩，炙 (9g) 半夏半升，洗 (9g) 生薑三兩，切 (9g) 大棗十二枚，擘 (4枚)","上七味，以水一斗二升，煮取六升，去滓，再煎，取三升，溫服一升，日三服 (現代用法：水煎服)","和解少陽","1. 傷寒少陽證。往來寒熱，胸脅苦滿，默默不欲飲食，心煩喜嘔，口苦，咽乾，目眩，舌苔薄白，脈弦者。 2. 熱入血室證。婦人中風，經水適斷，寒熱發作有時；以及瘧疾、黃疸等病而見少陽證者","本方主治邪入少陽證。少陽經脈循胸布脅，位於太陽、陽明表裏之間。傷寒邪犯少陽，病在半表半裏，邪正相爭，正勝欲拒邪出於表，邪勝欲入裏並於陰，故往來寒熱。足少陽之脈起於目銳眥，其支者，下胸中，貫膈，絡肝，屬膽，循脅裏。邪在少陽，疏機不利，鬱而化熱，膽火上擾，則胸脅苦滿，心煩，口苦，咽乾，目眩。膽熱犯胃，胃失和降，氣逆於上，故默默不欲飲食而喜嘔。若婦人經期，感受風邪，邪熱內傳，熱與血結，血熱瘀滯，疏泄失常，故經水不當斷而斷，寒熱發作有時。治療大法，邪在表者，當從汗解；邪入裏者，則當吐下；今邪既不在表，又不在裏，而在表裏之間，則非汗、吐、下所宜，故唯宜和解之法","1. 關於柴胡、黃芩的配伍：足少陽膽經循胸布脅，位於太陽、陽明表裏之間。傷寒邪入少陽，病在半表半裏，以樞機不利，膽熱內擾為病機特點，治療宜透邪清熱，疏達氣機。方中柴胡性味辛苦而微寒，入肝膽經，既能透達少陽半表之邪從外而解，又能疏暢少陽氣機之鬱滯；黃芩苦寒，亦入肝膽經，善清少陽半裏之膽熱。二藥一側重半表之邪，一側重半裏之熱，並能調暢氣機，伍用使邪氣外透內清，故為和解少陽的基本結構。 2. 關於服法：本方服法要求 「去渣，再煎」，何以需 「再煎」？小柴胡湯是和法的代表方，其用藥體現雙向調節，如藥性之寒溫 (柴、芩之寒與薑、夏、參、草、棗之溫)，病位在半表半裏 (柴、薑透半表之邪，黃芩清半裏之熱)、病性之虛實 (柴、芩、薑、夏透邪清熱以祛邪，參、棗、草益氣以扶正)。去渣再煎，能使本方藥性相融，發揮協調膽胃，協調氣津，協調邪正的作用。這種煎服法是仲景對和解劑獨具匠心的創作，觀和解少陽之大、小柴胡湯，調和寒熱的三瀉心湯都取 「去渣、再煎」 之法","1. 辨證要點：本方為治療少陽病證的基礎方，又是和解少陽法的代表方。臨床應用以往來寒熱，胸脅苦滿，默默不欲飲食，心煩喜嘔，口苦，咽乾，苔白，脈弦為辨證要點。 2. 現代運用：本方常用於感冒、流行性感冒、瘧疾、慢性肝炎、肝硬化、急慢性膽囊炎、膽結石、急性胰腺炎、胸膜炎、中耳炎、產褥熱、急性乳腺炎、睾丸炎、膽汁返流性胃炎、胃潰瘍等屬邪踞少陽，膽胃不和者。 3. 注意事項：因柴胡升散，芩、夏性燥，故對陰虛血少者禁用","柴胡枳桔湯《通俗傷寒論》柴胡一錢至錢半 (3~4.5g) 枳殼錢半 (4.5g) 薑半夏錢半 (4.5g) 鮮生薑一錢 (3g) 青子芩一錢至錢半 (3~4.5g) 桔梗一錢 (3g) 新會皮錢半 (4.5g) 雨前茶一錢 (3g) 水煎服。功用：和解透表，暢利胸膈。主治：邪踞少陽證偏於半表者。往來寒熱，兩頭角痛，耳聾目眩，胸脅滿痛，舌苔白滑，脈右弦滑，左弦而浮大","小柴胡湯和解功，半夏人參甘草從， 更加黃芩生薑棗，少陽為病此方宗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("27","大柴胡湯","Da Chai Hu Tang","Major Bupleurum Decoction","和解劑","《金匱要略》","柴胡半斤 (15g) 黃芩三兩 (9g) 芍藥三兩 (9g) 半夏半升，洗 (9g) 生薑五兩，切 (15g) 枳實四枚，炙 (9g) 大棗十二枚，擘 (4枚) 大黃二兩 (6g)","上八味，以水一斗二升，煮取六升，去滓，再煮，溫服一升，日三服 (現代用法：水煎2次，去滓，再煎，分2次溫服)","和解少陽，內瀉熱結","少陽陽明合病。往來寒熱，胸脅苦滿，嘔不止，鬱鬱微煩，心下痞硬，或心下滿痛，大便不解或協熱下利，舌苔黃，脈弦數有力","本方主治少陽陽明合病，仍以少陽為主。證見往來寒熱，胸脅苦滿，表明病變部位仍未離少陽；嘔不止與鬱鬱微煩，則較小柴胡湯證之心煩喜嘔為重，再與心下痞硬或滿痛，便秘或下利，舌苔黃，脈弦數有力等合參，說明病邪已進入陽明，有化熱成實的熱結之象。因此，在治法上，病在少陽，本當禁用下法，但與陽明腑實並見的情況下，就必須表裏兼顧，擬和解少陽，內瀉熱結之法","","1. 辨證要點：本方為治療少陽陽明合病的常用方。以往來寒熱，胸脅苦滿，心下滿痛，嘔吐，便秘，苔黃，脈弦數有力為辨證要點。 2. 現代運用：急性胰腺炎、急性膽囊炎、膽石症、胃及十二指腸潰瘍等屬少陽陽明合病者，均可用之","厚樸七物湯《金匱要略》厚樸半斤 (24g) 甘草三兩 (9g) 大黃三兩 (9g) 大棗十枚 (4枚) 枳實五枚 (12g) 桂枝二兩 (6g) 生薑五兩 (15g) 上七味，以水一斗，煮取四升，溫服八合，日三服。功用：解肌發表，行氣通便。主治：外感表證未罷，裏實已成。腹滿，大便不通，發熱，脈浮而數","大柴胡湯用大黃，枳實芩夏白芍將， 煎加薑棗表兼裏，妙法內攻並外攘")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("28","蒿芩清膽湯","Hao Qin Qing Dan Tang","Sweet Wormwood and Scutellaria Gallbladder-Clearing Decoction","和解劑","《重訂通俗傷寒論》","青蒿腦錢半至二錢 (4.5~6g) 淡竹茹三錢 (9g) 仙半夏錢半 (4.5g) 赤茯苓三錢 (9g) 青子芩錢半至三錢 (4.5~9g) 生枳殼錢半 (4.5g) 陳廣皮錢半 (4.5g) 碧玉散 (滑石、甘草、青黛) 包，三錢 (9g)","原方未著用法 (現代用法：水煎服)","清膽利濕，和胃化痰","少陽濕熱證。寒熱如瘧，寒輕熱重，口苦膈悶，吐酸苦水，或嘔黃涎而粘，甚則乾嘔呃逆，胸脅脹疼，小便黃少，舌紅苔白膩，間現雜色，脈數而右滑左弦者","本方為治少陽膽熱偏重，兼有濕熱痰濁內阻之證。濕遏熱鬱，阻於少陽膽與三焦。三焦之氣機不暢，膽中之相火乃熾，以致少陽樞機不利。膽經鬱熱偏重，故寒熱如瘧，寒輕熱重，口苦膈悶，胸脅脹痛。膽熱犯胃，液鬱為痰，胃氣上逆，故吐酸苦水，或嘔黃涎而粘，甚則乾嘔呃逆。濕阻三焦，水道不暢，以致小便短少，其色黃赤。治宜清膽利濕，和胃化痰","","1. 辨證要點：本方為治療少陽濕熱證的代表方。臨床應用以寒熱如瘧，寒輕熱重，胸脅脹疼，吐酸苦水，舌紅苔膩，脈弦滑數為辨證要點。 2. 現代運用：本方常用於腸傷寒、急性膽囊炎、急性黃疸型肝炎、膽汁返流性胃炎、腎盂腎炎、瘧疾、盆腔炎、鉤端螺旋體病屬少陽膽與三焦濕遏熱鬱者","","蒿芩清膽枳竹茹，陳夏茯苓碧玉入， 熱重寒輕痰濕重，胸痞嘔惡總能除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("29","達原飲","Da Yuan Yin","Membrane-$formula_source-Opening Beverage","和解劑","《溫疫論》","檳榔二錢 (6g) 厚樸一錢 (3g) 草果仁五分 (1.5g) 知母一錢 (3g) 芍藥一錢 (3g) 黃芩一錢 (3g) 甘草五分 (1.5g)","上用水二盅，煎八分，午後溫服 (現代用法：水煎服)","開達膜原，辟穢化濁","瘟疫或瘧疾，邪伏膜原證。憎寒壯熱，或一日三次，或一日一次，發無定時，胸悶嘔惡，頭痛煩躁，脈弦數，舌邊深紅，舌苔垢膩，或苔白厚如積粉","本方是為瘟疫穢濁毒邪伏於膜原而設。《重訂通俗傷寒論》說：「膜者，橫膈之膜；原者，空隙之處。外通肌腠，內近胃腑，即三焦之關鍵，為內外交界之地，實一身之半表半裏也」。瘟疫邪入膜原半表半裏，邪正相爭，故見憎寒壯熱；瘟邪疫毒內侵入裏，導致嘔惡、頭痛、煩躁、苔白厚如積粉等一派穢濁之候。當以開達膜原，辟穢化濁為法","","1. 辨證要點：本方為治療瘟疫初起或瘧疾，邪伏膜原的常用方。以憎寒壯熱，舌紅苔垢膩如積粉為辨證要點。 2. 現代運用：本方常用於瘧疾、流行性感冒、病毒性腦炎屬溫熱疫毒伏於膜原者","1. 柴胡達原飲《重訂通俗傷寒論》柴胡錢半 (5g) 生枳殼錢半 (5g) 川樸錢半 (5g) 青皮錢半 (5g) 炙草七分 (2g) 黃芩錢半 (5g) 苦桔梗一錢 (3g) 草果六分 (2g) 檳榔二錢 (6g) 荷葉梗五寸 (6g) 水煎服。功用：宣濕化痰，透達膜原。主治：痰濕阻於膜原證。胸膈痞滿，心煩懊憹，頭眩口膩，咳痰不爽，間日發瘧，舌苔厚如積粉，捫之糙澀，脈弦而滑。 2. 清脾飲《濟生方》青皮去白 厚樸薑汁炒 白朮 草果仁 柴胡去蘆 茯苓 黃芩 半夏湯泡七次 炙甘草，各等分，每服四錢，水一盞半，薑五片，煎至七分，去滓溫服。功用：燥濕化痰，泄熱清脾。主治：瘧疾，熱多寒少，口苦咽乾，小便赤澀，脈來弦數","達原草果檳厚樸，知母黃芩芍甘佐， 辟穢化濁達膜原，邪伏膜原寒熱作")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("30","四逆散","Si Ni San","Frigid Extremities Powder","和解劑","《傷寒論》","炙甘草 枳實破 水漬，炙乾 柴胡 芍藥各十分 (各6g)","上四味，搗篩，白飲和服方寸匕，日三服 (現代用法：水煎服)","行氣解鬱，疏肝理脾","1. 陽鬱厥逆證。手足不溫，或腹痛，或泄利下重，脈弦。 2. 肝脾不和證。脅肋脹悶，脘腹疼痛，脈弦等","本方原治「少陰病，四逆」。四逆者，乃手足不溫也。其證緣於外邪傳經入裏，氣機為之鬱遏，不得疏泄，導致陽氣內鬱，不能達於四末，而見手足不溫。後世拓展其治療範圍，用於肝脾氣機鬱滯之脅肋脹悶，脘腹疼痛。故擬行氣解鬱，疏肝理脾之法","","1. 辨證要點：本方原治陽鬱厥逆證，後世多用作疏肝理脾的基礎方。臨床以手足不溫，或脅肋、脘腹疼痛，脈弦為辨證要點。 2. 現代運用：慢性肝炎、膽囊炎、膽石症、膽道蛔蟲症、肋間神經痛、胃潰瘍、胃炎、胃腸神經官能症、附件炎、輸卵管阻塞、急性乳腺炎等，辨證屬肝膽氣鬱，肝脾 (或膽胃) 不和者","1. 柴胡疏肝散《證治準繩》引《醫學統旨》柴胡 陳皮醋炒 各二錢 (各6g) 川芎 香附 枳殼麩炒 芍藥各一錢半 (各4.5g) 炙甘草，五分 (1.5g) 水二盅，煎八分，食前服。功用：疏肝行氣，活血止痛。主治：肝氣鬱滯證。脅肋疼痛，胸悶喜太息，情志抑鬱易怒，或噯氣，脘腹脹滿，脈弦。 2. 枳實芍藥散《金匱要略》枳實燒令黑，勿太過 芍藥等分二味，杵為散，服方寸匕，日三服，以麥粥下之。功用：行氣和血，緩急止痛。主治：氣血鬱滯證。產後腹痛，煩滿不得臥。並主癰膿","四逆散裏用柴胡，芍藥枳實甘草須， 此是陽鬱成厥逆，疏肝理脾奏效奇")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("31","逍遙散","Xiao Yao San","Free Wanderer Powder","和解劑","《太平惠民和劑局方》","甘草微炙赤，半兩 (15g) 當歸去苗，銼，微炒 茯苓去皮，白者 白芍藥 白朮 柴胡去苗，各一兩 (各30g)","上為粗末，每服二錢 (6g)，水一大盞，燒生薑一塊切破，薄荷少許，同煎至七分，去渣熱服，不拘時候 (現代用法：共為散，每服6~9g，煨薑、薄荷少許，共煎湯溫服，日三次。亦可作湯劑，水煎服，用量按原方比例酌減)","疏肝解鬱，養血健脾","肝鬱血虛脾弱證。兩脅作痛，頭痛目眩，口燥咽乾，神疲食少，或月經不調，乳房脹痛，脈弦而虛者","肝性喜條達，惡抑鬱，為藏血之臟，體陰而用陽。若情志不暢，肝木不能條達，則肝體失於柔和，以致肝鬱血虛。足厥陰肝經「布脅肋，循喉嚨之後，上入頏顙，連目系，上出額，與督脈會於巔」。肝鬱血虛則兩脅作痛，頭痛目眩；鬱而化火，故口燥咽乾。肝木為病易於傳脾，脾胃虛弱故神疲食少。肝藏血，主疏泄，肝鬱血虛脾弱，在婦女多見月經不調，乳房脹痛。治宜疏肝解鬱，養血健脾之法","關於薄荷的用量：薄荷為多功效中藥，具有疏散風熱、利咽透疹、疏達肝氣等功效，其在複方中功效發揮的方向，除與配伍有關外，尚與劑量密切相關。中、大劑量側重疏散風熱、透疹，小劑量側重在疏肝。本方主治肝鬱血虛脾弱證，用此與柴胡相伍，以疏達肝氣，故臨證運用劑量不宜過大，6g左右為宜","1. 辨證要點：本方為疏肝養血的代表方，又是婦科調經的常用方。臨床以兩脅作痛，神疲食少，月經不調，脈弦而虛為辨證要點。 2. 現代運用：本方常用於慢性肝炎、肝硬化、膽石症、胃及十二指腸潰瘍、慢性胃炎、胃腸神經官能症、經前期緊張症、乳腺小葉增生、更年期綜合征、盆腔炎、不孕症、子宮肌瘤等屬肝鬱血虛脾弱者","1. 加味逍遙散《內科摘要》當歸 芍藥 茯苓 白朮炒 柴胡各一錢 (各6g) 牡丹皮 山梔炒 炙甘草，各五分 (各3g) 水煎服。功用：養血健脾，疏肝清熱。主治：肝鬱血虛，內有鬱熱證。潮熱晡熱，煩躁易怒，或自汗盜汗，或頭痛目澀，或頰赤口乾，或月經不調，少腹脹痛，或小便澀痛，舌紅苔薄黃，脈弦虛數。 2. 黑逍遙散《醫略六書‧女科指要》逍遙散加生地或熟地。功用：疏肝健脾，養血調經。主治：肝脾血虛證。臨經腹痛，脈弦虛","逍遙散用當歸芍，柴苓朮草加薑薄， 肝鬱血虛脾氣弱，調和肝脾功效卓")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("32","痛瀉要方","Tong Xie Yao Fang","Important Formula for Painful Diarrhea","和解劑","《丹溪心法》","白朮炒，三兩 (90g) 白芍藥炒，二兩 (60g) 陳皮炒，一兩五錢 (45g) 防風一兩 (30g)","上細切，分作八服，水煎或丸服 (現代用法：作湯劑，水煎服，用量按原方比例酌減)","補脾柔肝，祛濕止瀉","脾虛肝旺之痛瀉。腸鳴腹痛，大便泄瀉，瀉必腹痛，瀉後痛緩，舌苔薄白，脈兩關不調，左弦而右緩者","痛瀉之證，系由土虛木乘，肝脾不和，脾運失常所致。《醫方考》說：「瀉責之脾，痛責之肝；肝責之實，脾責之虛，脾虛肝實，故令痛瀉」。其特點是瀉必腹痛。治宜補脾抑肝，祛濕止瀉","","1. 辨證要點：本方為治肝脾不和之痛瀉的常用方。臨床以腸鳴腹痛，大便泄瀉，瀉必腹痛，瀉後痛緩，左關脈弦而右關脈緩為辨證要點。 2. 現代運用：本方常用於急性腸炎、慢性結腸炎、腸易激綜合征等屬肝旺脾虛者","","痛瀉要方用陳皮，朮芍防風共成劑， 腸鳴泄瀉腹又痛，治在瀉肝與實脾")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("33","半夏瀉心湯","Ban Xia Xie Xin Tang","Pinellia Heart-Draining Decoction","和解劑","《傷寒論》","半夏半升，洗 (12g) 黃芩 乾薑 人參各三兩 (各9g) 黃連一兩 (3g) 大棗十二枚，擘 (4枚) 甘草三兩，炙 (9g)","上七味，以水一斗，煮取六升，去渣，再煮，取三升，溫服一升，日三服 (現代用法：水煎服)","寒熱平調，消痞散結","寒熱互結之痞證。心下痞，但滿而不痛，或嘔吐，腸鳴下利，舌苔膩而微黃","此方所治之痞，原系小柴胡湯證誤行瀉下，損傷中陽，少陽邪熱乘虛內陷，以致寒熱互結，而成心下痞。痞者，痞塞不通，上下不能交泰之謂。心下即是胃脘，屬脾胃病變。脾胃居中焦，為氣機升降之樞紐，今中氣虛弱，寒熱互結，遂成痞證。脾為陰臟，其氣主升，胃為陽腑，其氣主降，中氣既傷，升降失常，故上見嘔吐，下則腸鳴下利。本方證病機較為複雜，既有寒熱錯雜，又有虛實相兼，以致中焦失和，升降失常。治當調其寒熱，益氣和胃，散結除痞","關於辛開苦降：辛溫藥與苦寒藥合用的一種配伍方法。具有調和寒熱，宣通氣機，降逆止嘔，消痞除滿作用，適應用於寒熱互結或濕熱蘊結之痞滿、下利、嘔吐等。本方半夏、乾薑之辛溫 (熱) 與黃芩、黃連之苦寒合用，為典型的辛開苦降配伍法的應用","1. 辨證要點：本方為治療中氣虛弱，寒熱互結，升降失常，而致腸胃不和的常用方，又是體現平調寒熱、苦降辛開治法的代表方。臨床應用以心下痞滿，嘔吐瀉利，苔膩微黃為證治要點。 2. 現代運用：本方常用於急慢性胃腸炎、慢性結腸炎、慢性肝炎、早期肝硬化等，屬中氣虛弱，寒熱互結，症見痞、嘔、下利者。 3. 注意事項：因氣滯或食積所致的心下痞滿，不宜使用","1. 生薑瀉心湯《傷寒論》生薑四兩，切 (12g) 甘草三兩，炙 (9g) 人參三兩 (9g) 乾薑一兩 (3g) 黃芩三兩 (9g) 半夏半升，洗 (9g) 黃連一兩 (3g) 大棗十二枚 (4枚) 上八味，以水一斗，煮取六升，去渣，再煮，取三升，溫服一升，日三服。功用：和胃消痞，宣散水氣。主治：水熱互結痞證。心下痞硬，乾噫食臭，腹中雷鳴下利者。 2. 甘草瀉心湯《傷寒論》甘草四兩 (12g) 黃芩 人參 乾薑各三兩 (各9g) 黃連一兩 (3g) 炙 大棗十二枚 (4枚) 半夏半升 (9g) 上七味，以水一斗，煮取六升，去滓，再煎，溫服一升，日三服。功用；和胃補中，降逆消痞。主治：胃氣虛弱痞證。下利日數十行，穀不化，腹中雷鳴，心下痞硬而滿，乾嘔，心煩不得安。 3. 黃連湯《傷寒論》黃連 炙甘草 乾薑 桂枝各三兩 (各9g) 人參二兩 (6g) 半夏半升，洗 (9g) 大棗擘，十二枚 (4枚) 上七味，以水一斗，煮取六升，去滓，溫服一升，日三服，夜二服。功用：寒熱並調，和胃降逆。主治：上熱下寒證。胸脘痞悶，煩熱，氣逆欲嘔，腹中痛，或腸鳴泄瀉，舌苔白滑，脈弦者","半夏瀉心黃連芩，乾薑甘草與人參， 大棗合之治虛痞，法在降陽而和陰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("34","白虎湯","Bai Hu Tang","White Tiger Decoction","清熱劑","《傷寒論》","石膏一斤，碎 (50g) 知母六兩 (18g) 甘草二兩，炙 (6g) 粳米六合 (9g)","上四味，以水一斗，煮米熟湯成，去滓，溫服一升，日三服","清熱生津","氣分熱盛證。壯熱面赤，煩渴引飲，汗出惡熱，脈洪大有力","本方原為治陽明經證的基礎方。傷寒化熱內傳陽明之經，或溫邪由衛及氣，皆能出現本證。裏熱熾盛，故壯熱不惡寒；胃熱津傷，故見渴喜冷飲；裏熱蒸騰，逼津外泄則汗出；脈洪大有力為裏熱熾盛之象。氣分熱盛，惟以清熱生津之法最宜","","1. 辨證要點：本方為治氣分熱盛證的基礎方。臨床以壯熱、汗多、煩渴、脈洪大為辨證要點。 2. 現代運用：本方常用於急性傳染性和感染性疾病，如乙型腦炎、流行性出血熱、大葉性肺炎、鉤端螺旋體病、流行性腦脊髓膜炎、流行性感冒、腸傷寒、急性細菌性痢疾、瘧疾、麻疹、敗血症等辨證屬氣分熱盛者。 3. 注意事項：表證未解的無汗發熱、口不渴者，脈見浮細或沉者，血虛發熱而脈洪不勝重按者，真寒假熱的陰盛格陽證等均不可誤用","1. 白虎加人參湯《傷寒論》知母六兩 (18g) 石膏一斤，碎，綿裹 (50g) 甘草二兩，炙 (6g) 粳米六合 (9g) 人參三兩 (10g) 上五味，以水一斗，米熟，湯成去滓，溫服一升，日三服。功用：清熱、益氣、生津。主治：氣分熱盛，氣陰兩傷證。汗、吐、下後，裏熱熾盛，而見四大症者；白虎湯證見有背微惡寒，或飲不解渴，或脈浮大而芤，以及暑熱病見有身大熱屬氣津兩傷者。 2. 白虎加桂枝湯《金匱要略》知母六兩 (18g) 甘草二兩，炙 (6g) 石膏一斤 (50g) 粳米二合 (6g) 桂枝三兩，去皮 (5~9g)，為粗末，每服五錢，水一盞半，煎至八分，去滓溫服，汗出愈。功用：清熱、通絡、和營衛。主治：溫瘧。其脈如平，身無寒但熱，骨節疼煩，時嘔。以及風濕熱痹，症見壯熱，氣粗煩躁，關節腫痛，口渴苔白，脈弦數。 3. 白虎加蒼朮湯《類證活人書》知母六兩 (18g) 甘草二兩，炙 (6g) 石膏一斤 (50g) 蒼朮 粳米各三兩 (各9g) 如麻豆大，每服五錢，水一盞半，煎至八九分，去滓，取六分清汁，溫服。功用：清熱祛濕。主治：濕溫病。身熱胸痞，汗多，舌紅苔白膩等。以及風濕熱痹，身大熱，關節腫痛等","白虎膏知粳米甘，清熱生津止渴煩， 氣分熱盛四大證，益氣生津人參添")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("35","竹葉石膏湯","Zhu Ye Shi Gao Tang","Lophatherum and Gypsum Decoction","清熱劑","《傷寒論》","竹葉二把 (6g) 石膏一斤 (50g) 半夏半升，洗 (9g) 麥門冬一升，去心 (20g) 人參二兩 (6g) 甘草二兩/ 炙 (6g) 粳米半升 (10g)","上七味，以水一斗，煮取六升，去滓，內粳米，煮米熟，湯成去米，溫服一升，日三服 (現代用法：水煎，米熟湯成，溫服)","清熱生津，益氣和胃","傷寒、溫病、暑病餘熱未清，氣津兩傷證。身熱多汗，心胸煩悶，氣逆欲嘔，口乾喜飲，神疲少氣，咽乾唇燥，不思飲食，或咳嗆，或虛煩不寐，舌紅苔少，脈虛數","熱病後期，高熱雖除，但餘熱留戀氣分，故見身熱多汗，口乾喜飲；熱擾心神，而有心煩或虛煩不寐；熱傷氣陰，故神疲少氣，咽乾唇燥，舌紅苔少，脈虛數；熱病後期，胃氣未復，故口淡無味，不思飲食；餘熱內擾，肺胃氣逆，故欲嘔或咳嗆。本方證病機特點為餘熱未清，留戀肺胃，氣陰兩傷，胃氣不和","","1. 辨證要點：本方為治療熱病後期餘熱未清而氣陰耗傷，胃氣失和的常用方。臨床以身熱多汗、咽乾口渴、神疲少氣、不思飲食、氣逆欲嘔、舌紅苔少、脈虛數為辨證要點。 2. 現代運用：本方常用於中暑、夏季熱、流行性乙型腦炎、流行性流脊髓膜炎、肺炎後期、膽道術後嘔吐等屬餘熱未清而氣陰兩傷、胃氣失和者，以及糖尿病的乾渴多飲屬胃熱氣陰兩傷者。 3. 注意事項：本方清涼質潤，如內有痰濕，或陽虛發熱，均應忌用","","竹葉石膏參麥冬，半夏粳米甘草從， 清補氣津又和胃，餘熱耗傷氣津用")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("36","清營湯","Qing Ying Tang","Ying Level Heat-Clearing Decoction","清熱劑","《溫病條辨》","犀角三錢 (水牛角代，30g) 生地黃五錢 (15g) 元參三錢 (9g) 竹葉心一錢 (3g) 麥冬三錢 (9g) 丹參二錢 (6g) 黃連一錢五分 (5g) 銀花三錢 (9g) 連翹連心用，二錢 (6g)","水八杯，煮取三杯，日三服 (現代用法：水煎服)","清營解毒，透熱養陰","熱入營分證。身熱夜甚，神煩少寐，時有譫語，口渴或不渴，或斑疹隱隱，舌絳而乾，脈細數","本方專為邪熱初傳營分而設。邪熱傳營，伏於陰分，故身熱夜甚；熱擾心營，故神煩少寐，甚至時有譫語；若邪熱初入營分，則蒸騰營陰，使血中津液上潮於口，故理當口渴而反不渴；若邪熱初入營分，氣分邪熱未盡，灼傷肺胃陰津，則必見身熱口渴、苔黃燥；斑疹隱隱，乃熱傷血絡，血不循經，溢出脈外之征；舌絳而乾、脈數，為熱傷營陰之象。本方證病機特點為營熱傷陰、擾心竄絡","清營湯主治營分熱證，為何要用治療衛分證的銀花、連翹、竹葉？ 本方雖為邪熱傳入營分而設，但營分外臨氣分，是熱邪初入營血階段，熱邪還有外泄之機。清代溫病學家葉天士說過：「入營猶可透熱轉氣」，即治療營分證時，應在清營熱養營陰的基礎上，配伍輕清宣透之品，使營分熱邪透出氣分外解，故本方用銀花、連翹、竹葉辛涼宣透之品，有促使營分熱邪外解之功","1. 辨證要點：本方為治療熱邪初入營分證的常用方。臨床以身熱夜甚，神煩少寐或時有譫語，舌絳而乾，脈細數為辨證要點。 2. 現代運用：本方常用於流行性乙型腦炎、流行性腦脊髓膜炎、敗血症、腸傷寒或其他熱性病症，中醫辨證屬熱入營分或氣營兩燔者。 3. 注意事項：舌絳苔白滑乃濕遏熱伏之象，忌用本方。原著說：「舌白滑者，不可與也」，並在該條自注中說：「舌白滑，不惟熱重，濕亦重矣，濕重忌柔潤藥」，以防滋膩而助濕留邪","清宮湯《溫病條辨》元參心三錢 (9g) 蓮子心五分 (2g) 竹葉卷心二錢 (6g) 連翹心二錢 (6g) 水牛角 (30g) 連心麥冬三錢 (9g) 水煎服。功用：清心解毒，養陰生津。主治：溫病液傷，邪陷心包證。發熱、神昏譫語","清營湯治熱傳營，身熱躁渴眠不寧， 犀地銀翹玄連竹，丹麥清熱更護陰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("37","犀角地黃湯","Xi Jiao Di Huang Tang","Rhinoceros Horn and Rehmannia Decoction","清熱劑","《外臺秘要》","犀角一兩 (水牛角代，30g) 生地黃半斤 (24g) 芍藥三分 (12g) 牡丹皮一兩 (9g)","上藥四味，㕮咀，以水九升，煮取三升，分三服 (現代用法：水煎服)","清熱解毒，涼血散瘀","熱入血分證。 1. 熱擾心神，身熱譫語，舌絳起刺，脈細數。 2. 熱傷血絡，斑色紫黑、吐血、衄血、便血、尿血等，舌紅絳，脈數。 3. 蓄血瘀熱，喜忘如狂，漱水不欲咽，大便色黑易解","本方治證由熱毒熾盛於血分所致。熱入血分，一則熱擾心神，而致躁擾昏狂；二則熱邪迫血妄行，發生吐血、衄血、尿血、便血等各部位之出血，離經之血留阻體內又可出現發斑、蓄血；三則血分熱毒耗傷血中津液，血因津少而濃稠，運行澀滯，漸聚成瘀，故舌紫絳而乾。四則熱與血結或離經之血蓄結而致蓄血瘀熱之善忘如狂，舌質紅絳；血性濡潤，血為熱迫，滲於腸間，故大便色黑易解。本方證病機特點為熱擾心神，動血耗血，蓄血留瘀。此時不清其熱則血不寧，不散其血則瘀不去，故組方配伍當以清熱解毒、涼血散瘀為法。清代名醫葉天士所謂「入血就恐耗血動血，直須涼血散血」 即是此意","","1. 辨證要點：本方是治療溫熱病熱入血分證的常用方。臨床以各種失血、斑色紫黑，身熱譫語、舌絳起刺、脈數為辨證要點。 2. 現代運用：本方常用於重症肝炎、肝昏迷、彌漫性血管內凝血、尿毒癥、過敏性紫癜、急性白血病、敗血症等屬血分熱盛者。 3. 注意事項：本方寒涼清滋，對於陽虛失血，脾胃虛弱者忌用","1. 神犀丹《溫熱經緯》(引葉天士方) 水牛角 (1800g) 石菖蒲 黃芩各六兩 (各180g) 真懷生地絞汁 銀花各一斤 (各500g) 金汁 連翹各十兩 (各300g) 板藍根九兩 (270g) 香豉八兩 (240g) 玄參七兩 (210g) 花粉 紫草各四兩 (各120g) 各生曬研細，以水牛角、地黃汁、金汁和搗為丸，每重一錢 (3g)，涼開水化服，日二次，小兒減半。功用：清熱開竅，涼血解毒。主治：溫熱暑疫，邪入營血證。高熱昏譫，斑疹色紫，口咽糜爛，目赤煩躁，舌紫絳等。 2. 化斑湯《溫病條辨》石膏一兩 (30g) 知母四錢 (12g) 生甘草三錢 (10g) 玄參三錢 (10g) 水牛角 (60g) 白粳米一合 (9g) 水八杯，煮取三杯，日三服。滓再煮一盅，夜一服。功用：清氣涼血。主治：氣血兩燔之發斑。發熱，或身熱夜甚；外透斑疹，色赤，口渴，或不渴，脈數等。 3. 清瘟敗毒飲《疫疹一得》生石膏大劑六兩至八兩 (180~240g) ； 中劑二兩至四兩 (60~120g) ；小劑八錢至一兩二錢 (24~36g) 小生地大劑六錢至一兩 (18~30g) ；中劑三錢至五錢 (9~15g) ；小劑二錢至四錢 (6~12g) 水牛角大劑六兩至八兩 (180~240g) ；中劑三兩至五兩 (90~150g) ；小劑二兩至四兩 (60~120g) 真川連大劑四至六錢 (12~18g) ；中劑二至四錢 (6~12g) ；小劑一錢至一錢半 (3~4.5g) 梔子 桔梗 黃芩 知母 赤芍 玄參 連翹 甘草 丹皮 鮮竹葉 (以上十味，原書無用量) 先煎石膏數十沸，後下諸藥。(現代用法：先煎石膏數十沸，後下諸藥，用量按原方比例酌減。) 功用：清熱解毒，涼血瀉火。主治：溫疫熱毒，氣血兩燔證。大熱渴飲，頭痛如劈，乾嘔狂躁，譫語神昏，或發斑，或吐血，衄血，四肢或抽搐，或厥逆，脈沉數，或脈沉細而數，或浮大而數，舌絳唇焦","犀角地黃芍藥當，清熱涼血散瘀專， 熱入血分服之安，蓄血傷絡吐衄斑")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("38","黃連解毒湯","Huang Lian Jie Du Tang","Coptis Toxin-Resolving Decoction","清熱劑","《肘後備急方》","黃連三兩 (9g) 黃芩 黃柏各二兩 (各6g) 梔子十四枚，擘 (9g)","上四味切，以水六升，煮取二升，分二服 (現代用法：水煎服)","瀉火解毒","三焦火毒證。大熱煩躁、錯語不眠、口燥咽乾，小便黃赤，熱病吐血、衄血、熱甚發斑，身熱下痢，疫毒黃疸，外科癰瘍疔毒，舌紅苔黃，脈數有力","本方證乃火毒充斥三焦所致。火毒熾盛，上擾神明，故大熱煩躁，錯語不眠；熱盛則津傷，故口燥咽乾；血為熱迫，隨火上逆，則為吐衄；熱傷絡脈，血溢肌膚，則為發斑；熱毒下迫大腸，則為身熱下痢；疫毒熾盛，內迫肝膽，膽汁外溢肌膚，發為黃疸；熱毒壅聚肌腠，則為癰腫疔毒；舌紅苔黃，脈數有力，皆為火毒熾盛之征。本方證病機特點為火毒熾盛，充斥三焦，立法組方應以苦寒之品直折三焦火毒","","1. 辨證要點：本方為苦寒直折法的代表方，瀉火解毒劑的基礎方。臨床以大熱煩躁、口燥咽乾、舌紅苔黃、脈數有力為辨證要點。 2. 現代運用：本方常用於敗血症、膿毒血症、急性黃疸型肝炎、急性細菌性痢疾、肺炎、急性泌尿系感染、流行性腦脊髓膜炎、流行性乙型腦炎以及其他感染性炎症等屬火毒為患者。 3. 注意事項：本方為大苦大寒之劑，久服或過量易傷脾胃，非火盛者不宜使用","1. 瀉心湯《金匱要略》大黃二兩 (6g) 黃連一兩 (3g) 黃芩一兩 (3g) 上三味，以水三升，煮取一升，頓服之。功用：瀉火消痞。主治：邪熱壅滯心下，氣機痞塞證。心下痞滿，按之柔軟，心煩口渴，小便黃赤，大便不爽或秘結，或吐血衄血，舌紅苔薄黃，脈數。 2. 梔子金花湯《醫宗金鑒》即黃連解毒湯加大黃。水煎服。功用：瀉火解毒。主治：黃連解毒湯證兼大便秘結者，亦治陽證之瘡、癰、疔、癤。 3. 清瘟敗毒飲《疫疹一得》生石膏大劑六兩至八兩 (180~240g)；中劑二兩至四兩 (60~120g)；小劑八錢至一兩二錢 (24~36g) 小生地大劑六錢至一兩 (18~30g)；中劑三錢至五錢 (9~15g)；小劑二錢至四錢 (6~12g) 水牛角大劑六兩至八兩 (180~240g)；中劑三兩至五兩 (90~150g)；小劑二兩至四兩 (60~120g) 真川連大劑四至六錢 (12~18g)；中劑二至四錢 (6~12g)；小劑一錢至一錢半 (3~4.5g) 梔子 桔梗 黃芩 知母 赤芍 玄參 連翹 甘草 丹皮 鮮竹葉 (以上十味，原書無用量) 先煎石膏數十沸，後下諸藥。(現代用法：先煎石膏數十沸，後下諸藥，用量按原方比例酌減。) 功用：清熱解毒，涼血瀉火。主治：溫疫熱毒，氣血兩燔證。大熱渴飲，頭痛如劈，乾嘔狂躁，譫語神昏，或發斑，或吐血，衄血，四肢或抽搐，或厥逆，脈沉數，或脈沉細而數，或浮大而數，舌絳唇焦","黃連解毒柏梔芩，三焦火盛是主因， 煩狂火熱兼譫妄，吐衄發斑皆可平")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("39","涼膈散","Liang Ge San","Diaphragm-Cooling Powder","清熱劑","《太平惠民和劑局方》","川大黃 樸硝 炙甘草，各二十兩 (各600g) 山梔子仁 薄荷去梗 黃芩各十兩 (各300g) 連翹二斤半 (1250g)","上藥共為粗末，每服6~12g，加竹葉3g，蜜少許，水煎服。亦可作湯劑，方中各藥飲片用量酌減，水煎服","瀉火通便，清上泄下","上、中二焦邪鬱生熱證。胸膈煩熱、面赤唇焦、煩躁口渴，口舌生瘡、睡臥不寧、譫語狂妄，或咽痛吐衄、便秘溲赤，或大便不暢，舌紅苔黃，脈滑數","本方證由臟腑積熱，聚於胸膈所致，以上、中二焦見證為主。熱灼胸膈，故胸膈煩熱如焚；熱傷津液，則口渴、咽燥、唇焦；火性上炎，則面紅目赤、口舌生瘡、咽痛吐衄；熱擾心神，則見煩躁不安，睡臥不寧，甚則譫語狂妄；燥熱內結，故有便秘溲赤；舌紅苔黃，脈滑數均為裏熱熾盛之象。本方證病機特點為臟腑積熱，聚於胸膈，犯及心胃，化火上沖","","1. 辨證要點：本方為治療臟腑積熱，聚於胸膈的常用方。臨床以胸膈煩熱、面赤唇焦、煩躁口渴、舌紅苔黃、脈數或滑為辨證要點。 2. 現代運用：本方常用於咽炎、口腔炎、急性扁桃體炎、膽道感染、膽石症、急性黃疸型肝炎、流行性腦脊髓膜炎等辨證屬上、中二焦火熱者。 3. 注意事項：服用本方得利下，應當停服，以免損傷脾胃；孕婦及體虛者，本方應慎用","","涼膈硝黃梔子翹，黃芩甘草薄荷饒， 再加竹葉調蜂蜜，上中鬱熱服之消")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("40","普濟消毒飲","Pu Ji Xiao Du Yin","Universal Relief Toxin-Removing Beverage","清熱劑","《東垣試效方》","黃芩酒炒 黃連酒炒，各五錢 (各15g) 陳皮去白 甘草生用 玄參 柴胡 桔梗各二錢 (各6g) 連翹 板藍根 馬勃 (包煎) 牛蒡子 薄荷各一錢 (各3g) 僵蠶 升麻各七分 (各2g)","上為細末，半用湯調，時時服之，半蜜為丸，噙化之 (現代用法：水煎服)","清熱解毒，散風消腫","大頭瘟。頭面紅腫焮痛，目不能開，咽喉疼痛，惡寒發熱，舌燥口渴，舌紅苔黃，脈數有力","大頭瘟，又名「大頭天行」，乃風熱疫毒，壅於上焦，發於頭面所致。風熱疫毒上攻頭面，氣血雍滯，乃致頭面紅腫焮痛，甚則目不能開；溫毒雍滯咽喉，則咽喉紅腫而痛；熱盛傷津故舌燥口渴；初起風熱時毒侵襲肌表，衛陽被鬱，正邪相爭，故惡寒發熱；舌紅苔黃，脈數有力均為裏熱熾盛之象。疫毒宜清解，風熱宜疏散，病位在上宜因勢利導。故立法組方當解毒與散邪兼施而以清熱解毒為主","","1. 辨證要點：本方為治療大頭瘟的常用方劑。臨床以頭面紅腫焮痛、咽喉疼痛、惡寒發熱、舌紅苔黃、脈數有力為辨證要點。 2. 現代運用：本方常用於顏面丹毒、流行性腮腺炎、急性扁桃體炎上呼吸道感染、頭面部蜂窩織炎、急性化膿性中耳炎、帶狀皰疹、淋巴結炎伴淋巴管回流障礙等屬風熱時毒為患者。 3. 注意事項：方中藥物多苦寒辛散，故素體陰虛以及脾虛便溏者慎用","","普濟消毒蒡芩連，甘桔蘭根勃翹玄， 升柴陳薄僵蠶入，大頭瘟毒服之痊")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("41","仙方活命飲","Xian Fang Huo Ming Yin","Immortal Formula Life-Giving Beverage","清熱劑","《校注婦人良方》","白芷六分 (3g) 穿山甲 甘草 防風 沒藥 赤芍藥 當歸梢 乳香 貝母 天花粉 皂角刺各一錢 (各6g) 金銀花 陳皮各三錢 (各9g)","用好酒三碗，煎置一碗半。若上身，食後服；若下身，食前服，再加飲酒三四杯，以助藥勢，不可更改 (現代用法：水煎服，或水酒各半煎服) ","清熱解毒，消腫潰堅，活血止痛","陽證癰瘍腫毒初起。局部紅腫焮痛，或身熱凜寒，舌苔薄白或黃，脈數有力","癰瘍腫毒初起而屬陽證者，多為熱毒壅遏，氣滯血瘀痰結而成。熱毒壅聚，營氣鬱滯，氣滯血瘀，聚而成形，故見局部紅腫熱痛；邪正交爭於表，故身熱凜寒；正邪俱盛，相搏於經，則脈數有力。本方證病性為熱毒瘀滯之陽證，病位在肌表，立法組方當以清熱解毒、活血理氣為主，配合疏通肌腠、消腫潰堅","","1. 辨證要點：本方是治療陽證癰瘍腫毒初起的常用方。臨床以局部紅腫焮痛、甚則伴有身熱凜寒、脈數有力為辨證要點。 2. 現代運用：本方常用於治療化膿性炎症如蜂窩織炎、化膿性扁桃體炎、乳腺炎、膿皰瘡、癤腫、深部膿腫等屬陽證、實證者。 3. 注意事項：本方適用於陽證而體實的各類癰瘍腫毒初起，若用之得當，則 「膿未成者即消，已成者即潰」。若已潰斷不可用。不善飲酒者可用酒水各半或用清水煎服。本方除煎煮取汁內服外，其藥渣可搗爛外敷。因本方性偏寒涼，陰證瘡瘍忌用；脾胃本虛，氣血不足者均應慎用","1. 五味消毒飲《醫宗金鑒》金銀花三錢 (20g) 野菊花 蒲公英 紫花地丁 紫背天葵子各一錢二分 (各15g) 水一盅，煎八分，加無灰酒半盅，再滾二三沸時，熱服，被蓋出汗為度。功用：清熱解毒，消散疔瘡。主治：疔瘡初起，發熱惡寒，瘡形如粟，堅硬根深，狀如鐵釘，以及癰瘍癤腫，紅腫熱痛，舌紅苔黃，脈數。 2. 四妙勇安湯《驗方新編》金銀花 玄參各三兩 (各90g) 當歸二兩 (60g) 甘草一兩 (30g) 水煎服，一連十劑……藥味不可少，減則不效，並忌抓擦為要。功用：清熱解毒，活血止痛。主治：熱毒熾盛之脫疽。患肢黯紅微腫灼熱，潰爛腐臭，疼痛劇烈，或見發熱口渴，舌紅脈數","仙方活命君銀花，歸芍乳沒陳皂甲， 防芷貝粉甘酒煎，陽證癰瘍內消法")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("42","導赤散","Dao Chi San","Red-Guiding Powder","清熱劑","《小兒藥證直訣》","生地黃 木通 甘草梢各等分 (各6g)","上藥為末，每服三錢，水一盞，入竹葉同煎至五分，食後溫服 (現代用法：加竹葉3g，水煎服)","清心利水養陰","心經火熱證。心胸煩熱，口舌生瘡，口渴面赤，意欲飲冷，或小便赤澀或刺痛，舌紅，脈數","本方主治心經熱盛或心熱下移小腸之證。心火循經上炎，故見心胸煩熱、面赤、口舌生瘡；火熱內灼，陰液被耗，故見口渴、意欲飲冷；心與小腸相表裏，心移熱於小腸，泌別失職，乃見小便赤澀刺痛；舌紅、脈數，均為內熱之象。本方證病機，錢氏只言及「心熱」，或「心氣熱」，未言及虛實，《醫宗金鑒》以「水虛火不實」五字括之，即水虛不甚，火實亦不顯之意。錢乙根據小兒稚陰稚陽，易寒易熱，易虛易實，病變快速的特點，指出治實證當防其虛，治虛證當防其實的用藥原則；並針對心火上炎易傷腎水的病機特點，提出清心與養陰兼顧，利水以導熱下行的制方思路","","1. 辨證要點：本方是體現清熱利水養陰治法的代表方，用治心經火熱證的常用方。臨床以心胸煩熱、口舌生瘡，或小便赤澀，舌紅，脈數為辨證要點。 2. 現代運用：本方常用於口腔炎、鵝口瘡、小兒夜啼等屬心經熱盛者；急性泌尿系感染屬心熱移於小腸者。 3. 注意事項：方中川木通苦寒，生地陰柔寒涼，故脾胃虛弱者慎用","清心蓮子飲《太平惠民和劑局方》黃芩 麥冬去心 地骨皮 車前子 炙甘草，各半兩 (各15g) 石蓮肉去心 白茯苓 黃芪蜜炙 人參各七錢半 (各22.5g) 銼散，每服三錢 (10g) 水一盞半，煎取八分，去滓，水中沉冷，空心食前服。功用：清心火，益氣陰，止淋濁。主治：心火偏旺，氣陰兩虛，濕熱下注證。症見遺精淋濁，血崩帶下，遇勞則發；或腎陰不足，口舌乾燥，煩躁發熱等","導赤木通生地黃，草稍兼加竹葉嘗， 清心利水又養陰，心經火熱移小腸")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("43","龍膽瀉肝湯","Long Dan Xie Gan Tang","Gentian Liver-Draining Decoction","清熱劑","《醫方集解》","龍膽草酒炒 (6g) 黃芩炒 (9g) 梔子酒炒 (9g) 澤瀉 (12g) 木通 (6g) 車前子 (9g，包煎) 當歸酒洗 (6g) 生地黃酒炒 (12g) 柴胡 (12g) 甘草生用 (6g) (原書未著用量)","水煎服，亦可製成丸劑，每服6~9g，日2次，溫開水送下","清泄肝膽實火，清利肝經濕熱","1. 肝膽實火上炎證。頭痛目赤，脅痛，口苦，耳聾，耳腫，舌紅苔黃，脈弦數有力。 2. 肝經濕熱下注證。陰部腫癢、潮濕有汗，小便淋濁，男子陽痿，婦女帶下黃臭，舌紅苔黃膩，脈弦滑而數","本方所治之證，是由肝膽實火上炎或肝膽濕熱循經下注所致。足厥陰肝經繞陰器，布脅肋，連目系，入巔頂；足少陽膽經起於目內眥，布耳前後入耳中，一支入股中，繞陰部，另一支布脅肋。肝膽之火循經上炎則頭部、耳目做痛，或聽力失聰，旁及兩脅則脅痛且口苦；濕熱循經下注則為陰部腫癢、潮濕有汗，男子陽痿，婦女帶下黃臭；舌紅苔黃或膩，脈弦數有力皆為火盛及濕熱之象。本方證病機特點是肝膽實火上炎或肝經濕熱下注，肝膽氣機不舒。立法組方既要清泄肝膽實火，又要清利肝經濕熱，並需疏暢肝膽氣機","龍膽瀉肝湯主治肝經濕熱，為何還用當歸生地柔潤之品？本方主治肝膽實火上炎或肝經濕熱下注，立法組方既要清泄肝膽實火，又要清利肝經濕熱，並需疏暢肝膽氣機。使用當歸生地的理由有二：一是方中大量苦燥之品，容易傷及肝陰；二是肝體陰用陽，陰血為本。配伍當歸生地補養陰血，以強肝體，防止苦燥藥物損傷肝陰","1. 辨證要點：本方為治肝膽實火上炎、肝經濕熱下注的常用方。臨床應用以口苦溺赤、舌紅苔黃或黃膩，脈弦數或滑為辨證要點。 2. 現代運用：本方常用於頑固性偏頭痛、頭部濕疹、高血壓、急性結膜炎、虹膜睫狀體炎、外耳道癤腫、鼻炎等辨證屬肝膽實火上炎者；急性黃疸型肝炎、急性膽囊炎、帶狀皰疹、急性乳腺炎、陽痿等辨證屬肝膽濕熱蘊結；泌尿生殖系炎症、急性腎盂腎炎、急性膀胱炎、尿道炎、外陰炎、睾丸炎、腹股溝淋巴腺炎、急性盆腔炎、白塞氏病等辨證屬肝經濕熱下注者。 3. 注意事項：方中藥多苦寒，易傷脾胃，故對脾胃虛寒和陰虛陽亢之證，皆非所宜","1. 瀉青丸《小兒藥證直訣》當歸去蘆頭，切，焙 龍腦 (即龍膽草) 川芎 山梔子仁 川大黃濕紙裹煨 羌活 防風去蘆頭，切，焙，各等分 (各3g) 上藥為末，煉蜜為丸，如芡實大 (1.5g)，每服半丸至一丸，竹葉煎湯，同砂糖，溫開水化下。功用：清肝瀉火。主治：肝經火鬱證。目赤腫痛，煩躁易怒，不能安臥，尿赤便秘，脈洪實，以及小兒急驚，熱盛抽搐等。 2. 當歸龍薈丸《黃帝素問宣明方論》(又名龍腦丸) 當歸 (焙) 一兩 (30g) 龍膽草 梔子 黃連 黃柏 黃芩各一兩 (30g) 蘆薈 青黛 大黃各五錢 (15g) 木香一分 (0.3g) 麝香五分 (1.5g) 上為末，煉蜜為丸，如小豆大，小兒如麻子大，每服二十丸，生薑湯下。功用：清瀉肝膽實火。主治：肝膽實火證。頭暈目眩，神志不寧，譫語發狂，或大便秘結，小便赤澀","龍膽梔芩酒拌炒，木通澤瀉車柴草， 當歸生地益陰血，肝膽實火濕熱消")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("44","左金丸","Zuo Jin Wan","Left Metal Pill","清熱劑","《丹溪心法》","黃連六兩 (600g) 吳茱萸一兩 (100g)","上藥為末，水丸或蒸餅為丸，白湯下五十丸 (現代用法：口服，一次3~6g，一日2次。亦作湯劑：黃連6g、吳茱萸1g，水煎服)","清瀉肝火，降逆止嘔","肝火犯胃證。脅肋灼痛，嘔吐口苦，嘈雜吞酸，舌紅苔黃，脈弦數","本方證是由肝鬱化火，橫逆犯胃，肝胃不和所致。肝之經脈布於脅肋，肝經火鬱自病則脅肋灼熱脹痛；肝火犯胃則胃失和降，故嘈雜吞酸、嘔吐口苦；舌紅苔黃，脈象弦數乃肝經火鬱之候。本方證肝火為本，胃逆為標，故立法組方應以清瀉肝火為主，兼降逆止嘔","","1. 辨證要點：本方是治療肝火犯胃，肝胃不和證的常用方。臨床以脅肋灼痛、口苦吞酸、舌紅苔黃、脈弦數為辨證要點。 2. 現代運用：本方常用於胃炎、食道炎、胃潰瘍等屬肝火犯胃者。 3. 注意事項：吐酸屬胃虛寒者忌用本方","1. 戊己丸《太平惠民和劑局方》黃連 吳茱萸 白芍 上藥三味，各五兩 (各10g) 為末，麵糊為丸，如梧桐子大。每服20丸 (6克)，濃煎米飲下，空心日三服。(現代用法：亦可作湯劑，水煎服)。功用：疏肝理脾，清熱和胃。主治：肝脾不和證。胃痛吞酸，腹痛泄瀉。 2. 香連丸《太平惠民和劑局方》組成：黃連、吳茱萸二味同炒，去吳茱萸，加木香。功效：清熱化濕，行氣化滯。主治：濕熱痢疾。下痢赤白相兼，腹痛，裏急後重","左金連萸六比一，脅痛吞酸悉能醫， 再加芍藥名戊己，專治泄瀉痛在臍")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("45","葦莖湯","Wei Jing Tang","Phragmites Stem Decoction","清熱劑","《外臺秘要》","葦莖切，二升，以水二斗，煮取五升，去滓 (蘆根代，60g) 薏苡仁半升 (30g) 瓜瓣半升 (冬瓜仁代，24g) 桃仁三十枚 (9g)","㕮咀，內葦汁中，煮取二升，服一升，再服，當吐如膿 (現代用法：水煎服)","清肺化痰，逐瘀散結","肺癰，熱毒雍滯，痰瘀互結證。身有微熱、咳嗽痰多，甚則咳吐腥臭膿血，胸中隱隱作痛，舌紅苔黃膩，脈滑數","本方所治肺癰是由熱毒雍滯，痰瘀互結而成，多見於肺癰成癰期。痰熱壅肺，肺失清肅則咳嗽痰多；邪熱犯肺，傷及血脈，致熱壅血瘀，若久不消散則血敗肉腐，乃成肺癰；癰膿潰破，藉口咽而出，故咳吐腥臭黃痰膿血；痰熱瘀血，互阻胸中，因而胸中隱痛；舌紅苔黃膩、脈滑數皆痰熱內盛之象。治當清肺化痰、逐瘀排膿","","1. 辨證要點：本方為治肺癰的常用方劑，不論肺癰之將成或已成，均可使用本方。臨床以胸滿作痛、咳嗽氣急、咳吐黃稠或黃綠痰、喉有腥味、舌紅苔黃膩、脈滑數為辨證要點。 2. 現代運用：本方常用於肺膿腫、肺炎、急性支氣管炎、慢性支氣管炎繼發感染、急性化膿性扁桃體炎、鼻竇炎等屬肺熱痰瘀互結者","桔梗湯《金匱要略方論》桔梗一兩 (30克) 甘草二兩 (60克) 右二味，以水三升，煮取一升，去滓，分溫再服，則吐膿血也。功用：宣肺止咳，祛痰排膿。主治：肺癰。症見咳而胸痛，振寒，脈數，咽乾不渴，時出濁唾腥臭，久久吐膿如米粥者","葦莖瓜瓣苡桃仁，清肺化痰逐瘀能， 熱毒痰瘀致肺癰，膿成未成均勝任")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("46","瀉白散","Xie Bai San","White-Draining Powder","清熱劑","《小兒藥證直訣》","地骨皮 桑白皮炒，各一兩 (各30g) 炙甘草，一錢 (3g)","上藥銼散，入粳米一撮，水二小盞，煎七分，食前服 (現代用法：水煎服)","清瀉肺熱，止咳平喘","肺有喘咳證。氣喘咳嗽，皮膚蒸熱，日晡尤甚，舌紅苔黃，脈細數","本方治肺有伏火鬱熱之證。火熱鬱結於肺，則氣逆不降而為喘咳；肺熱則外蒸於皮毛，故皮膚蒸熱；此熱不屬於外感，乃伏熱漸傷陰分所致，故熱以午後尤甚，其特點是輕按覺熱，久按若無，與陽明之蒸蒸發熱、愈按愈盛者有別；舌紅苔黃，脈象細數是邪熱漸傷陰分之侯，治宜清瀉肺中鬱熱，平喘止咳","","1. 辨證要點：本方是治療肺有伏火之咳喘的常用方。臨床以咳喘氣急、皮膚蒸熱、舌紅苔黃、脈細數為辨證要點。 2. 現代運用：常用於支氣管炎、肺炎初期、小兒麻疹初期等屬肺中伏火，氣陰漸傷者。 3. 注意事項：風寒咳嗽或肺虛喘咳者不宜使用本方","葶藶大棗瀉肺湯《金匱要略》葶藶子熬令色黃，搗丸如彈子大 (9g) 大棗十二枚 (4枚) 上藥先以水三升煮棗，取二升，去棗，內葶藶，煮取一升，頓服。功用：瀉肺行水，下氣平喘。主治：痰水壅實之咳喘胸滿","瀉白桑皮地骨皮，粳米甘草扶肺氣， 清瀉肺熱平和劑，熱伏肺中喘咳醫")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("47","清胃散","Qing Wei San","Stomach-Heat-Clearing Powder","清熱劑","《脾胃論》","生地黃 當歸身各三分 (各6g) 牡丹皮半錢 (9g) 黃連六分，夏月倍之 (6g) 升麻一錢 (9g)","上藥為細末，都作一服，水一盞半，煎至七分，去滓，放冷服之 (現代用法：作湯劑，水煎服)","清胃涼血","胃火牙痛。牙痛牽引頭疼，其齒喜冷惡熱，口氣熱臭，或有面頰發熱、口乾舌燥，甚或牙宣出血，或牙齦紅腫潰爛，或唇舌腮頰腫痛，舌紅苔黃，脈滑數","本方證是由胃有積熱，火鬱血熱，循經上攻所致。足陽明胃經循鼻入上齒，分佈於耳前、前額並繞口唇；手陽明大腸經上頰貫頰絡下齒，胃火血熱，循經上攻，則見牙齒疼痛，唇舌腮頰腫痛，口氣熱臭，口乾舌燥，甚至牙齦潰爛。牙齒因熱而痛，得冷則痛減，遇熱則痛劇，因而喜冷惡熱；足陽明胃經循發際上額顱，故牙痛延及額顱面頰發熱，牙痛牽引頭痛。胃為多氣多血之腑，胃火熾盛，傷及血絡，故見牙宣出血；舌紅苔黃，脈滑而數為胃火熾盛之征。本方證病機特點是胃火血熱，循經上攻","","1. 辨證要點：本方為治胃火血熱所致牙痛、牙宣諸症的常用方。臨床以牙痛牽引頭疼、其齒喜冷惡熱、口氣熱臭、舌紅苔黃、脈滑數為辨證要點。 2. 現代運用：本方常用於口腔炎、牙周炎、三叉神經痛、痤瘡等屬胃火血熱，循經上攻者。 3. 注意事項：牙痛屬風寒及腎虛火炎者不宜","瀉黃散《小兒藥證直訣》(又名瀉脾散) 藿香葉七錢 (21g) 山梔仁一錢 (3g) 石膏五錢 (15g) 甘草三兩 (90g) 防風四兩，去蘆，切，焙 (120g) 上藥銼，同蜜、酒微炒香，為細末。每服一至二錢 (3~6g)，水一盞，煎至五分，溫服清汁，無時。功用：瀉脾胃伏火。主治：脾胃伏火證。口瘡口臭，煩渴易饑，口燥唇乾，舌紅脈數，以及脾熱弄舌等","清胃散中當歸連，生地丹皮升麻全， 或加石膏瀉胃火，能消牙痛與牙宣")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("48","玉女煎","Yu Nu Jian","Jade Lady Decoction","清熱劑","《景嶽全書》","石膏三至五錢 (9~15g) 熟地三至五錢或一兩 (9~30g) 麥冬二錢 (6g) 知母 牛膝各一錢半 (各5g)","上藥用水一盅半，煎七分，溫服或冷服 (現代用法：水煎服)","清胃熱，滋腎陰","胃熱陰虛證。牙痛，頭痛，齒松甚或牙衄，煩熱乾渴，舌紅苔黃而乾。亦治消渴，消穀善饑等","本方主治少陰不足，陽明有餘之證。陽明之脈上行頭面，陽明胃熱有餘，循經上攻，則見頭痛，牙痛；熱傷胃經血絡，則牙齦出血；少陰腎水不足，則牙齒鬆動；胃主受納，胃熱有餘，則消穀易饑；熱傷陰津，故見煩熱乾渴，舌紅苔黃且乾。此為火盛水虧相因為病，而以胃熱為主。立法組方應清胃熱為主，兼滋腎陰","","1. 辨證要點：本方是治療胃熱陰虛牙痛、牙衄、消渴的常用方。臨床以牙痛齒松、煩熱乾渴、舌紅苔黃而乾為辨證要點。 2. 現代運用：本方常用於牙齦炎、糖尿病、急性口腔炎、舌炎等屬胃熱陰虛者。 3. 注意事項：脾虛便溏者，不宜使用本方","","玉女石膏叔地黃，知母麥冬牛膝襄， 腎虛胃火相為病，牙痛齒衄宜煎嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("49","葛根黃芩黃連湯","Ge Gen Huang Qin Huang Lian Tang","Pueraria/ Scutellaria/ and Coptis Decoction","清熱劑","《傷寒論》","葛根半斤 (15g，先煎) 甘草二兩，炙 (6g) 黃芩三兩 (9g) 黃連三兩 (9g)","上四味，以水八升，先煮葛根，減二升，內諸藥，煮取二升，去滓，分溫再服 (現代用法：水煎服)","解表清裏","協熱下利。身熱下利，臭穢稠粘，肛門灼熱，喘而汗出，胸脘煩熱，口乾作渴，小便黃赤，舌紅苔黃，脈數","本方所治協熱下利是因太陽表證誤下，表邪內陷陽明大腸所致。尤怡指出：「其邪陷於裏者十之七，而留於表者十之三。」大腸熱盛，腸失傳導，故身熱下利，臭穢稠粘，肛門有灼熱感；肺與大腸相表裏，腸熱上蒸於肺則作喘，外蒸於肌表則汗出；熱盛津傷則胸悶煩熱、口乾作渴、小便黃赤短少；舌紅苔黃，脈數，皆為裏熱偏盛之象。本方證病機特點是表邪未盡，大腸熱盛，傳導失司，迫肺蒸表。立法組方應外解肌表未盡之邪，內清大腸已熾之熱","","1. 辨證要點：本方是治療熱瀉、熱痢的常用方，無論有無表證皆可使用。臨床以身熱下利、臭穢稠粘、肛門灼熱、舌紅苔黃、脈數為辨證要點。 2. 現代運用：本方常用於急性胃腸炎、慢性非特異性潰瘍性結腸炎、出血性腸炎、細菌性痢疾、麻疹下利、秋季腹瀉、小兒中毒性腸炎、阿米巴痢疾、腸傷寒、糖尿病以及惡性腫瘤化療後腹瀉等辨證屬腸熱下利者。 3. 注意事項：虛寒下利者忌用本方","","葛根芩連甘草伍，用時先將葛根煮， 內清腸熱外解表，協熱下利喘汗除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("50","芍藥湯","Shao Yao Tang","Peony Decoction","清熱劑","《素問病機氣宜保命集》","芍藥一兩 (30g) 當歸半兩 (15g) 黃連半兩 (15g) 檳榔 木香 甘草炒，各二錢 (各6g) 大黃三錢 (9g) 黃芩半兩 (15g) 官桂二錢半 (5g)","上藥㕮咀，每服半兩，水二盞，煎至一盞，食後溫服 (現代用法：水煎服)","清腸燥濕，調氣和血","濕熱痢疾。痢下赤白相兼，腹痛，裏急後重，肛門灼熱，小便短赤，舌苔黃膩，脈弦數","本方所治痢疾是由濕熱積滯壅塞腸中，氣血不和而致。濕熱熏灼大腸，傳導失司，氣血壅滯，腸絡受損，故下痢膿血，赤白相兼；積滯阻結腸中，腑氣通降不利，則腹痛、裏急後重；肛門灼熱，小便短赤，舌苔黃膩，脈象弦數等俱為濕熱內蘊之象。針對濕熱積滯壅塞，大腸氣血不和之病機特點，以及腹痛、裏急後重、痢下赤白三大主症，原書立法強調「行血則便膿自愈，調氣則後重自除」《素問病機氣宜保命集》，即突出行血調氣，並結合清熱燥濕，兼以攻積導滯","","1. 辨證要點：本方為治療大腸濕熱、氣血不和所致痢疾的常用方。臨床以痢下赤白相兼、腹痛、裏急後重、舌苔黃膩為辨證要點。 2. 現代運用： 本方常用於細菌性痢疾、阿米巴痢疾、過敏性結腸炎、急性腸炎等屬大腸濕熱、氣血不和者。 3. 注意事項：痢疾初起有表證，虛寒性下痢者，均應忌用本方","黃芩湯《傷寒論》黃芩三兩 (9g) 芍藥二兩 (9g) 甘草二兩，炙 (3g) 大棗十二枚 (4枚) 擘上四味，以水一斗，煮取三升，去滓；溫服一升，日再，夜一服。功用：清熱止利，和中止痛。主治：熱瀉熱痢。身熱、口苦、腹痛下利，舌紅苔黃，脈數","芍藥湯內用檳黃，芩連歸桂草木香， 重在調氣煎行血，裏急便膿自然康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("51","白頭翁湯","Bai Tou Weng Tang","Pulsatilla Decoction","清熱劑","《傷寒論》","白頭翁二兩 (15g) 黃柏三兩 (12g) 黃連三兩 (6g) 秦皮三兩 (12g)","上藥四味，以水七升，煮取二升，去滓，溫服一升，不愈再服一升 (現代用法：水煎服)","清熱解毒，涼血止痢","熱毒血痢。下痢鮮豔膿血，腹痛，裏急後重，肛門灼熱，渴欲飲水，舌紅苔黃，脈滑數","本方證是因濕熱疫毒壅滯大腸，深陷血分所致。濕熱疫毒熏灼大腸，損傷腸絡，故下痢鮮豔膿血；下迫大腸，則肛門灼熱；阻滯氣機，則腹痛、裏急後重。熱毒傷津，故渴欲飲水。舌紅苔黃、脈滑數為熱毒熾盛之象。本方證病因為濕熱疫毒，病位在大腸血分，立法組方應清熱燥濕，涼血解毒","","1. 辨證要點：本方為治療熱毒血痢之常用方。臨床以下痢鮮豔膿血、腹痛、裏急後重、舌紅苔黃、脈滑數為辨證要點。 2. 現代運用：本方常用於急性細菌性痢疾、阿米巴痢疾、慢性非特異性潰瘍性結腸炎屬濕熱毒邪偏盛者。 3. 注意事項：素體脾胃虛寒者慎用本方","","白頭翁治熱毒痢，黃連黃柏佐秦皮， 清熱解毒並涼血，赤多白少膿血醫")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("52","青蒿鱉甲湯","Qing Hao Bie Jia Tang","Sweet Wormwood and Turtle Shell Decoction","清熱劑","《溫病條辨》","青蒿二錢 (9g，後下或泡服) 鱉甲五錢 (15g，先煎) 細生地四錢 (12g) 知母二錢 (6g) 丹皮三錢 (9g)","水五杯，煮取二杯，日再服 (現代用法：水煎服)","養陰透熱","陰傷邪伏證。夜熱早涼，熱退無汗，舌紅苔少，脈細數","本方證為溫病後期，陰液已傷，餘熱未盡，深伏陰分所致。人體衛陽之氣，日行於表而夜入於裏。陰分本有伏熱，夜晚陽氣入陰，兩陽相加，陰不制陽，故入夜身熱。白晝衛氣外行於表，陽出於陰，則熱退身涼；然雖熱退身涼，但邪熱仍深伏陰分，不從表解，加之邪熱久伏，陰液耗傷，無源作汗，故熱退而無汗。舌紅苔少，脈細數，皆為陰虛有熱之象。針對陰傷邪伏下焦陰分之病機特點，故立法組方當養陰與透邪並進","","1. 辨證要點：本方為用治溫病後期，陰傷邪伏的常用方。臨床以夜熱早涼、熱退無汗、舌紅少苔、脈細數為辨證要點。 2. 現代運用： 本方可用於原因不明的發熱、各種傳染病恢復期低熱、慢性腎盂腎炎、腎結核以及小兒夏季熱等屬陰虛內熱，低熱不退者。 3. 注意事項：陰虛欲作動風者不宜使用","","青蒿鱉甲知地丹，熱自陰來仔細看， 夜熱早涼無汗出，養陰透熱服之安")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("53","清骨散","Qing Gu San","Bone-Clearing Powder","清熱劑","《證治準繩》","銀柴胡一錢五分 (5g) 胡黃連 秦艽 鱉 甲醋炙 地骨皮 青蒿 知母各一錢 (各3g) 甘草五分 (2g)","水二盅，煎八分，食遠服 (現代用法：水煎服)","清虛熱，退骨蒸","肝腎陰虛，虛火內擾證。骨蒸潮熱，或低熱日久不退，形體消瘦，唇紅顴赤，困倦盜汗，或口渴心煩，舌紅少苔，脈細數等","本方證由肝腎陰虛，虛火內擾所致。陰虛則生內熱，虛熱蘊蒸，發為骨蒸潮熱、心煩口渴、虛火上炎則唇紅顴赤；虛火迫津外泄，故夜寐汗出；真陰虧損，不能充養肌膚，日久遂致形體消瘦；舌紅少苔，脈象細數均為陰虛內熱之侯。因本方證重點是虛火為患，而虛火不降則陰愈虧，陰愈虧則火愈熾，故治以情虛熱為主，佐以滋陰","","1. 辨證要點：本方為治療骨蒸勞熱的常用方。臨床應用以骨蒸潮熱、形瘦盜汗、舌紅少苔、脈細數為辨證要點。 2. 現代運用：本方可用於結核病，或其他慢性消耗疾病的發熱骨蒸屬陰虛內熱者","艽鱉甲散《衛生寶鑒》地骨皮 柴胡 鱉甲去裙，酥炙，用九肋者，各一兩 (9g) 秦艽 知母 當歸各半兩 (各5g) 上藥為粗末，每服五錢 (15g)，水一盞，青蒿五葉，烏梅一個，煎至七分，去滓。空心，臨臥溫服。功用：滋陰養血，清熱除蒸。主治：陰虧血虛，風邪傳裏化熱之風勞病。骨蒸盜汗，肌肉消瘦，唇紅頰赤，口乾咽燥，午後潮熱，咳嗽，困倦，舌紅少苔脈細數","清骨散君銀柴胡，胡連秦艽鱉甲輔， 地骨青蒿知母草，骨蒸勞熱一併除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("54","當歸六黃湯","Dang Gui Liu Huang Tang","Chinese Angelica Six Yellow Decoction","清熱劑","《蘭室秘藏》","當歸 生地黃 黃芩 黃柏 黃連 熟地黃各等分 (各6g) 黃芪加一倍 (12g)","上藥為粗末，每服五錢 (15g)，水二盞，煎至一盞，食前服，小兒減半服之 (現代用法：水煎服)","滋陰瀉火，固表止汗","陰虛火旺之盜汗。發熱盜汗，面赤心煩，口乾唇燥，大便乾結，小便黃赤，舌紅苔黃，脈數","本方所治盜汗乃陰虛火旺所致。心屬火，腎屬水，正常情況下，水火既濟，心腎相交。若腎陰虧虛，腎水不能上濟心火，則心火獨亢，從而形成陰虛火旺證。且陰愈虛火愈旺，火旺則迫津外泄，陰液不守，故發熱盜汗；虛火上炎，則見面赤心煩；陰津內耗，可見口乾唇燥，大便乾結，小便黃赤；舌紅苔黃，脈數皆內熱之象。本方證病機特點是陰血不足，心火偏旺，迫津外泄，衛氣易損。故立法組方當滋陰養血，清熱瀉火，益氣固表","當歸六黃湯方證既已陰虛火旺、火熱內擾，何以更用甘溫的黃芪？ 本方證是屬陰虛火旺，火熱內擾，但汗出過多亦損衛氣，且寐時陽入於陰，衛氣亦相對不足。此時若單純滋陰瀉火，其汗亦難以收止，惟有加用益氣固表之品，方能使陰復熱清、表固汗止，此黃芪必用之理也。再者，黃芪與當歸相伍益氣生血，可使氣血充腠理密，而不致汗泄；與三黃相伍則不僅有甘寒以瀉火之意，而且可防止三黃苦寒傷中。可見本方使用黃芪，非但不至於助火傷陰，而且有助於養陰止汗，並可防止三黃苦寒傷中","1. 辨證要點：本方是治療陰虛火旺盜汗之常用方。臨床以盜汗面赤、心煩口乾、舌紅、脈數為辨證要點。 2. 現代運用：本方可用於甲狀腺機能亢進、結核病、糖尿病、更年期綜合征等屬陰虛火旺者。 3. 注意事項：對於陰虛而火不甚，或脾胃虛弱而納減便溏者，不宜使用本方","","火炎汗出六黃湯，歸柏芩連二地黃， 倍用黃芪為固表，滋陰清熱斂汗強")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("55","清絡飲","Qing Luo Yin","Channel-Clearing Beverage","祛暑劑","《溫病條辨》","鮮荷葉邊二錢 (6g) 鮮銀花二錢 (6g) 絲瓜皮二錢 (6g) 西瓜翠衣二錢 (6g) 鮮扁豆花一枝 (6g) 鮮竹葉心二錢 (6g)","以水二杯，煮取一杯，日二服 (現代用法：水煎服) ","祛暑清熱","暑傷肺經氣分輕證。身熱口渴不甚，頭目不清，昏眩微脹，舌淡紅，苔薄白","本方為治暑熱傷肺輕證的常用方。暑熱輕微，邪淺病輕，津傷未甚；故身熱口渴不甚；暑熱上擾清竅，乃致頭目不清，昏眩微脹；舌淡紅，苔薄白亦為邪淺病輕之象。傷暑輕證，治療不必重劑，只宜辛涼芳香輕藥以祛暑清熱","","1. 辨證要點：本方是治療暑熱傷肺輕證的常用方。臨床身熱口渴不甚，頭目不清，舌苔薄白為辨證要點。 2. 現代運用：本方適用於暑溫中的輕淺之證。 3. 注意事項：若暑溫表寒較重，或熱渴大汗，或汗多脈散大，喘咳欲脫者，均不宜使用","","清絡祛暑六藥仙，銀扁翠衣瓜絡添， 佐以竹葉荷葉邊，暑熱傷肺輕證安")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("56","香薷散","Xiang Ru San","Mosla Powder","祛暑劑","《太平惠民和劑局方》","香薷去土一斤 (500g) 白扁豆微炒 厚樸去粗皮薑制，各半斤 (250g)","上為粗末，每服三錢 (9g)，水一盞，入酒一分，煎七分，去滓，水中沉冷。連吃二服，不拘時候 (現代用法：水煎服，或加酒少量同煎，用量按原方比例酌減) ","祛暑解表，化濕和中","陰暑。惡寒發熱，頭重身痛，無汗，腹痛吐瀉，胸脘痞悶，舌苔白膩，脈浮","本方為治夏月乘涼飲冷，外感於寒，內傷於濕的常用方。夏月人多貪涼露臥，加之腠理疏鬆，每易感受寒濕邪氣，寒濕外束，腠理閉塞，衛陽被鬱，故惡寒發熱無汗、脈浮；寒濕困束肌表，氣血受阻，則頭重身痛；夏月易食生冷，傷及脾胃，氣機失暢，故胸脘痞悶、腹痛；濕困脾胃，升降失司、胃氣上逆則嘔吐，濕濁下注大腸則泄瀉；舌苔白膩，乃寒濕之侯。治宜外散肌表之寒濕，內化脾胃之濕滯","","1. 辨證要點：本方為夏月乘涼飲冷，外感於寒，內傷於濕的常用方。臨床以惡寒發熱，頭重身痛，無汗，胸悶，苔白膩，脈浮為辨證要點。 2. 現代運用：現代用於治療夏季感冒、急性胃腸炎等屬外感風寒夾濕者。 3. 注意事項：若屬表虛有汗或中暑發熱汗出，心煩口渴者，均不宜使用","新加香薷飲《溫病條辨》香薷二錢 (6g) 銀花三錢 (9g) 鮮扁豆花三錢 (9g) 厚樸二錢 (6g) 連翹二錢 (6g) 水五杯，煮取二杯，先服一杯，得汗，止後服，不汗再服，服盡不汗，更作服。功用：祛暑解表，清熱化濕。主治：暑溫夾濕，復感於寒證。發熱頭痛，惡寒無汗，口渴面赤，胸悶不舒，舌苔白膩，脈浮而數者","三物香薷豆樸先，散寒化濕功效兼， 若益銀翹豆易花，新加香薷祛暑煎")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("57","六一散","Liu Yi San","Six-to-One Powder","祛暑劑","《黃帝素問宣明論方》","滑石六兩 (180g) 甘草一兩 (30g)","為細末，每服三錢 (9g)，加蜜少許，溫水調下，或無蜜亦可，每日三服。或欲冷飲者，新井泉調下亦得 (現代用法：為細末。每服9~18g，包煎，或溫開水調下，日2~3服，亦常加入其他方藥中煎服)","清暑利濕","暑濕證。身熱煩渴，小便不利，或泄瀉","本方為治暑濕證的基礎方，外感暑熱、內傷暑濕為致病因素。暑為陽邪而通於心，傷於暑者，多見身熱、心煩；暑熱傷津，則見口渴。暑多夾濕，濕阻於裏，膀胱氣化不利，故小便不利；濕迫大腸，則為泄瀉。治宜清暑利濕","","1. 辨證要點：本方為治暑熱兼濕熱所致小便不利的基礎方。臨床應用以身熱煩渴，小便不利為辨證要點。 2. 現代運用：本方可用於膀胱炎、尿道炎等屬濕熱證者。 3. 注意事項：若陰虛，內無濕熱，或小便清長者忌用","1. 益元散《傷寒直格》即六一散加辰砂，燈心湯調服。功用：清心解暑，兼能安神。主治：暑濕證兼心悸怔忡，失眠多夢者。 2. 碧玉散《傷寒直格》即六一散加青黛，令如淺碧色。功用：清解暑熱。主治：暑濕證兼有肝膽鬱熱者。 3. 雞蘇散《傷寒直格》即六一散加薄荷。功用：疏風解暑。主治：暑 濕證兼微惡風寒，頭痛頭脹，咳嗽不爽者","六一散用滑石草，清暑利濕有功效， 益元碧玉與雞蘇，砂黛薄荷加之好")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("58","桂苓甘露飲","Gui Ling Gan Lu Yin","Cinnamon and Poria Sweet Dew Beverage","祛暑劑","《黃帝素問宣明論方》","茯苓一兩 (30g) 甘草二兩，炙 (60g) 白朮半兩 (15g) 澤瀉一兩 (30g) 官桂去皮，二兩 (15g) 石膏二兩 (60g) 寒水石二兩 (60g) 滑石四兩 (120g) 豬苓半兩 (15g)","上為末，每服三錢 (9g)，溫湯調下，新汲水亦得，生薑湯尤良。小兒每服一錢 (3g)，用如上法 (現代用法：亦可做湯劑，水煎服，用量按原方比例酌減)","清暑解熱，化氣利濕","暑濕證。發熱頭痛，煩渴引飲，小便不利，及霍亂吐下","本方為治暑濕重證的常用方。外受暑熱，故發熱頭痛；熱盛傷津，則煩渴引飲；濕盛於裏，膀胱氣化不利，故見小便不利；暑濕俱盛，內傷脾胃，升降失司，清濁相干，則為「霍亂吐下」。治宜清解暑熱與化氣利小便並用","","1. 辨證要點：本方是祛暑利濕的常用方。臨床以發熱頭痛、煩渴引飲、小便不利為辨證要點。 2. 現代運用：本方常用於中暑、尿路感染屬暑濕者。 3. 注意事項：本方清暑利濕之力強，故主要用於暑濕重證。若一般的傷暑輕證，或汗瀉過多，氣液大傷均不宜使用","","桂苓甘露豬苓膏，朮澤寒水滑石草， 祛暑清熱以利濕，發熱煩渴吐瀉消")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("59","清暑益氣湯","Qing Shu Yi Qi Tang","Summerheat-Clearing Qi-Boosting Decoction","祛暑劑","《溫熱經緯》","西洋參 (5g) 石斛 (15g) 麥冬 (9g) 黃連 (3g) 竹葉 (6g) 荷梗 (15g) 知母 (6g) 甘草 (3g) 粳米 (15g) 西瓜翠衣 (30g) (原書未著用量)","水煎服","清暑益氣，養陰生津","暑熱氣津兩傷證。身熱汗多，口渴心煩，小便短赤，體倦少氣，精神不振，脈虛數","本方為治暑熱氣津兩傷之常用方，病因為暑熱內侵，耗氣傷津所致。暑為陽邪而通於心，暑熱傷人則身熱；暑熱擾心則心煩；暑性升散，使腠理開泄，故見汗多；熱傷津液，故口渴、尿少而黃；暑易耗氣，故見體倦少氣、精神不振、脈虛。王士雄云：「暑傷氣陰，以清暑熱而益元氣，無不應手取效。」《溫熱經緯》薛生白濕熱病篇，故立法組方當清熱祛暑與益氣生津並舉","","1. 辨證要點：本方用於夏月傷暑，氣陰兩傷之證。臨床以體倦少氣、口渴汗多、脈虛數為辨證要點。 2. 現代運用：本方可用於夏月傷暑、小兒及老人夏季熱、支氣管哮喘夏季發作、肺炎及多種急性傳染病恢復期等辨證屬中暑受熱、氣津兩傷者。 3. 注意事項：本方因有滋膩之品，故暑病夾濕者不宜使用本方","清暑益氣湯《脾胃論》黃芪汗少，減五分 蒼朮泔浸，去皮 以上各一錢五分 (4.5g) 升麻一錢 (3g) 人參去蘆 澤瀉 炒曲 橘皮 白朮以上各五分 (各2g) 麥門冬去心 當歸身 炙甘草以上各三分 (各2g) 青皮去白，二分半 (1.5g) 黃柏酒洗，去皮，二分或三分 (2g) 葛根二分 (1.5g) 五味子九枚 (2g) 水煎服。功用：清暑益氣，除濕健脾。主治：平素氣虛，又受暑濕。身熱頭痛，口渴自汗，四肢困倦，不思飲食，胸滿身重，大便溏薄，小便短赤，苔膩，脈虛者","王氏清暑益氣湯，善治中暑氣津傷， 洋參冬斛荷瓜翠，連竹知母甘粳襄")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("60","理中丸","Li Zhong Wan","Center-Regulating Pill","溫裏劑","《傷寒論》","人參 乾薑 炙甘草 白朮各三兩 (各90g)","上四味，搗篩，蜜和為丸，如雞子黃許大 (9g)。以沸湯數合，和一丸，研碎，溫服之，日三四服，夜二服。腹中未熱，益至三四丸，然不及湯。湯法：以四物依兩數切，用水八升，煮取三升，去滓，溫服一升，日三服。服湯後，如食頃，飲熱粥一升許，微自溫，勿發揭衣被。(現代用法：上4藥共研細末，煉蜜為丸，重9克，每次1丸，溫開水送服，每日2~3次。或作湯劑，水煎服，用量以原方比例酌減)","溫中祛寒，補氣健脾","1. 脾胃虛寒證。脘腹綿綿作痛，喜溫喜按，嘔吐，大便稀溏，脘痞食少，畏寒肢冷，口不渴，舌淡苔白潤，脈沉細或沉遲無力。 2. 脾陽虛失血證。便血、吐血、衄血或崩漏等，血色暗淡，質清稀。 3. 脾胃虛寒所致的胸痹，兼見胸脘痞滿，逆氣上沖心胸；或病後多涎唾；或小兒慢驚等","本方所治諸症皆由脾胃虛寒所致。中陽不足，寒從中生，陽虛失溫，寒性凝滯，故畏寒肢涼，脘腹綿綿作痛，喜溫喜按。脾主運化而升清，胃主受納而降濁，今脾胃虛寒，納運升降失常，故脘痞食少，嘔吐，便溏。舌淡苔白潤，口不渴，脈沉細或沉遲無力皆為虛寒之象。治宜溫中祛寒，益氣健脾","","1. 辨證要點：本方是治療中焦脾胃虛寒證的基礎方。臨床應用以脘腹綿綿作痛，嘔吐便溏、畏寒肢涼，舌淡，苔白，脈沉細為辨證要點。 2. 現代運用：本方適用於急、慢性胃腸炎、胃及十二指腸潰瘍、胃痙攣、胃下垂、胃擴張、慢性結腸炎等屬脾胃虛寒者。 3. 注意事項：濕熱內蘊中焦，或脾胃陰虛者禁用","1. 附子理中九《太平惠民和劑局方》附子 炮，去皮、臍 人參去蘆 乾薑炮 炙甘草 白朮 各三兩 (各90g) 上為細末，煉蜜為丸，每兩作十丸。每服一丸 (6g)，以水一盞，化開，煎至七分，稍熱服之，空心食前。功用：溫陽祛寒，補氣健脾。主治：脾胃虛寒較甚，或脾腎陽虛證。脘腹疼痛，下利清稀，噁心嘔吐，畏寒肢涼，或霍亂吐利轉筋等。 2. 桂枝人參湯《傷寒論》桂枝四兩，別切 (12g) 甘草四兩，炙 (9g) 白朮三兩 (9g) 人參三兩 (9g) 乾薑三兩 (9g) 上五味，以水九升，先煮四味，取五升，納桂更煮，取三升，去滓，溫服一升，日再夜一服。功用：溫陽健脾，解表散寒。主治：脾胃虛寒，復感風寒表證。惡寒發熱，頭身疼痛，腹痛，下利便溏，口不渴，舌淡苔白滑，脈浮虛者","理中丸主溫中陽，甘草人參朮乾薑， 吐利腹痛陰寒盛，或加附子更扶陽")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("61","小建中湯","Xiao Jian Zhong Tang","Minor Center-Fortifying Decoction","溫裏劑","《傷寒論》","桂枝三兩，去皮 (9g) 甘草二兩，炙 (6g) 大棗十二枚，擘 (6枚) 芍藥六兩，(18g) 生薑三兩，切 (9g) 膠飴一升 (30g)","上六味，以水七升，煮取三升，去滓，納飴，更上微火消解。溫服一升，日三服 (現代用法：水煎取汁，兌入飴糖，文火加熱溶化，分兩次溫服)","溫中補虛，和裏緩急","中焦虛寒，肝脾不和證。腹中拘急疼痛，喜溫喜按，神疲乏力，虛怯少氣；或心中悸動，虛煩不寧，面色無華；或伴四肢酸楚，手足煩熱，咽乾口燥；舌淡苔白，脈細弦","病證因中焦虛寒，肝脾失和，化源不足所致。中焦虛寒，肝木乘土，故腹中拘急疼痛，喜溫喜按。脾胃為氣血生化之源，中焦虛寒，化源匱乏，氣血俱虛，故見心悸、面色無華、發熱、口燥咽乾等。症雖不同，病本則一，總由中焦虛寒所致。治當溫中補虛而兼養陰，和裏緩急而能止痛","","1. 辨證要點：本方既是溫中補虛，緩急止痛之劑，又為調和陰陽，柔肝理脾之常用方。臨床以腹中拘急疼痛，喜溫喜按，舌淡，脈細弦為辨證要點。 2. 現代運用：本方適用於胃及十二指腸潰瘍、慢性肝炎、慢性胃炎、神經衰弱、再生障礙性貧血、功能性發熱等屬中焦虛寒，肝脾不和者。 3. 注意事項：嘔吐或中滿者不宜使用；陰虛火旺之胃脘疼痛忌用","1. 黃芪建中湯《金匱要略》桂枝三兩，去皮 (9g) 甘草二兩，炙 (6g) 大棗十二枚，擘 (6枚) 芍藥六兩，(18g) 生薑三兩，切 (9g) 膠飴一升 (30g) 黃芪一兩半 (5g) 煎服法同小建中湯。功用：溫中補氣，和裏緩急。主治：陰陽氣血俱虛證。裏急腹痛，喜溫喜按，形體羸瘦，面色無華，心悸氣短，自汗盜汗。 2. 當歸建中湯《千金翼方》當歸四兩 (12g) 桂心三兩 (9g) 炙甘草二兩 (6g) 芍藥六兩 (18g) 生薑三兩 (9g) 大棗12枚 (6枚) 擘 上六味 咀，以水一斗，煮取三升，分為三服，一日令盡。若大虛，加飴糖六兩 (30g) 作湯成，內之於火上暖，令飴糖消。功用：溫補氣血，緩急止痛。主治：產後虛羸不足，腹中痛不已，吸吸少氣，或小腹拘急攣痛引腰背，不能飲食者。 3. 大建中湯《金匱要略》蜀椒二合，去汗 (6g) 乾薑四兩 (12g) 人參二兩 (6g) 上三味，以水四升，煮取二升，去滓，內膠飴一升 (30g)，微火煮取一升半，分溫再服，如一炊頃，可飲粥二升，後更服，當一日食糜，溫覆之。功用：溫中補虛，降逆止痛。主治：中陽衰弱，陰寒內盛之脘腹劇痛證。腹痛連及胸脘，痛勢劇烈，其痛上下走竄無定處，或腹部時見塊狀物上下攻撐作痛，嘔吐劇烈，不能飲食，手足厥冷，舌質淡，苔白滑，脈沉伏而遲","小建中湯芍藥多，桂枝甘草薑棗和， 更加飴糖補中臟，虛勞腹痛服之瘥")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("62","吳茱萸湯","Wu Zhu Yu Tang","Evodia Decoction","溫裏劑","《傷寒論》","吳茱萸一升，洗 (9g) 人參三兩 (9g) 生薑六兩，切 (18g) 大棗十二枚，擘 (4枚)","上四味，以水七升，煮取二升，去滓。溫服七合，日三服 (現代用法：水煎服)","溫中補虛，降逆止嘔","肝胃虛寒，濁陰上逆證。食後泛泛欲嘔，或嘔吐酸水，或乾嘔，或吐清涎冷沫，胸滿脘痛，巔頂頭痛，畏寒肢涼，甚則伴手足逆冷，大便泄瀉，煩躁不寧，舌淡苔白滑，脈沉弦或遲","本方治證乃肝胃虛寒，濁陰上逆所致。肝胃虛寒，胃失和降，濁陰上逆，故食後泛泛欲吐，或嘔吐酸水，或乾嘔，或吐清涎冷沫。厥陰之脈挾胃屬肝，上行與督脈會於頭頂部。胃中濁陰循肝經上擾於頭，故巔頂頭痛。濁陰阻滯，氣機不利，故胸滿脘痛。肝胃虛寒，陽虛失溫，故畏寒肢冷。脾胃同居中焦，胃病及脾，脾不升清，則大便泄瀉。舌淡苔白滑，脈沉弦而遲等均為虛寒之象。治療當以溫中補虛，降逆止嘔","","1. 辨證要點：本方是治療肝胃虛寒、濁陰上逆的常用方。以食後欲吐，或巔頂頭痛，乾嘔吐涎沫，畏寒肢涼，舌淡苔白滑，脈弦細而遲為辨證要點。 2. 現代運用：本方適用於慢性胃炎、妊娠嘔吐、神經性嘔吐、神經性頭痛、耳源性眩暈等屬肝胃虛寒者。 3. 注意事項：胃熱嘔吐、陰虛嘔吐或肝陽上亢之頭痛禁用本方","","吳茱萸湯參棗薑，肝胃虛寒此法良， 陽明寒嘔少陰利，厥陰頭痛亦堪嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("63","四逆湯","Si Ni Tang","Frigid Extremities Decoction","溫裏劑","《傷寒論》","甘草二兩，炙 (6g) 乾薑一兩半 (6g) 附子一枚，生用，去皮，破八片 (15g)","上三味，以水三升，煮取一升二合，去滓，分溫再服。強人可大附子一枚，乾薑三兩 (現代用法：水煎服)","回陽救逆","心腎陽虛寒厥證。四肢厥逆，惡寒踡臥，神衰欲寐，面色蒼白，腹痛下利，嘔吐不渴，舌苔白滑，脈微細","本方治證乃心腎陽虛，陰寒內盛之候。陽氣不能溫煦周身四末，故四肢厥逆，惡寒踡臥；不能鼓動血行，故脈微細。《素問》生氣通天論曰：「陽氣者，精則養神，柔則養筋」。今心陽衰微，神失所養，則神衰欲寐。腎陽衰微，不能暖脾，升降失調，則腹痛吐利。此陽衰陰盛之證，非純陽大辛大熱之品，不足以破陰寒，回陽氣，救厥逆","","1. 辨證要點：本方是回陽救逆的基礎方，臨床應用以四肢厥逆，神衰欲寐，面色蒼白，脈微細為辨證要點。 2. 現代運用：本方常用於心肌梗塞、心力衰竭、急性胃腸炎吐瀉過多、或某些急證大汗而見休克，屬陽衰陰盛者。 3. 注意事項：若服藥後出現嘔吐拒藥者，可將藥液置涼後服用。本方純用辛熱之品，中病手足溫和即止，不可久服。真熱假寒者忌用","1. 通脈四逆湯《傷寒論》甘草二兩，炙 (6g) 附子大者一枚，生用，去皮，破八片 (20g) 乾薑三兩，強人可四兩 (9~12g) 上三味，以水三升，煮取一升二合，去滓，分溫再服，其脈即出者愈。功用：破陰回陽，通達內外。主治：少陰病，陰盛格陽證。下利清穀，裏寒外熱，手足厥逆，脈微欲絕，身反不惡寒，其人面色赤，或腹痛，或乾嘔，或咽痛，或利止，脈不出者。若 「吐已下斷，汗出而厥，四肢拘急不解，脈微欲絕者」，加豬膽汁半合 (5ml)，名 「通脈四逆加豬膽汁湯」。「分溫再服，其脈即來。無豬膽，以羊膽代之」。 2. 四逆加人參湯《傷寒論》甘草二兩，炙 (6g) 附子一枚，生用，去皮，破八片 (15g) 乾薑一兩半 (9g) 人參一兩 (6g) 上四味，以水三升，煮取一升二合，去滓。分溫再服。功用：回陽救逆，益氣固脫。主治：少陰病。四肢厥逆，惡寒踡臥，脈微而復自下利，利雖止而餘證仍在者。 3. 白通湯《傷寒論》蔥白四莖 乾薑一兩 (6g) 附子一枚，生，去皮，破八片 (15g) 上三味，以水三升，煮取一升，去滓。分溫再服。功用：破陰回陽，宣通上下。主治：少陰病，陰盛戴陽證。手足厥逆，下利，脈微，面赤者。若 「利不止，厥逆無脈，乾嘔，煩者」，加豬膽汁一合 (5ml)，人尿五合 (25ml)，名 「白通加豬膽汁湯」。 4. 參附湯《正體類要》人參四錢 (12g) 附子炮，去皮，臍，三錢 (9g) 用水煎服，陽氣脫陷者，倍用之。功用：益氣回陽固脫。主治：陽氣暴脫證。四肢厥逆，冷汗淋漓，呼吸微弱，脈微欲絕","四逆湯中附草薑，四肢厥逆急煎嘗， 脈微吐利陰寒盛，救逆回陽賴此方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("64","回陽救急湯","Hui Yang Jiu Ji Tang","Yang-Returning Emergency Decoction","溫裏劑","《傷寒六書》","熟附子 (9g) 乾薑 (6g) 人參 (6g) 炙甘草 (6g) 白朮炒 (9g) 肉桂 (3g) 陳皮 (6g) 五味子 (3g) 茯苓 (9g) 半夏制 (9g)","水二盅，薑三片，煎之，臨服入麝香三厘 (0.1g) 調服。中病以手足溫和即止，不得多服 (現代用法：水煎服，麝香沖服)","回陽固脫，益氣生脈","寒邪直中三陰，真陽衰微證。四肢厥冷，神衰欲寐，惡寒踡臥，吐瀉腹痛，口不渴，甚則身寒戰慄，或指甲口唇青紫，或吐涎沫，舌淡苔白，脈沉微，甚或無脈","本方證是由寒邪直中三陰，陰寒內盛，真陽衰微欲脫所致。素體陽虛，寒邪直中，三陰受寒，故腹痛、吐瀉、肢厥、神衰、脈微俱見；身寒戰栗，唇指青紫，無脈乃陰寒內盛，陽微欲脫之兆。治當回陽固脫，益氣生脈","","1. 辨證要點：本方是治療寒邪直中三陰，真陽衰微證的常用方。臨床應用以四肢厥冷，神衰欲寐，下利腹痛，脈微或無脈為辨證要點。 2. 現代運用：本方常用於急性胃腸炎吐瀉過多、休克、心力衰竭等屬亡陽欲脫者。 3. 注意事項：方中麝香用量不宜過大。服藥後手足溫和即止","回陽急救湯《重訂通俗傷寒論》黑附塊三錢 (9g) 紫瑤桂五分 (1.5g) 別直參二錢 (6g) 原麥冬三錢，辰砂染，(9g) 川薑二錢 (6g) 薑半夏一錢 (3g) 湖廣朮錢半 (5g) 北五味三分 (1g) 炒廣皮八分 (3g) 清炙草八分 (3g) 真麝香三厘 (0.1g) 沖水煎服。功用：回陽救逆，益氣生脈。主治：少陰病，陽衰陰竭證。下利脈微，甚則利不止，肢厥無脈，乾嘔心煩者","回陽救急用六君，桂附乾薑五味尋， 加麝三厘或膽汁，三陰寒厥建奇勳")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("65","當歸四逆湯","Dang Gui Si Ni Tang","Chinese Angelica Frigid Extremities Decoction","溫裏劑","《傷寒論》","當歸三兩 (12g) 桂枝三兩，去皮 (9g) 芍藥三兩 (9g) 細辛三兩 (3g) 甘草二兩，炙 (6g) 通草二兩 (6g) 大棗二十五枚，擘 (8枚)","上七味，以水八升，煮取三升，去滓。溫服一升，日三服 (現代用法：水煎服)","溫經散寒，養血通脈","血虛寒厥證。手足厥寒，或腰、股、腿、足、肩臂疼痛，口不渴，舌淡苔白，脈沉細或細而欲絕","本方主治營血虛弱，寒凝經脈，血行不利之證。素體血虛而又經脈受寒，寒邪凝滯，血行不利，陽氣不能達於四肢末端，營血不能充盈血脈，遂呈手足厥寒，脈細欲絕。此手足厥寒只是指掌至腕、踝不溫，與四肢厥逆有別。治當溫經散寒，養血通脈","","1. 辨證要點：本方是養血溫經散寒的常用方。臨床應用以手足厥寒，舌淡苔白，脈細欲絕為辨證要點。 2. 現代運用：本方適用於血栓閉塞性脈管炎、無脈症、雷諾氏病、小兒麻痹、凍瘡、婦女痛經、肩周炎、風濕性關節炎等屬血虛寒凝者","1. 當歸四逆加吳茱萸生薑湯《傷寒論》當歸三兩 (12g) 芍藥三兩 (9g) 甘草二兩，炙 (6g) 通草二兩 (6ｇ) 桂枝三兩，去皮 (9g) 細辛三兩 (3g) 生薑半斤，切 (12g) 吳茱萸二升 (9g) 大棗二十五枚，擘 (8枚) 上九味，以水六升，清酒六升和，煮取五升，去滓，溫分五服。功用：溫經散寒，養血通脈，和中止嘔。主治：血虛寒凝，手足厥冷，兼寒邪在胃，嘔吐腹痛者。 2. 黃芪桂枝五物湯《金匱要略》黃芪三兩 (9g) 芍藥三兩 (9g) 桂枝三兩 (9g) 生薑六兩 (18g) 大棗十二枚 (4枚) 上五味，以水六升，煮取二升，溫服七合，日三服。功用：益氣溫經，和血通痹。主治：血痹，肌膚麻木不仁，脈微澀而緊者","當歸四逆芍桂枝，細辛甘草木通施， 血虛寒厥四末冷，溫經通脈最相宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("66","陽和湯","Yang He Tang","Harmonious Yang Decoction","溫裏劑","《外科證治全生集》","熟地黃一兩 (30g) 麻黃五分 (2g) 鹿角膠三錢 (9g) 白芥子二錢，炒研 (6g) 肉桂一錢去皮，研粉 (3g) 生甘草一錢 (3g) 炮薑炭五分 (2g)","水煎服","溫陽補血，散寒通滯","陰疽。如貼骨疽、脫疽、流注、痰核、鶴膝風等屬陰寒證者。症見患處漫腫無頭，皮色不變，酸痛無熱，口中不渴，舌淡苔白，脈沉細或遲細","陰疽一證多由素體陽虛，營血不足，寒凝痰滯，痹阻於肌肉、筋骨、血脈而成。陰寒為病故局部腫勢彌漫，皮色不變，酸痛無熱，並可伴有全身虛寒症狀，舌淡苔白，脈沉細亦為虛寒之象。治宜溫陽補血，散寒通滯","","1. 辨證要點：本方是治療陰疽的常用方。臨床應用以患處漫腫無頭，皮色不變，酸痛無熱為辨證要點。 2. 現代運用：本方常用於治療骨結核、腹膜結核、慢性骨髓炎、骨膜炎、慢性淋巴結炎、類風濕性關節炎、血栓閉塞性脈管炎、肌肉深部膿瘍等屬陰寒凝滯者。 3. 注意事項：方中熟地用量宜重，麻黃用量宜輕；陽證瘡瘍紅腫熱痛，或陰虛有熱，或疽已潰破者，不宜使用本方。馬培之云：「此方治陰證，無出其右，用之得當，應手而愈。乳岩萬不可用，陰虛有熱及破潰日久者，不可沾唇。」《重校外科證治全生集》卷4","小金丹《外科證治全生集》白膠香 草烏 五靈脂 地龍 木鱉各制末，一兩五錢 (各150g) 沒藥 歸身 乳香各淨末，七錢五分 (各75g) 麝香三錢 (15g) 墨炭一錢二分 (12g) 以糯米粉一兩二錢，為厚糊，和入諸末，搗千捶，為丸如芡實大。此一料，約為二百五十丸，曬乾忌烘，固藏，臨用取一丸，布包放平石上，隔布敲細入杯內，取好酒幾匙浸藥。用小杯合蓋，約浸一二時，以銀物加研，熱陳酒送服，醉蓋取汗。如流注初起，及一應痰核、瘰鬁、乳岩、橫痃，初起服，消乃止。幼孩不能服煎劑及丸子者，服之甚妙。如流注等證，將潰及潰者，當以十丸均作五日服完，以杜流走不定，可絕增入者。但丸內有五靈脂與人參相反，不可與有參之藥同日而服。功用：化痰除濕，祛瘀通絡。主治：寒濕痰瘀所致的流注、痰核、瘰癘、乳岩、橫痃、貼骨疽、膳拱頭等病，初起膚色不變，腫硬作痛者","陽和湯法解寒凝，貼骨流注鶴膝風， 熟地鹿膠薑炭桂，麻黃白芥甘草從")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("67","四君子湯","Si Jun Zi Tang","Four Gentlemen Decoction","補益劑","《太平惠民和劑局方》","人參去蘆 (9g) 白朮 (9g) 茯苓去皮 (9g) 炙甘草 (6g) 各等分","上為細末。每服二錢 (15g)，水一盞，煎至七分，通口服，不拘時候；入鹽少許，白湯點亦得 (現代用法：水煎服)","益氣健脾","脾胃氣虛證。面色萎白，語聲低微，氣短乏力，食少便溏，舌淡苔白，脈虛弱","本方主治之虛乃脾胃氣虛，運化乏力。脾胃為後天之本，氣血生化之源，脾胃氣虛，受納與健運乏力，則飲食減少；濕濁內生，故大便溏薄；脾主肌肉，脾胃氣虛，四肢肌肉無所稟受，故四肢乏力；氣血生化不足，血不足不榮於面，而見面色萎白；脾為肺之母，脾胃一虛，肺氣先絕，故見氣短，語聲低微；舌淡苔白，脈虛弱，皆為氣虛之象。治宜補益脾胃之氣，以復其運化受納之功","","1. 辨證要點：本方為治療脾胃氣虛證的常用方，亦是補氣的基礎方，後世眾多補脾益氣方劑多從此方衍化而來。臨床應用以面白，食少，氣短，四肢乏力，舌淡苔白，脈虛弱為辨證要點。 2. 現代運用：本方適用於慢性胃炎、胃及十二指腸潰瘍等屬脾氣虛者","1. 異功散《小兒藥證直訣》人參切，去頂 茯苓去皮 白朮 陳皮銼 甘草各等分 (各6g) 上為細末，每服二錢 (6g)，水一盞，加生薑五片，大棗二個，同煎至七分，食前溫服，量多少與之。功用：益氣健脾，行氣化滯。主治：脾胃氣虛兼氣滯證。飲食減少，大便溏薄，胸脘痞悶不舒，或嘔吐泄瀉等。現多用於小兒消化不良屬脾虛氣滯者。 2. 六君子湯《醫學正傳》即四君子湯加陳皮一錢 (3g) 半夏一錢五分 (4.5g) 上為細末，作一服，加大棗二枚，生薑三片，新汲水煎服。功用：益氣健脾，燥濕化痰。主治：脾胃氣虛兼痰濕證。食少便溏，胸脘痞悶，嘔逆等。 3. 香砂六君子湯《古今名醫方論》人參一錢 (3g) 白朮二錢 (6g) 甘草七分 (2g) 陳皮八分 (2.5g) 半夏一錢 (3g) 砂仁八分 (2.5g) 木香七分 (2g) 上加生薑二錢 (6g)，水煎服。功用：益氣化痰，行氣溫中。主治：脾胃氣虛，痰阻氣滯證。嘔吐痞悶，不思飲食，脘腹脹痛，消瘦倦怠，或氣虛腫滿。 4. 保元湯《博愛心鑒》黃芪三錢 (9g) 人參一錢 (3g) 炙甘草一錢 (3g) 肉桂五分 (1.5g) (原書無用量，今據《景嶽全書》補) 上加生薑一片，水煎，不拘時服。功用：益氣溫陽。主治：虛損勞怯，元氣不足證。倦怠乏力，少氣畏寒，以及小兒痘瘡，陽虛頂陷，不能發起灌漿者","四君子湯中和義，參朮茯苓甘草比， 益以夏陳名六君，祛痰補益氣虛餌， 除卻半夏名異功，或加香砂氣滯使")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("68","參苓白朮散","Shen Ling Bai Zhu San","Ginseng/ Poria and Atractylodes Macrocephala Powder","補益劑","《太平惠民和劑局方》","蓮子肉去皮，一斤 (500g) 薏苡仁一斤 (500g) 縮砂仁一斤 (500g) 桔梗炒令深黃色，一斤 (500g) 白扁豆薑汁浸，去皮，微炒，一斤半 (750g) 白茯苓二斤 (1000g) 人參二斤 (1000g) 甘草炒，二斤 (1000g) 白朮二斤 (1000g) 山藥二斤 (1000g)","上為細末。每服二錢 (6g)，大棗湯調下。小兒量歲數加減服之 (現代用法：作湯劑，水煎服，用量按原方比例酌減)","益氣健脾，滲濕止瀉","脾虛濕盛證。飲食不化，胸脘痞悶，腸鳴泄瀉，四肢乏力，形體消瘦，面色萎黃，舌淡苔白膩，脈虛緩","胃主納穀，脾司運化。脾胃虛弱，受納運化乏力，故飲食不化；水穀不化，清濁不分，故見腸鳴泄瀉；濕滯中焦，氣機被阻，而見胸脘痞悶；脾失健運，則氣血生化不足，肢體肌膚失於濡養，故四肢無力，形體消瘦，面色萎黃。治宜補益脾胃，兼以滲濕","關於桔梗的配伍意義 本方用桔梗，用意有三，一則開宣肺氣，借肺之布散精微而濡養全身；二則通調水道，水道通利則濕有出路；三則載諸補脾藥上行，用作舟楫，疏精於肺，以奏 「培土生金」 之功","1. 辨證要點：本方藥性平和，溫而不燥，臨床應用除脾胃氣虛症狀外，以泄瀉、舌苔白膩，脈虛緩為辨證要點。 2. 現代運用：常用於慢性胃腸炎、貧血、慢性支氣管炎、慢性腎炎及婦女帶下病等屬脾虛濕盛者","七味白朮散《小兒藥證直訣》人參二錢五分 (6g) 茯苓、炒白朮各五錢 (各12g) 甘草一錢 (3g) 藿香葉五錢 (12g) 木香二錢 (6g) 葛根五錢至一兩 (15~30g) 為粗末，每服二錢 (6g)，水煎服。功用：健脾益氣，和胃生津。主治：脾胃虛弱，津虛內熱證。嘔吐泄瀉，肌熱煩渴","參苓白朮扁豆陳，山藥甘蓮砂薏仁， 桔梗上浮兼保肺，棗湯調服益脾神")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("69","補中益氣湯","Bu Zhong Yi Qi Tang","Center-Supplementing and Qi-Boosting Decoction","補益劑","《內外傷辨惑論》","黃芪病甚、勞役熱甚者一錢 (18g) 炙甘草，各五分 (9g) 人參去蘆，三分 (6g) 當歸酒焙乾或曬乾，二分 (3g) 橘皮不去白，二分或三分 (6g) 升麻二分或三分 (6g) 柴胡二分或三分 (6g) 白朮三分 (9g)","上㕮咀，都作一服，水二盞，煎至一盞，去滓，食遠稍熱服 (現代用法：水煎服。或作丸劑，每服10~15g，日2~3次，溫開水或薑湯下)","補中益氣，升陽舉陷","1. 脾虛氣陷證。飲食減少，體倦肢軟，少氣懶言，面色萎黃，大便稀溏，舌淡，脈虛以及脫肛、子宮脫垂、久瀉、久痢、崩漏等。 2. 氣虛發熱證。身熱，自汗，渴喜熱飲，氣短乏力，舌淡，脈虛大無力","本方治證系因飲食勞倦，損傷脾胃，以致脾胃氣虛，清陽下陷所致。脾胃為營衛氣血生化之源，脾胃氣虛，受納與運化不及，故飲食減少，少氣懶言，大便稀薄；脾主升清，脾虛則清陽不升，中氣下陷，故見脫肛、子宮下垂等。氣虛不能固表，陽浮於外，故身熱自汗。治宜補益脾胃中氣，升陽舉陷","關於氣虛發熱： 本方證中的身熱為氣虛發熱，有別於外感發熱。其發熱之機理主要是脾胃元氣虛餒，升降失常，清陽下陷，脾濕下流，下焦陽氣鬱而生熱上沖。治療這種發熱，「惟當以甘溫之劑，補其中，升其陽，甘寒以瀉其火則愈」。「蓋溫能除大熱，大忌苦寒之藥瀉胃土耳！今立補中益氣湯」《內外傷辨惑論》。因陽氣下陷而不上升，內鬱而不能外達而發熱，用甘溫之品益氣升陽，使清陽復位而熱自除，故而補中益氣湯為 「甘溫除熱」 的代表方","1. 辨證要點：本方為為補氣升陽，甘溫除熱的代表方。以體倦乏力，少氣懶言，面色萎黃，脈虛軟無力為辨證要點。 2. 現代運用：本方臨床應用範圍甚廣，如內臟下垂、久瀉、久痢、脫肛、重症肌無力、乳糜尿、慢性肝炎等；婦科之子宮脫垂、妊娠及產後癃閉、胎動不安、月經過多；眼科之眼瞼下垂、麻痹性斜視等，屬脾胃氣虛或中氣下陷者，均可加減應用。 3. 注意事項：陰虛發熱及內熱熾盛者忌用","1. 升陽益胃湯《內外傷辨惑論》黃芪二兩 (30g) 半夏湯洗 人參去蘆 炙甘草，各一兩 (15g) 獨活 防風 白芍藥 羌活各五錢 (各9g) 橘皮四錢 (6g) 茯苓 柴胡 澤瀉 白朮 各三錢 (各5g) 黃連一錢 (1.5g) 上口父咀，每服三錢至五錢 (15g)，加生薑五片，大棗二枚，用水三盞，煎至一盞，去滓，早飯後溫服。功用：益氣升陽，清熱除濕。主治：脾胃氣虛，濕鬱生熱證。怠惰嗜臥，四肢不收，肢體重痛，口苦舌乾，飲食無味，食不消化，大便不調。 2. 升陷湯《醫學衷中參西錄》生黃芪六錢 (18g) 知母三錢 (9g) 柴胡一錢五分 (4.5g) 桔梗一錢五分 (4.5g) 升麻一錢 (3g) 水煎服。功用：益氣升陷。主治：大氣下陷證。氣短不足以息，或努力呼吸，有似乎喘，或氣息將停，危在頃刻，脈沉遲微弱，或三伍不調。 3. 舉元煎《景嶽全書》人參三至五錢 (10~20g) 黃芪炙，三至五錢 (10~20g) 炙甘草一至二錢 (3~6g) 升麻五至七分 (4g) 白朮一至二錢 (3~6g) 水一盅半，煎七、八分，溫服。如兼陽氣虛寒者，桂、附、乾薑俱宜佐用。如兼滑脫者，加烏梅一個，或文蛤七、八分。功用：益氣升提。主治：氣虛下陷，血崩血脫，亡陽垂危等證","補中益氣芪朮陳，升柴參草當歸身， 升陽舉陷功獨擅，氣虛發熱亦堪珍")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("70","生脈散","Sheng Mai San","Pulse-Engendering Powder","補益劑","《醫學啟源》","人參五分 (9g) 麥門冬五分 (9g) 五味子七粒 (6g)","長流水煎，不拘時服 (現代用法：1劑煎3次，1天服完)","益氣生津，斂陰止汗","1. 溫熱、暑熱，耗氣傷陰證。汗多神疲，體倦乏力，氣短懶言，咽乾口渴，舌乾紅少苔，脈虛數。 2. 久咳傷肺，氣陰兩虛證。乾咳少痰，短氣自汗，口乾舌燥，脈虛細","本方所治為溫熱、暑熱之邪，耗氣傷陰，或久咳傷肺，氣陰兩虛之證。溫暑之邪襲人，熱蒸汗泄，最易耗氣傷津，導致氣陰兩傷之證。肺主皮毛，暑傷肺氣，衛外失固，津液外泄，故汗多；肺主氣，肺氣受損，故氣短懶言；陰傷而津液不足以上承，則咽乾口渴，氣陰兩傷，機體失於濡養，而見神疲乏力。舌乾紅少苔，脈虛數或虛細，乃氣陰兩傷之象。咳嗽日久傷肺，氣陰不足者，亦可見上述徵象，治宜益氣養陰生津","","1. 辨證要點：本方是治療氣陰兩虛證的常用方。以體倦，氣短，咽乾，舌紅，脈虛為辨證要點。 2. 現代運用：對於肺結核，慢性支氣管炎，神經衰弱所致咳嗽和心煩失眠，以及心臟病心律不齊屬氣陰兩虛者，均可加減應用。生脈散經劑型改革後製成的生脈注射液，經藥理研究證實，具有毒性小、安全度大的特點，臨床常用於治療急性心肌梗死、心源性休克、中毒性休克、失血性休克及冠心病、內分泌失調等病屬氣陰兩虛者。 3. 注意事項：若屬外邪未解，或暑病熱盛，氣陰未傷者，均不宜用。久咳肺虛，亦應在陰傷氣耗，純虛無邪時，方可使用","","生脈麥味與人參，益氣養陰效力神， 氣少汗多兼口渴，病危脈絕急煎斟")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("71","玉屏風散","Yu Ping Feng San","Jade Wind-Barrier Powder","補益劑","《醫方類聚》","防風一兩 (30g) 黃芪蜜炙 白朮各二兩 (各60g)","上㕮咀，每服三錢 (9g)，用水一盞半，加大棗一枚，煎至七分，去滓，食後熱服","益氣固表止汗","表虛自汗。汗出惡風，面色白光白，舌淡苔薄白，脈浮虛。亦治虛人腠理不固，易感風邪","本方主治衛氣虛弱，不能固表之證。衛虛腠理不密，則易為風邪所襲，故時自惡風而易於感冒；表虛失固，營陰不能內守，津液外泄，則常自汗；面色㿠白，舌淡苔薄白，脈浮虛。皆為氣虛之象。治宜益氣扶正，固表止汗","","1. 辨證要點：本方為治療表虛自汗的常用方劑。除自汗惡風外，以面色白光白，舌淡脈虛為辨證要點。 2. 現代運用：本方常用於過敏性鼻炎、上呼吸道感染屬表虛不固而外感風邪者，腎小球腎炎易於傷風感冒而誘致病情反復者，亦可加減用之。 3. 注意事項：若屬外感自汗或陰虛盜汗，則不宜使用","","玉屏風散最有靈，芪朮防風鼎足形， 表虛汗多易感冒，益氣固表止汗神")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("72","完帶湯","Wan Dai Tang","Discharge-Ceasing Decoction","補益劑","《傅青主女科》","白朮一兩 (30g) 土炒 山藥一兩 (30g) 炒 人參二錢 (6g) 白芍五錢 (15g) 酒炒 車前子三錢 (9g) 酒炒 蒼朮二錢 (9g) 制 甘草一錢 (3g) 陳皮五分 (2g) 黑芥穗五分 (2g) 柴胡六分 (2g)","水煎服","補脾疏肝，化濕止帶","脾虛肝鬱，濕濁帶下。帶下色白，清稀如涕，面色白光白，倦怠便溏，舌淡苔白，脈緩或濡弱","本方為治療白帶的常用方劑，所主病證乃由脾虛肝鬱，帶脈失約，濕濁下注所致。脾虛生化之源不足，氣血不能上榮於面，故面色白光白；脾失健運，水濕內停，清氣不升，故見倦怠便溏；脾虛肝鬱，濕濁下注，帶脈不固，故見帶下色白量多，清稀如涕；舌淡白，脈濡弱為脾虛濕盛之象。治宜補脾益氣，疏肝解鬱，化濕止帶","","1. 辨證要點：本方為治脾虛白帶之常用方。以帶下清稀色白、舌淡苔白、脈濡緩為辨證要點。 2. 現代運用：本方適用於陰道炎、宮頸糜爛、盆腔炎而屬脾虛肝鬱，濕濁下注者。 3. 注意事項：黃帶而屬肝鬱化熱，濕熱下注者，非本方所宜","","完帶湯中二朮陳，車前甘草和人參， 柴芍淮山黑芥穗，化濕止帶此方金")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("73","四物湯","Si Wu Tang","Four Substances Decoction","補益劑","《仙授理傷續斷秘方》","當歸去蘆，酒浸炒 (9g) 川芎6g 白芍9g 熟乾地黃酒蒸 (熟地黃已有成品，乾地黃即生地黃曬乾，(12g) 各等分","上為粗末。每服三錢 (15g)，水一盞半，煎至八分，去渣，空心食前熱服 (現代用法：作湯劑，水煎服)","補血調血","營血虛滯證。頭暈目眩，心悸失眠，面色無華，婦人月經不調，量少或經閉不行，臍腹作痛，甚或瘕塊硬結，舌淡，口唇、爪甲色淡，脈細弦或細澀","本方是補血調經的主方，是從《金匱要略》中的芎歸膠艾湯減去阿膠、艾葉、甘草而成。本方治證由營血虧虛，血行不暢，沖任虛損所致。血虛與心、肝兩臟關係最為密切。肝藏血，血虛則肝失所養，無以上榮，故頭暈目眩；心主血，藏神，血虛則心神失養，故心悸失眠；營血虧虛，則面部、唇舌、爪甲等失於濡養，故色淡無華，沖為血海，任主胞胎，沖任虛損，肝血不足，加之血行不暢，則月經不調，可見月經量少，色淡，或前或後，甚或經閉不行等症；血虛則血脈無以充盈，血行不暢易致血瘀，可見臍腹疼痛，甚或瘕塊硬結；脈細澀或細弦為營血虧虛，血行不暢之象。治宜補養營血為主，輔以調暢血脈","","1. 辨證要點：本方在《仙授理傷續斷秘方》中治外傷瘀血作痛，宋代《太平惠民和劑局方》用於婦人諸疾。本方是補血調經的基礎方。以面色無華、唇甲色淡、舌淡、脈細為辨證要點。 2. 現代運用：本方常用於婦女月經失調、胎產疾病，蕁麻疹等慢性皮膚病，骨傷科疾病，以及過敏性紫癜、神經性頭痛等，凡屬營血虛滯者。 3. 注意事項：對於陰虛發熱，以及血崩氣脫之證，非其所宜","1. 桃紅四物湯《醫壘元戎》，錄自《玉機微義》。原名 「加味四物湯」 即四物湯加桃仁 (9g) 紅花 (6g) 水煎服。功用：養血活血。主治：血虛兼血瘀證。婦女經期超前，血多有塊，色紫稠粘，腹痛等。 2. 膠艾湯 (又名芎歸膠艾湯《金匱要略》。川芎二兩 (6g) 阿膠二兩 (6g) 甘草二兩 (6g) 艾葉三兩 (9g) 當歸三兩 (9g) 芍藥四兩 (12g) 乾地黃六兩 (15g) 以水五升，清酒三升，合煮，取三升，去滓，內膠令消盡，溫服一升，日三服。不瘥更作。功用：養血止血，調經安胎。主治：婦人沖任虛損，血虛有寒證。崩漏下血，月經過多，淋漓不止。產後或流產損傷沖任，下血不絕；或妊娠胞阻，胎漏下血，腹中疼痛。 3. 聖愈湯《醫宗金鑒》熟地七錢五分 (20g) 白芍酒拌，七錢五分 (15g) 川芎 七錢五分 (8g) 人參七錢五分 (一般用潞黨參20g) 當歸酒洗，五錢 (15g) 黃芪五錢，炙 (18g)，水煎服。功用：補氣，補血，攝血。主治：氣血虛弱，氣不攝血證。月經先期而至，量多色淡，四肢乏力，體倦神衰之證","四物地芍與歸芎，血家百病此方宗， 婦女經病憑加減，臨症之時可變通")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("74","當歸補血湯","Dang Gui Bu Xue Tang","Chinese Angelica Blood-Supplementing Decoction","補益劑","《內外傷辨惑論》","黃芪一兩 (30g) 當歸酒洗，二錢 (6g)","以水二盞，煎至一盞，去滓，空腹時溫服","補氣生血","血虛陽浮發熱證。肌熱面紅，煩渴欲飲，脈洪大而虛，重按無力，亦治婦人經期、產後血虛發熱頭痛，或瘡瘍潰後，久不癒合者","本方治證為勞倦內傷，血虛氣弱，陽氣浮越所致。血虛氣弱，陰不維陽，故肌熱面赤，煩渴引飲。此種煩渴，常時煩時止，渴喜熱飲；脈洪大而虛，重按無力，是血虛氣弱，陽氣浮越之象，是血虛發熱的辨證關鍵。血虛導致陽氣外浮，出現假熱證象，此時有形之血不能速生，無形之氣所當急固，應將補氣固表作為治療重點，使氣充表固，陽氣不再外浮，假熱證象才可消失","","1. 辨證要點：本方為補氣生血之基礎方，也是體現李東垣 「甘溫除熱」 治法的代表方。應用時除肌熱，口渴喜熱飲、面紅外，以脈大而虛、重按無力為辨證要點。 2. 現代運用：本方適用於各種貧血、過敏性紫癜等屬血虛氣弱者。 3. 注意事項：陰虛潮熱證忌用","","當歸補血東垣箋，黃芪一兩歸二錢， 血虛發熱口煩渴，脈大而虛宜此煎")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("75","歸脾湯","Gui Pi Tang","Spleen-Restoring Decoction","補益劑","《正體類要》","白朮 當歸 白茯苓 黃芪炒 遠志 龍眼肉 酸棗仁炒，各一錢 (3g) 人參一錢 (6g) 木香五分 (1.5g) 炙甘草，三分 (1g)","加生薑、大棗，水煎服","益氣補血，健脾養心","1. 心脾氣血兩虛證。心悸怔仲，健忘失眠，盜汗虛熱，體倦食少，面色萎黃，舌淡，苔薄白，脈細弱。 2. 脾不統血證。便血，皮下紫癜，婦女崩漏，月經超前，量多色淡，或淋漓不止，舌淡，脈細弱","本方證因思慮過度，勞傷心脾，氣血虧虛所致。心藏神而主血，脾主思而統血。思慮過度，心脾氣血喑耗，脾氣虧虛，則體倦，食少，虛熱；心血不足，則見驚悸、怔忡，健忘，不寐，盜汗；面色萎黃，舌質淡，苔薄白，脈細緩，均屬氣血不足之象。上述諸證雖屬心脾兩虛，卻是以脾虛為核心，氣血虧虛為基礎","","1. 辨證要點：本方是治療心脾氣血兩虛的常用方。以心悸失眠、體倦食少、便血及崩漏、舌淡、脈細弱為辨證要點。 2. 現代運用：本方適用於胃及十二指腸潰瘍出血、功能性子宮出血、再生障礙性貧血、血小板減少性紫癜、神經衰弱、心臟病等屬心脾氣血兩虛及脾不統血者","","歸脾湯用朮參芪，歸草茯神遠志隨， 酸棗木香龍眼肉，煎加薑棗益心脾， 怔忡健忘俱可卻，便血崩漏總能醫")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("76","八珍湯","Ba Zhen Tang","Eight-Gem Decoction","補益劑","《瑞竹堂經驗方》","人參 白朮 白茯苓 當歸 川芎 白芍藥 熟地黃 甘草 炙 各一兩 (30g)","上㕮咀，每服三錢 (9g)，水一盞半，加生薑五片，大棗一枚，煎至七分，去滓，不拘時候，通口服 (現代用法：或作湯劑，加生薑3片，大棗5枚，水煎服，用量根據病情酌定)","益氣補血","氣血兩虛證。面色蒼白或萎黃，頭暈耳眩，四肢倦怠，氣短懶言，心悸怔忡，飲食減少，舌淡苔薄白，脈細弱或虛大無力","本方所治氣血兩虛證多由久病失治、或病後失調、或失血過多而致，病在心、脾、肝三臟。心主血，肝藏血，心肝血虛，故見面色蒼白或萎黃，頭暈目眩，心悸怔忡，舌淡脈細；脾主運化而化生氣血，脾氣虛，故面黃肢倦，氣短懶言，飲食減少，脈虛無力。治宜益氣與養血並重","","1. 辨證要點：本方是治療氣血兩虛證的常用方。以氣短乏力，心悸眩暈，舌淡，脈細無力為辨證要點。 2. 現代運用：本方適用於病後虛弱、各種慢性病，以及婦女月經不調等屬氣血兩虛者","1. 十全大補湯《太平惠民和劑局方》人參去蘆 (6g) 肉桂去皮 (3g) 川芎 (6g) 乾熟地黃 (12g) 茯苓 (9g) 白朮 (9g) 甘草炒 (3g) 黃芪 (12g) 當歸去蘆 (9g) 白芍藥 (9g) 各等分 上為細末，每服二大錢 (9g)，用水一盞，加生薑三片、棗子二個，同煎至七分，不拘時候溫服。功用：溫補氣血。主治：氣血兩虛證。面色萎黃，倦怠食少，頭暈目眩，神疲氣短，心悸怔忡，自汗盜汗，四肢不溫，舌淡，脈細弱。以及婦女崩漏，月經不調，瘡瘍不斂等。 2. 人參養榮湯 (原名養榮湯)《三因極一病證方論》黃芪 當歸 桂心 炙甘草 橘皮 白朮 人參各一兩 (各30g) 白芍藥三兩 (90g) 熟地黃 (9g) 五味子 茯苓各三分 (各4g) 遠志去心，炒，半兩 (15g) 上銼為散，每服四大錢 (12g)，用水一盞半，加生薑三片，大棗二個，煎至七分，去滓，空腹服。功用：益氣補血，養心安神。主治：心脾氣血兩虛證。倦怠無力，食少無味，驚悸健忘，夜寐不安，虛熱自汗，咽乾唇燥，形體消瘦，皮膚乾枯，咳嗽氣短，動則喘甚，或瘡瘍潰後氣血不足，寒熱不退，瘡口久不收斂。 3. 泰山磐石散《古今醫統大全》人參一錢 (3g) 黃芪一錢 (6g) 白朮二錢 (6g) 炙甘草五分 (2g) 當歸二錢 (3g) 川芎八分 (2g) 白芍藥八分 (3g) 熟地黃八分 (3g) 川續斷一錢 (3g) 糯米一撮 (6g) 黃芩一錢 (3g) 砂仁五分 (1.5g) 上用水一盅半，煎至七分，食遠服。但覺有孕，三五日常用一服，四月之後，方無慮也。功用：益氣健脾，養血安胎。主治：墮胎、滑胎。胎動不安，或屢有墮胎宿疾，面色淡白，倦怠乏力，不思飲食，舌淡苔薄白，脈滑無力","四君四物加薑棗，八珍雙補氣血方， 再加黃芪與肉桂，十全大補效增強")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("77","炙甘草湯","Zhi Gan Cao Tang","Honey-Fried Licorice Decoction","補益劑","《傷寒論》","甘草四兩，炙 (12g) 生薑三兩，切 (9g) 桂枝三兩，去皮 (9g) 人參二兩 (6g) 生地黃一斤 (50g) 阿膠二兩 (6g) 麥門冬半升，去心 (10g) 麻仁半升 (10g) 大棗三十枚，擘 (10枚)","上以清酒七升，水八升，先煮八味，取三升，去滓，內膠烊消盡，溫服一升，日三服 (現代用法：水煎服，阿膠烊化，沖服)","益氣滋陰，通陽復脈","1. 陰血陽氣虛弱，心脈失養證。脈結代，心動悸，虛羸少氣，舌光少苔，或質乾而瘦小者。 2. 虛勞肺痿。乾咳無痰，或咳吐涎沫，量少，形瘦短氣，虛煩不眠，自汗盜汗，咽乾舌燥，大便乾結，脈虛數","本方是《傷寒論》治療心動悸、脈結代的名方。共治證是由傷寒汗、吐、下或失血後，或雜病陰血不足、陽氣不振所致。陰血不足，血脈無以充盈，加之陽氣不振，無力鼓動血脈，脈氣不相接續，故脈結代；陰血不足，心神失養，或心陽虛弱，不能溫養心脈，故心動悸。治宜滋心陰，養心血，益心氣，溫心陽，以復脈定悸","","1. 辨證要點：本方為陰陽氣血並補之劑。以脈結代、心動悸、虛羸少氣、舌光色淡少苔為辨證要點。 2. 現代運用：本方常用於功能性心律不齊、期外收縮，有較好療效。對於冠心病、風濕性心臟病、病毒性心肌炎、甲狀腺功能亢進等而有心悸、氣短、脈結代，屬陰血不足、陽氣虛弱者，均可加減應用，並可用氣陰兩傷之虛勞乾咳等。 3. 注意事項：虛勞肺痿屬氣陰兩傷者，使用本方，是用其益氣滋陰而補肺，但對陰傷肺燥較甚者，方中薑、桂、酒減少用量或不用，因為溫藥畢竟有耗傷陰液之弊，故應慎重使用","加減復脈湯《溫病條辨》炙甘草六錢 (18g) 乾地黃六錢 (18g) 生白芍六錢 (18g) 麥冬不去心，五錢 (15g) 阿膠三錢 (9g) 麻仁三錢 (9g) 上以水八杯，煮取三杯，分三次服。功用：滋陰養血，生津潤燥。主治：溫熱病後期，邪熱久羈，陰液虧虛證。身熱面赤，口乾舌燥，脈虛大，手足心熱甚於手足背者","四逆湯中附草薑，四肢厥逆急煎嘗， 脈微吐利陰寒盛，救逆回陽賴此方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("78","六味地黃丸","Liu Wei Di Huang Wan","Six-Ingredient Rehmannia Pill","補益劑","《小兒藥證直訣》","熟地黃八錢 (24g) 山萸肉 乾山藥各四錢 (各12g) 澤瀉 牡丹皮 茯苓去皮，各三錢 (各9g)","上為末，煉蜜為丸，如梧桐子大。空心溫水化下三丸 (現代用法：亦可水煎服)","滋補肝腎","肝腎陰虛證。腰膝痠軟，頭暈目眩，耳鳴耳聾，盜汗，遺精，消渴，骨蒸潮熱，手足心熱，口燥咽乾，牙齒動搖，足跟作痛，小便淋瀝，以及小兒囟門不合，舌紅少苔，脈沉細數","腎藏精為先天之本，肝為藏血之臟，精血互可轉化，肝腎陰血不足又常可相互影響。腰為腎之府，膝為筋之府，腎主骨生髓，齒為骨之餘，腎陰不足則骨髓不充，故腰膝痠軟無力，牙齒動搖；腦為髓海，腎陰不足，不能生髓充腦，肝血不足，不能上榮頭目，故頭暈目眩；腎開竅於耳，腎陰不足，精不上承，或虛熱上擾清竅，故耳鳴耳聾；腎藏精，為封藏之本，腎陰虛則相火內擾精室，故遺精；陰虛生內熱，甚者虛火上炎，故骨蒸潮熱，消渴，盜汗，小便淋瀝，舌紅少苔，脈沉細數；小兒囟門不合，是腎虛生骨遲緩所致。治宜滋補肝腎為主，適當配伍清虛熱瀉濕濁之品","","1. 辨證要點：本方是治療肝腎陰虛證的基礎方。以腰膝痠軟，頭暈目眩，口燥咽乾，舌紅少苔，脈沉細數為辨證要點。 2. 現代運用：本方常用於慢性腎炎、高血壓病、糖尿病、肺結核、腎結核、甲狀腺功能亢進、中心性視網膜炎及無排卵性功能性子宮出血、更年期綜合征等屬肝腎陰虛者。 3. 注意事項：脾虛泄瀉者慎用","1. 知柏地黃丸《醫方考》(又名六味地黃丸加黃柏知母方) 即六味地黃丸加知母鹽炒 黃柏鹽炒各二錢 (各6g) 上為細末，煉蜜為丸，如梧桐 子大，每服二錢 (6g)，溫開水送下。功用：滋陰降火。主治：肝腎陰虛，虛火上炎證。頭目昏眩，耳鳴耳聾，虛火牙痛，五心煩熱，腰膝痠痛，血淋尿痛，遺精夢泄，骨蒸潮熱盜汗，顴紅，咽乾口噪，舌質紅，脈細數。 2. 杞菊地黃丸《麻疹全書》即六味地黃丸加枸杞子 菊花各三錢 (各9g) 上為細末，煉蜜為丸，如梧桐子大，每服三錢 (9g)，空腹服。功用：滋腎養肝明目。主治：肝腎陰虛證。兩目昏花，視物模糊，或眼睛乾澀，迎風流淚等。 3. 麥味地黃丸 (原名八味地黃丸)《醫部全錄》引《體仁彙編》即六味地黃丸加麥冬五錢 (15g) 五味子五錢 (15g) 上為細末，煉蜜為丸，如梧桐子大，每服三錢 (9g)，空腹時用白湯送下。功用：滋補肺腎。主治：肺腎陰虛證。虛煩勞熱，咳嗽吐血，潮熱盜汗。 4. 都氣丸《證因脈治》即六味地黃丸加五味子二錢 (6g) 上為細末，煉蜜為丸，如梧桐子大，每服三錢 (9g)，空腹服。功用：滋腎納氣。主治：肺腎兩虛證。咳嗽氣喘，呃逆滑精，腰痛","六味地黃益腎肝，山藥丹澤萸苓摻， 更加知柏成八味，陰虛火旺可煎餐， 養陰明目加杞菊，滋陰都氣五味研， 肺腎兩調金水生，麥冬加入長壽丸， 再入磁柴可潛陽，耳鳴耳聾俱可安")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("79","左歸丸","Zuo Gui Wan","Left-Restoring Pill","補益劑","《景嶽全書》","大懷熟地八兩 (240g) 山藥炒，四兩 (120g) 枸杞四兩 (120g) 山茱萸四兩 (120g) 川牛膝酒洗蒸熟，三兩 (90g) 鹿角膠敲碎，炒珠，四兩 (120g) 龜版膠切碎，炒珠，四兩 (120g) 菟絲子制，四兩 (120g)","上先將熟地蒸爛，杵膏，煉蜜為丸，如梧桐子大。每食前用滾湯或淡鹽湯送下百餘丸 (9g) (現代用法：亦可水煎服，用量按原方比例酌減)","滋陰補腎，填精益髓","真陰不足證。頭暈目眩，腰痠腿軟，遺精滑泄，自汗盜汗，口燥舌乾，舌紅少苔，脈細","本方治證為真陰不足，精髓虧損所致。腎藏精，主骨生髓，腎陰虧損，精髓不充，封藏失職，故頭暈目眩，腰痠腿軟，遺精滑泄；陰虛則陽亢，迫津外泄，故自汗盜汗；陰虛則津不上承，故口燥舌乾，舌紅少苔；脈細為真陰不足之象。治宜壯水之主，培補真陰","","1. 辨證要點：本方為治療真陰不足證的常用方。以頭目眩暈、腰痠腿軟，舌光少苔，脈細為辨證要點。 2. 現代運用：本方適用於老年性癡呆、更年期綜合征、老年骨質疏鬆症、閉經、月經量少等屬於腎陰不足、精髓虧虛者。 3. 注意事項：方中組成藥物以陰柔滋潤為主，久服常服，每易滯脾礙胃，故脾虛泄瀉者慎用","左歸飲《景嶽全書》熟地二三錢，或加之一二兩 (9~30g) 山藥 枸杞子各二錢 (各6g) 炙甘草一錢 (3g) 茯苓一錢半 (4.5g) 山茱萸一二錢 (3~6g)，畏酸者少用之，以水二盅，煎至七分，食遠服。功用：補益腎陰。主治：真陰不足證。腰痠遺泄，盜汗，口燥咽乾，口渴欲飲，舌尖紅，脈細數","左歸丸內山藥地，萸肉枸杞與牛膝， 菟絲龜鹿二膠合，壯水之主第一方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("80","大補陰丸","Da Bu Yin Wan","Major Yin-Supplementing Pill","補益劑","《丹溪心法》","熟地黃酒蒸 龜版酥炙，各六兩 (各180g) 黃柏炒褐色 知母酒浸，炒，各四兩 (各120g)","上為末，豬脊髓蒸熟，煉蜜為丸。每服七十丸 (6~9g) 空心鹽白湯送下 (現代用法：上4味，碾為細末，豬脊髓適量蒸熟，搗如泥狀；煉蜜，混合拌勻和藥粉為丸，每丸約重15g，每日早晚各服1丸，淡鹽水送服，或水煎服，用量按原方比例酌減)","滋陰降火","陰虛火旺證。骨蒸潮熱，盜汗遺精，咳嗽咯血，心煩易怒，足膝疼熱，舌紅少苔，尺脈數而有力","本方證是由肝腎虧虛，真陰不足，相火亢盛所致。腎為水火之臟，本應既濟以並存，真陰虧虛，則相火亢盛而生虛火、虛熱諸證，故骨蒸潮熱、盜汗遺精，足膝疼熱，甚則虛火上炎灼傷肺金，損傷肺絡，故咳嗽咯血；虛火上擾心神，則心煩易怒。治宜大補真陰以治本，佐以降火以治標，標本兼治","","1. 辨證要點：大補陰丸為滋陰降火的基礎方。以骨蒸潮熱、舌紅少苔、尺脈數而有力為辨證要點。 2. 現代運用：甲狀腺功能亢進、腎結核、骨結核、糖尿病等屬陰虛火旺者，均可應用。 3. 注意事項：若脾胃虛弱，食少便溏，以及火熱屬於實證者不宜使用","虎潛丸《丹溪心法》黃柏半斤酒炒 (240g) 龜版四兩酒炙 (120g) 知母二兩酒炒 (60g) 熟地黃 陳皮 白芍各二兩 (60g) 鎖陽一兩半 (45g) 虎骨一兩炙 (可用狗骨代) (30g) 乾薑半兩 (15g)《醫方集解》所載虎潛丸尚多當歸、牛膝、羊肉三味) 上為末，酒糊丸，一方加金箔一片，一方用生地黃，懶言語者加山藥。(現代用法：上為細末，煉蜜為丸，每丸重9g，每次1丸，日服2次，淡鹽水或溫開水送下。亦可水煎服，用量按原方比例酌減。) 功用：滋陰降火，強壯筋骨。主治：肝腎不足，陰虛內熱之痿證。腰膝痠軟，筋骨痿弱，腿足消瘦，步履乏力，或眩暈，耳鳴，遺精，遺尿，舌紅少苔，脈細弱","大補陰丸知柏黃，龜板脊髓蜜成方， 咳嗽咯血骨蒸熱，陰虛火旺制亢陽")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("81","一貫煎","Yi Guan Jian","Effective Integration Decoction","補益劑","《續名醫類案》","北沙參 麥冬 當歸身 (各9g) 生地黃 (18~30g) 枸杞子 (9~18g) 川楝子一錢半 (4.5g) (原書未著用量)","水煎服","滋陰疏肝","肝腎陰虛，肝氣鬱滯證。胸脘脅痛，吞酸吐苦，咽乾口燥，舌紅少津，脈細弱或虛弦。亦治疝氣瘕聚","肝藏血，主疏泄，體陰而用陽，喜條達而惡抑鬱。肝腎陰血虧虛，肝體失養，則疏泄失常，肝氣鬱滯，進而橫逆犯胃，故胸脘脅痛，吞酸吐苦；肝氣久鬱，經氣不利則生疝氣、瘕聚等症；陰虛津液不能上承，故咽乾口燥，舌紅少津；陰血虧虛，血脈不充，故脈細弱或虛弦。肝腎陰血虧虛而肝氣不舒，治宜滋陰養血，柔肝舒鬱","","1. 辨證要點：本方是治療陰虛氣滯而致脘脅疼痛的常用方。以脘脅疼痛、吞酸吐苦、舌紅少津、脈虛弦為辨證要點。 2. 現代運用：本方常用於治療慢性肝炎、慢性胃炎、胃及十二指腸潰瘍、肋間神經痛、神經官能症等屬陰虛氣滯者。 3. 注意事項：因本方重在滋補，雖可行無形之氣，但不能祛有形之邪，且藥多甘膩，故有停痰積飲而舌苔白膩，脈沉弦者，不宜使用","","一貫煎中生地黃，沙參歸杞麥冬藏， 少佐川楝瀉肝氣，陰虛脅痛此方良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("82","腎氣丸","Shen Qi Wan","Kidney Qi Pill","補益劑","《外科證治全生集》","乾地黃八兩 (240g) 薯蕷 (即山藥) 山茱萸各四兩 (各120g) 澤瀉 茯苓 牡丹皮各三兩 (各90g) 桂枝 附子炮各一兩 (各30g)","上為細末，煉蜜和丸，如梧桐子大，酒下十五丸 (6g)，日再服","補腎助陽","腎陽不足證。腰痛腳軟，身半以下常有冷感，少腹拘急，小便不利，或小便反多，入夜尤甚，陽痿早洩，舌淡而胖，脈虛弱，尺部沉細，以及痰飲，水腫，消渴，腳氣，轉胞等","本方治證皆由腎陽虛，命門之火不足所致。腰為腎府，腎為先天之本，內寓命門真火，為人體陽氣之根，命門火衰，溫化失常，百病叢生。腎陽不足，不能溫養下焦，故腰痛腳軟，身半以下常有冷感，少腹拘急；腎陽虛弱，不能化氣利水，水停於內，則小便不利，少腹拘急，甚或轉胞；腎陽虧虛不能蒸化水液，水液直趨下焦，津不上承，故消渴，小便反多；腎主水，腎陽虛弱，氣化失常，水液失調，留滯為患，可發為水腫、痰飲、腳氣等。病症雖多，病機均為腎陽虧虛，命火不足，所以異病同治，治宜補腎助陽為法，即王冰所謂：「益火之源，以消陰翳」之理","","1. 辨證要點：本方為補腎助陽的常用方。以腰痛腳軟、小便不利或反多、舌淡而胖、脈虛弱而尺部沉細為辨證要點。 2. 現代運用：本方常用於治療慢性腎炎、糖尿病、醛固酮增多症、甲狀腺功能低下、神經衰弱、腎上腺皮質功能減退、慢性支氣管哮喘、更年期綜合征等屬腎陽不足者。 3. 注意事項：若咽乾口燥、舌紅少苔，屬腎陰不足、虛火上炎者，不宜應用。此外，腎陽虛而小便正常者，為純虛無邪、氣化不滯，不宜用本方","1. 加味腎氣丸《濟生方》附子炮，二個 (15g) 白茯苓去皮 澤瀉 山茱萸取肉 山藥炒 車前子酒蒸 牡丹皮去木，各一兩 (各30g) 官桂不見火 川牛膝去蘆，酒浸 熟地黃各半兩 (各15g) 上為細末，煉蜜為丸，如梧桐大，每服七十丸 (9g)，空心米飲送下。功用：溫腎化氣，利水消腫。主治：腎 (陽) 虛水腫。腰重腳腫，小便不利。 2. 十補丸《濟生方》附子炮，去皮、臍 五味子各二兩 (各60g) 山茱萸取肉 山藥銼，炒 牡丹皮去木 (各60g) 鹿茸去毛，酒蒸一錢 (3g) 熟地黃洗，酒蒸二兩 (60g) 肉桂去皮，不見火一錢 (3g) 白茯苓去皮 澤瀉各一兩 (30g) 上為細末，煉蜜為丸，如梧桐 子大，每服七十丸 (9g)，空心鹽酒、鹽湯任下。功用：補腎陽，益精血。主治：腎陽虛損，精血不足證。面色黧黑，足冷足腫，耳鳴耳聾，肢體羸瘦，足膝軟弱，小便不利，腰脊疼痛","金匱腎氣治腎虛，地黃淮藥及山萸， 丹皮苓澤加桂附，水中生火在溫熙")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("83","右歸丸","You Gui Wan","Right-Restoring Pill","補益劑","《景嶽全書》","熟地黃八兩 (240g) 山藥炒，四兩 (120g) 山茱萸微炒，三兩 (90g) 枸杞子微炒，三兩 (90g) 菟絲子制，四兩 (120g) 鹿角膠炒珠，四兩 (120g) 杜仲薑汁炒，四兩 (120g) 肉桂二兩 (60g) 當歸三兩 (90g) 制附子二兩，漸可加至五六兩 (60~180g)","上先將熟地蒸爛杵膏，加煉蜜為丸，如梧桐子大。每服百餘丸 (6~9g)，食前用滾湯或淡鹽湯送下；或丸如彈子大，每嚼服二三丸 (6~9g)，以滾白湯送下 (現代用法：亦可水煎服，用量按原方比例酌減)","溫補腎陽，填精益髓","腎陽不足，命門火衰證。年老或久病氣衰神疲，畏寒肢冷，腰膝軟弱，陽痿遺精，或陽衰無子，或飲食減少，大便不實，或小便自遺，舌淡苔白，脈沉而遲","本方所治之證，病機為腎陽虛弱，命門火衰。腎為水火之臟，內寄命門之火，為元陽之根本。腎陽不足，命門火衰，失於溫煦，甚則火不生土，影響脾胃納運，故見氣衰神疲，畏寒肢冷，腰膝軟弱，或飲食減少，大便不實；腎主天癸而藏精，腎陽虛則天癸衰少、封藏失職、精關不固、宗筋失養，故見陽痿、遺精、不育或小便自遺。治宜「益火之源，以培右腎之元陽」《景嶽全書》)","","1. 辨證要點：本方為治腎陽不足，命門火衰的常用方。以神疲乏力，畏寒肢冷，腰膝痠軟，脈沉遲為辨證要點。 2. 現代運用：本方常用於治療腎病綜合征、老年骨質疏鬆症、精少不育症，以及貧血、白細胞減少症等屬腎陽不足者。 3. 注意事項：由於本方純補無瀉，故對腎虛兼有濕濁者，不宜使用","右歸飲《景嶽全書》熟地二三錢或加至一二兩 (9~30g) 山藥炒，二錢 (6g) 枸杞子二錢 (6g) 山茱萸一錢 (3g) 炙甘草，一二錢 (3g) 肉桂一二錢 (3~6g) 杜仲薑制，二錢 (9g) 制附子一二三錢 (6~9g) 上以水二盅，煎至七分，食遠溫服。功用：溫補腎陽，填精補血。主治：腎陽不足證。氣怯神疲，腹痛腰痠，手足不溫，及陽痿遺精，大便溏薄，小便頻多，舌淡苔薄，脈來虛細者，或陰盛格陽，真寒假熱之證","右歸丸中地附桂，山藥茱萸菟絲歸， 杜仲鹿膠枸杞子，益火之源此方魁")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("84","地黃飲子","Di Huang Yin Zi","Rehmannia Drink","補益劑","《聖濟總錄》","熟乾地黃焙 (12g) 巴戟天去心 山茱萸炒 石斛去根 肉蓯蓉酒浸/切焙 附子炮裂，去皮臍 五味子炒 官桂去粗皮 白茯苓去黑皮 麥門冬去心，焙 菖蒲 遠志去心，各半兩 (各15g)","上為粗末，每服三錢 (9~15g)，水一盞，加生薑三片，大棗二枚，擘破，同煎七分，去滓，食前溫服","滋腎陰，補腎陽，開竅化痰","下元虛衰，痰濁上泛之喑痱證。舌強不能言，足廢不能用，口乾不欲飲，足冷面赤，脈沉細弱","「喑痱」是由於下元虛衰，陰陽兩虧，虛陽上浮，痰濁隨之上泛，堵塞竅道所致。「喑」是指舌強不能言語，「痱」是指足廢不能行走。腎藏精主骨，下元虛衰，包括腎之陰陽兩虛，致使筋骨失養，故見筋骨痿軟無力，甚致足廢不能用；足少陰腎脈挾舌本，腎虛則精氣不能上承，痰濁隨虛陽上泛堵塞竅道，故舌強而不能言；陰虛內熱，故口乾不欲飲，虛陽上浮，故面赤；腎陽虧虛，不能溫煦於下，故足冷；脈沉細數是陰陽兩虛之象。此類病證常見年老及重病之後，治宜補養下元為主，攝納浮陽，佐以開竅化痰，宣通心氣","","1. 辨證要點：本方為治療腎虛喑痱的常用方。以舌喑不語，足廢不用，脈沉細弱為辨證要點。 2. 現代運用：本方常用於治療晚期高血壓病、腦動脈硬化、中風後遺症、脊髓炎等慢性疾病過程中出現陰陽兩虛者。 3. 注意事項：方中陰陽並補，溫而不燥，是其特長：然畢竟偏於溫補，故對氣火上升、肝陽偏亢而陽熱之象明顯者，不宜應用","","地黃飲子山茱斛，麥味菖蒲遠志茯， 蓯蓉桂附巴戟天，少入薄荷薑棗服")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("85","龜鹿二仙膠","Gui Lu er Xian Jiao","Tortoise Shell and Deer Horn Two Immortals Glue","補益劑","《醫便》","鹿角用新鮮麋鹿殺角，解的不用，馬鹿角不用，去角腦梢骨二寸絕斷，劈開，淨用十斤 (5000g) 龜版去弦，洗淨，五斤，捶碎 (2500g) 人參十五兩 (450g) 枸杞子三十兩 (900g)","上前三味袋盛，放長流水內浸三日，用鉛罈一只，如無鉛罈，底下放鉛一大片亦可。將角並甲放入罈內，用水浸，高三五寸，黃蠟三兩封口，放大鍋內，桑柴火煮七晝夜。煮時罈內一日添熱水一次，勿令沸起，鍋內一日夜添水五次，候角酥取出，洗，濾淨去滓。其滓即鹿角霜、龜甲霜也。將清汁另放。另將人參、枸杞子用銅鍋以水三十六碗，熬至藥面無水，以新布絞取清汁，將滓置石臼水捶搗細，用水二十四碗又熬如前；又濾又搗又熬，如此三次，以滓無味為度。將前龜、鹿汁並參、杞汁和入鍋內，文火熬至滴水成珠不散，乃成膠也。每服初起一錢五分 (4.5g)，十日加五分 (1.5g)，加至三錢 (9g) 止，空心酒化下，常服乃可 (現代用法：上用鉛罈熬膠，初服酒服4.5g，漸加至9g，空心時服用)","滋陰填精，益氣壯陽","真元虛損，精血不足證。全身瘦削，陽痿遺精，兩目昏花，腰膝痠軟，久不孕育","本方治證的病機為腎之陰精元陽虧虛。氣血化生於脾胃，精血藏養於腎肝，故無論先天稟賦不足，抑或後天脾胃失養及病後失調，均可使腎精不足，真元虛損，以致陰陽精血俱虧。由於病本在腎，虛及陰陽精血，故見身體消瘦，腰膝痠軟，兩目昏花，陽痿遺精，久不孕育。治宜填精補髓，益氣養血，陰陽並補","","1. 辨證要點：本方為陰陽氣血同補之劑，既能滋補肝腎，又可補益脾胃。以腰膝痠軟，兩目昏花，陽痿遺精為辨證要點。 2. 現代運用：本方常用於治療內分泌障礙引起的發育不良、重症貧血、神經衰弱，以及性功能減退等屬陰陽兩虛者。 3. 注意事項：本方純補，不免滋膩，故脾胃虛弱而食少便溏者不宜使用。或合用四君子湯以助運化","七寶美髯丹《本草綱目》引《積善堂方》：赤、白何首烏各一斤 (各500g)，米泔水浸三四日，瓷片刮去皮，用淘淨黑豆二升，以砂鍋木曾瓦，鋪豆及首烏，重重鋪蓋，蒸之。豆熟取出，去豆曬乾，換豆再蒸，如此九次，曬乾，為末 赤、白茯苓各一斤 (各500g)，去皮，研末，以水淘去筋膜及浮者取沉者撚塊，以人乳十碗浸勻，曬乾，研末 牛膝八兩，去苗，同何首烏第七次蒸之，至第九次止，曬乾 當歸八兩，酒浸，曬 枸杞子八兩，酒浸，曬 菟絲子八兩，酒浸生芽，研爛，曬 (各240g) 補骨脂四兩，以黑脂麻炒香 (120g)。上為末，煉蜜為丸，如彈子大，共150丸，清晨溫酒送下，午時薑湯送下，臥時鹽湯送下 (現代用法：碾細，煉蜜丸，每丸重10g，早、晚各服一丸，淡鹽開水送服)。功用：補益肝腎，烏髮壯骨。主治：肝腎不足證。鬚髮早白，脫髮，齒牙動搖，腰膝痠軟，夢遺滑精，腎虛不育等","龜鹿二仙最守真，補人三寶精氣神， 人參枸杞和龜鹿，益壽延年實可珍")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("86","牡蠣散","Mu Li San","Oyster Shell Powder","固澀劑","《太平惠民和劑局方》","黃芪 (30g) 麻黃根 (9g) 牡蠣米泔浸，刷去土，火燒通赤，各一兩 (30g)","為粗散，每服9g，加小麥30g，水煎溫服；亦作湯劑，用量按原方比例酌減，加小麥30克，水煎溫服","斂陰止汗，益氣固表","體虛自汗，盜汗證。常自汗出，夜臥更甚，心悸驚惕，短氣煩倦，舌淡紅，脈細弱","本方證病機為衛氣不足，陰液已傷。衛氣不固，則表虛而陰液外泄，故常自汗出；夜屬陰，睡時衛陽入裏，肌表不固，加之汗出過多，心陰不足而心陽不潛，而見盜汗。「汗為心之液」 汗出過多，心陰受損，心氣耗傷，心失所養，故心悸驚惕、短氣煩倦。本方所治既有陽虛自汗，又有陰虛盜汗，氣陰皆虛，故原書云「治諸虛不足」。舌淡、脈細弱均為氣陰兩虛之象，治宜斂陰止汗，益氣固表","","1. 辨證要點：本方為治氣虛衛外不固，又有陰液受損，心陽不潛所致自汗、盜汗常用方。臨床應用以汗出、心悸、短氣、舌淡、脈細弱為辨證要點。 2. 現代運用：本方常用於治療病後、產後或手術後身體虛弱，植物神經功能失調以及結核病所致的自汗、盜汗屬體虛衛外不固，又復心陽不潛者","","牡蠣散內用黃芪，小麥麻根合用宜， 衛虛自汗或盜汗，固表收斂見效奇")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("87","九仙散","Jiu Xian San","Nine Immortals Powder","固澀劑","《衛生寶鑒》","人參 款冬花 桑白皮 桔梗 五味子 阿膠 烏梅各一兩 (各30g) 貝母半兩 (15g) 罌粟殼去頂，蜜炒黃，八兩 (240g)","為末，每服9g，溫開水送下。亦可作湯劑，水煎服，用量按原方比例酌定","斂肺止咳、益氣養陰","久咳肺虛證。久咳不已，肺氣虛弱，咳甚則氣喘自汗，痰少而粘，脈虛數","本方證病機為久咳傷肺，氣陰兩虛。久咳傷肺，肺氣虛損，必致咳嗽不已，甚則氣喘，脈見虛象；肺主皮毛，肺氣不足，腠理失固，則汗自出，久咳耗傷肺陰，肺陰虧損，虛熱內生，煉液成痰故痰少而粘。治宜斂肺止咳，益氣養陰，兼以降氣化痰","","1. 辨證要點：本方為治療久咳肺虛的常用方，臨床應用以久咳不愈，喘息自汗，脈虛數為辨證要點。 2. 現代運用：現代臨床常用於慢性支氣管炎，肺氣腫，肺結核，支氣管哮喘，百日咳等屬久咳肺虛，氣陰兩虛者。 3. 注意事項： 久咳不已但內多痰涎或外有表邪者，不可使用，以免留邪。本方不可多服久服，中病即止","","九仙散中罌粟君，五味烏梅共為臣， 參膠款桑貝桔梗，斂肺止咳益氣陰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("88","真人養臟湯","Zhen Ren Yang Zang Tang","Enlightened Master Viscera-Nourishing Decoction","固澀劑","《太平惠民和劑局方》","人參 當歸 白朮焙 各六錢 (各18g) 肉豆蔻面裹，煨，半兩 (15g) 肉桂 炙甘草，各八錢 (各24g) 白芍藥一兩六錢 (48g) 木香一兩四錢 (42g) 訶子去核，一兩二錢 (36g) 罌粟殼去蒂萼，蜜炙，三兩六錢 (108g)","共為粗末，每服6g，水煎去滓，飯前溫服；亦作湯劑，飯前溫服，用量按原方比例酌減","澀腸固脫，溫補脾腎","久瀉久痢，脾腎虛寒證。大便滑脫不禁，瀉痢無度，腹痛喜按、喜溫，倦怠食少，不思飲食，舌質淡苔白，脈沉遲或遲細","本方證病機為脾腎虛寒，腸失固攝。腎司開闔，主二便，脾腎虛寒，關門不固，故瀉痢無度，滑脫不禁，甚則中氣下陷，脫肛墜下；脾腎虛寒，氣血不和，故腹痛喜溫喜按；脾虛運化無力，則食少倦怠；舌淡苔白，脈遲細，皆是脾腎虛寒之征。病雖以脾腎虛寒為本，但已至滑脫失禁，非固澀則瀉痢不能止，理當治標為要，故治以澀腸固脫為主，溫補脾腎為輔","","1. 辨證要點：本方為治療瀉痢日久，脾腎虛寒的常用方。臨床應用以大便滑脫不禁，腹痛喜溫喜按，食少神疲，舌淡苔白，脈遲細為辨證要點。 2. 現代運用： 本方常用於慢性腸炎、慢性結腸炎、腸結核、慢性痢疾、痢疾綜合征等日久不愈屬脾腎虛寒者。 3. 使用注意：服用本方宜忌酒、麫、生冷、魚腥、油膩。另外若瀉痢雖久，但濕熱積滯未去者，忌用本方","桃花湯《傷寒論》赤石脂一斤 (30g)，一半全用，一半篩末 乾薑一兩 (3g) 粳米一斤 (30g) 上三味，以水七升，煮米令熟，去滓，溫服七合，內赤石脂末方寸匕 (6g)，日三服。若一服愈，餘勿服。功用：溫中澀腸止痢。主治：虛寒血痢證。下痢日久不愈，便膿血，色黯不鮮，腹痛喜溫喜按，小便不利，舌淡苔白，脈遲弱或微細","真人養臟木香訶，當歸肉蔻與粟殼， 朮芍參桂甘草共，脫肛久痢服之瘥")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("89","四神丸","Si Shen Wan","Four Spirits Pill","固澀劑","《內科摘要》","肉豆蔻二兩 (60g) 補骨脂四兩 (102g) 五味子二兩 (60g) 吳茱萸浸，炒，一兩 (30g) 生薑四兩 (120g) 紅棗五十枚","以上6味，除生薑外，粉碎成細粉，過篩，混勻。取生薑120g，搗碎，加水適量壓榨取汁，與上述粉末泛丸，乾燥即得。每服9g，每日1-2次，臨睡用淡鹽湯或溫開水送服；亦作湯劑，加薑、棗水煎，臨睡溫服，用量按原方比例酌減","溫脾暖腎，固腸止瀉","脾腎陽虛之腎瀉。五更泄瀉，不思飲食，食不消化，或久瀉不愈，腹痛、腰痛肢冷、神疲乏力、舌質淡，苔薄白、脈沉遲無力","本方證病機為命門火衰，火不暖上，脾失健運所致。腎泄，又稱五更泄。五更正是陰氣極盛，陽氣萌發之際，由於腎陽虛衰，陽氣當至而不至，陰氣極而橫行。命門之火不能上溫脾士，脾失健運而水穀下趨，故為五更泄瀉，久泄之機理也與此相同。脾失健運故不思飲食、食不消化；脾腎陽虛，陰寒凝聚，則腹痛、腰酸肢冷，脾腎陽虛，陽氣不能化精微以養神，則神疲乏力。治宜溫補脾腎，澀腸止瀉","《醫方集解》記載本方服法宜在 「臨睡時淡鹽湯或白開水送下」，頗為有理，正如汪昂所云：「若平旦服之，至夜藥力已盡，不能敵一夜之陰寒故也」。故應囑患者於臨睡時服藥，更為奏效","1. 辨證要點：本方為治命門火衰，火不暖土所致五更泄瀉或久瀉的常用方。臨床應用以五更泄瀉，不思飲食，舌淡苔白，脈沉遲無力為辨證要點。 2. 現代運用： 本方常用於慢性結腸炎、腸結核、腸道易激綜合征等屬脾腎虛寒者","","四神骨脂吳茱萸，肉蔻除油五味具， 大棗生薑同煎合，五更腎泄最相宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("90","金鎖固精丸","Jin Suo Gu Jing Wan","Golden Lock Essence-Securing Pill","固澀劑","《醫方集解》","沙苑蒺藜炒 芡實蒸 蓮須各二兩 (各60g) 龍骨酥炙 牡蠣鹽水煮一日一夜，煆粉，各一兩 (各30g)","共為細末，以蓮子粉糊丸，每服9g，每日2-3次，空腹淡鹽湯送下；亦作湯劑，用量按原方比例酌減，加蓮子肉適量，水煎服","澀精補腎","腎虛不固之遺精。遺精滑泄，神疲乏力、腰痛耳鳴、舌淡苔白、脈細弱","本方證病機為腎虛精關不固。腎主封藏、腎虛則封藏失職，精關不固，故遺精滑泄，腰為腎之府，耳為腎之竅，腎虛精虧故腰痛耳鳴，精虧則氣弱，故神疲乏力，舌淡苔白，脈細弱。治宜補腎澀精","","1. 辨證要點：本方為治腎虛精關不固的常用方。臨床應用以遺精滑泄，腰痛耳鳴，舌淡苔白，脈細弱為辨證要點。亦可用治女子帶下屬腎虛滑脫者。 2. 現代運用：本方常用於性神經功紊亂、乳糜尿、慢性前列腺炎以及帶下、崩漏屬腎虛精氣不足，下元不固者。 3. 使用注意： 因本方偏於固澀，故相火內熾或下焦濕熱所致遺精、帶下者禁用","","金锁固精芡实研，莲须龙牡沙菀填， 莲粉糊丸盐汤下，肾虚精滑此方先")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("91","桑螵蛸散","Sang Piao Xiao San","Mantis Egg Shell Powder","固澀劑","《本草衍義》","桑螵蛸 遠志 菖蒲 龍骨 人參 茯神 當歸 龜甲酥炙，以上各一兩 (各30g)","共研細末，每服6g，睡前以人參湯調下；亦作湯劑，水煎，睡前服，用量按原方比例酌定","調補心腎，固精止遺","心腎兩虛證。症見小便頻數，或尿如米泔水，或遺尿滑精、心神恍惚、健忘、舌淡苔白、脈細弱","本方證病機為心腎兩虛，水火不交。腎主水，腎藏精，腎虛不攝，膀胱失約，則小便頻數，遺尿；腎虛封藏失職，精關不固，則滑精、遺精或尿如米泔色。腎精不足則腎氣衰，不能上通於心，心氣不足，神失所養，則健忘，進而精神恍惚，日久精血元氣受損，則舌淡苔白，脈虛弱等。證為腎虛不固，心虛不寧，心腎不交，治宜調補心腎，澀精止遺","","1. 辨證要點：本方為治療心腎兩虛之常用方。臨床應用以尿頻或遺尿，心神恍惚，舌淡苔白，脈細弱為辨證要點。 2. 現代運用：現代臨床常用本方治療小兒尿頻，遺尿，以及糖尿病，神經衰弱等屬心腎兩虛者。 3. 使用注意：下焦濕熱或相火妄動所致之尿頻、遺尿或遺精滑泄，非本方所宜","縮泉丸《校注婦人良方》天臺烏藥細銼 益智子大者，去皮，炒 各等分 上為末，別用山藥炒黃研末，打糊為丸，如梧桐子大，曝乾；每服五十丸 (6g)，嚼茴香如十粒，鹽湯或鹽酒下 (現代用法：每日1~2次，每次6g，開水送下)。功用：溫腎祛寒，縮尿止遺。主治：膀胱虛寒證。小便頻數，或遺尿，小腹怕冷，舌淡，脈沉弱","桑螵蛸散用龍龜，參苓菖遠及當歸， 尿頻遺尿精不固，滋腎寧心法勿違")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("92","固沖湯","Gu Chong Tang","Penetrating Vessel-Securing Decoction","固澀劑","《醫學衷中參西錄》","白朮一兩 (30g)，炒 生黃芪六錢 (18g) 龍骨八錢 (24g)，煆，搗細 牡蠣八錢 (24g)，煆，搗細 山茱萸八錢 (24g) 生白芍四錢 (12g) 海螵蛸四錢 (12g) 茜草三錢 (9g) 棕邊炭二錢 (6g) 五倍子五分 (1.5g)，軋細，藥汁送服","水煎服","益氣健脾，固沖攝血","脾腎虧虛，沖脈不固證。血崩或漏下不止，或月經過多，色淡質稀、頭暈肢冷，心悸氣短，神疲乏力，腰膝酸軟，舌淡，脈微弱","本方證病機為脾虛不攝，腎虛不固，沖脈滑脫。沖脈乃奇經八脈之一，為 「十二經之海」，又為 「血海」，婦女以血為本，月經以血為用，沖脈乃月經之本，又 「沖脈隸於陽明」，即沖脈受後天脾胃之氣血供養，若脾胃氣虛，化源不足，統攝無權，可致沖脈不固；又沖脈與足少陰腎經並行，得先天腎氣資助，貯存肝臟有餘之血，肝腎不足，亦可致沖脈不固，沖脈不固則症見崩漏或月經過多，失血既多，氣血俱虛，則見經血色淡質稀，心悸氣短，頭暈肢冷，神疲腰酸諸症。舌淡脈弱亦為氣血不足之象。治宜益氣健脾，補益肝腎，固沖攝血","","1. 辨證要點：本方為治療脾腎兩虛，沖脈不固之崩漏或月經過多的常用方。臨床應用以出血量多，色淡質稀，腰膝酸軟，舌淡，脈微弱為辨證要點。 2. 現代運用：現代臨床常用本方治療功能性子宮出血，產後出血過多等屬於脾腎兩虛，沖脈不固者。 3. 注意事項：血熱妄行崩漏者忌用本方","","固沖湯中用朮芪，龍牡芍萸茜草施， 倍子海蛸棕櫚炭，崩中漏下總能醫")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("93","固經丸","Gu Jing Wan","Menses-Securing Pill","固澀劑","《丹溪心法》","黃芩炒 白芍炒 龜板炙，各一兩 (各30g) 黃柏炒，三錢 (9g) 椿樹根皮七錢半 (22.5g) 香附二錢半 (7.5g)","以上6味，粉碎成細粉，過篩，混勻，用水泛丸乾燥即得。每服6g，每日2次，溫開水送服；亦可作湯劑，水煎服，用量按原書比例酌定","滋陰清熱，固經止血","陰虛血熱之崩漏。月經過多，或崩中漏下，血色深紅或紫黑稠粘，手足心熱，腰膝酸軟，舌紅，脈弦數","本方所治崩中漏下或月經過多，系由肝腎陰虛，相火熾盛，損傷沖任，迫血妄行所致。肝鬱不舒，氣滯血凝，加之血為火熱煎熬，故經血之中夾有紫黑血塊。陰虛火旺，故手足心熱，腰膝酸軟。舌紅脈弦數亦皆鬱熱內擾之象。治宜滋陰清熱，固經止血","","1. 辨證要點：本方為治陰虛血熱之月經過多及崩漏的常用方。臨床應用以血色深紅甚或紫黑稠粘，舌紅，脈弦數為辨證要點。 2. 現代運用：本方常用於功能性子宮出血或慢性附件炎而致經行量多、淋漓不止屬陰虛血熱者","","固經丸用龜版君，黃柏椿皮香附芩， 更加芍藥糊丸服，漏下崩中均可寧")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("94","易黃湯","Yi Huang Tang","Yellow-Transforming Decoction","固澀劑","《傅青主女科》","山藥炒，一兩 (30g) 芡實炒，一兩 (30g) 黃柏鹽水炒，二錢 (6g) 車前子酒炒 (3g) 白果十枚 (12g)，碎","水煎服","固腎止帶，清熱祛濕","濕熱帶下。帶下稠粘量多，色黃如濃茶汁，其氣腥穢，舌紅，苔黃膩","本方證病機為腎虛不固兼濕熱為患。腎與任脈相通，腎虛有熱損及任脈，氣不化津，津液反化為濕，循經下注則見帶下色黃、粘稠量多，其氣腥穢。舌紅苔黃膩皆濕熱之象，治宜固腎止帶，清熱祛濕","","1. 辨證要點：本方為治腎虛濕熱帶下的常用方。臨床應用以帶下色黃，其氣腥穢，舌苔黃膩為辨證要點。 2. 現代運用：現代臨床常用本方治療宮頸炎、陰道炎，腎炎蛋白尿等屬腎虛而有濕熱者","","易黃白果與芡實，車前黃柏加薯蕷， 能消帶下粘稠穢，補腎清熱又祛濕")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("95","朱砂安神丸","Zhu Sha an Shen Wan","Cinnabar Mind-Calming Pill","安神劑","《內外傷辨惑論》","朱砂五錢 (15g) 黃連 六錢 (18g) 炙甘草五錢半 (16.5g) 生地黃一錢半 (4.5g) 當歸二錢半 (7.5g)","上藥研末煉蜜為丸，每次 6-9g，臨睡前溫開水送服；亦可作湯劑","鎮心安神，清熱養血","心火亢盛，陰血不足證。失眠多夢，驚悸怔忡，心煩神亂，或胸中懊憹，舌尖紅，脈細數","本方所治之證，乃因心火亢盛，灼傷陰血所致。心火亢盛，則心神被擾，陰血不足，則心神失養，故見失眠多夢，驚悸怔忡，心煩等症；舌紅，脈細數，是心火盛而陰血虛之征。治當瀉其亢盛之火、補其陰血之虛而安神","","1. 辨證要點：本方是治療心火亢盛，陰血不足而致神志不安的常用方。臨床應用以失眠，驚悸，舌紅，脈細數為辨證要點。 2. 現代運用：本方常用於神經衰弱所致的失眠、心悸、健忘，精神憂鬱症引起的神志恍惚，以及心臟早搏所致的心悸、怔忡等屬於心火亢盛，陰血不足者。 3. 注意事項：方中朱砂含硫化汞，不宜多服、久服，以防引起汞中毒；陰虛或脾弱者，慎用","磁朱丸《備急千金要方》(原名神曲丸) 神曲 四兩 (120g) 磁石 二兩 (60g) 光明砂一兩 (30g) 右三味末之，煉蜜為丸，如梧子，飲服三丸 (2g)，日三服。功用：益陰明目，重鎮安神。主治：心腎不交，耳鳴耳聾，心悸失眠，亦治癲癇","朱砂安神東垣方，歸連甘草合地黃， 怔仲不寐心煩亂，鎮心泄火可復康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("96","天王補心丹","Tian Wang Bu Xin Dan","Celestial Emperor Heart-Supplementing Elixir","安神劑","《校注婦人良方》","人參 茯苓 玄參 丹參 桔梗 遠志 各五錢 (各15g) 當歸 五味 麥門冬 天門冬 柏子仁 酸棗仁炒，各一兩 (各30g) 生地黃四兩 (120g)","上藥共為細末，煉蜜為小丸，用朱砂水飛9-15g為衣，每服6-9g，溫開水送下，或用桂圓肉煎湯送服。亦可改為湯劑","滋陰清熱，養血安神","陰虛血少，神志不安證。心悸怔仲，虛煩失眠，神疲健忘，或夢遺，手足心熱，口舌生瘡，大便乾結，舌紅少苔，脈細數","本方所治之證，乃因心火亢盛，灼傷陰血所致。心火亢盛，則心神被擾，陰血不足，則心神失養，故見失眠多夢，驚悸怔忡，心煩等症，舌紅，脈細數，此證病機是心火盛而陰血虛之征。治宜瀉其亢盛之火，補其陰血之虛而安神","","1. 辨證要點：本方治證，多由憂愁思慮太過，暗耗陰血，以致心腎兩虧，陰虛血少，虛火內擾所致。陰虛血少，心失所養，故心悸失眠，神疲健忘；陰虛生內熱，虛火內擾，則手足心熱，虛煩，遺精，口舌生瘡；舌紅少苔，脈細數，是陰虛內熱之征。 2. 現代運用：本方常用於神經衰弱、冠心病、精神分裂症、甲狀腺機能亢進等所致的失眠、心悸，以及復發性口瘡等屬於心腎陰虛血少者。 3. 注意事項： 本方滋陰之品較多，對脾胃虛弱，納食欠佳，大便不實者，不宜長期服用","1. 柏子養心丸《體仁彙編》柏子仁 四兩 (120g) 枸杞子 三兩 (90g) 麥門冬 當歸 石菖蒲 茯神 各一兩 (各30g) 玄參 熟地黃 各二兩 (各60g) 甘草 五錢 (15g) 蜜丸，梧桐子大。每服四、五十丸 (9g)。功用：養心安神，滋陰補腎。主治：陰血虧虛，心腎失調所致之精神恍惚，驚悸怔忡，夜寐多夢，健忘盜汗，舌紅少苔，脈細而數。 2. 孔聖枕中丹《備急千金要方》(原名孔子大聖知枕中方) 龜甲 龍骨 遠志 菖蒲 各等分 上為末，食後服方寸匕 (3g)，一日三次，黃酒送服，常服令人大聰。功用：補腎寧心，益智安神。主治：心腎陰虧而致健忘失眠，心神不安，或頭目眩暈，舌紅苔薄白，脈細弦","補心丹用柏棗仁，二冬生地當歸身， 三參桔梗朱砂味，遠志茯苓養心神")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("97","酸棗仁湯","Suan Zao Ren Tang","Sour Jujube Decoction","安神劑","《金匱要略》","酸棗仁炒二升 (15g) 川芎二兩 (6g) 甘草一兩 (3g) 知母二兩 (6g) 茯苓二兩 (6g)","水煎，溫服","養血安神，清熱除煩","肝血不足，虛熱內擾證。虛煩失眠，心悸不安，頭目眩暈，咽乾口燥，舌紅，脈弦細","本方所治之證，乃因心火亢盛，灼傷陰血所致。心火亢盛，則心神被擾，陰血不足，則心神失養，故見失眠多夢，驚悸怔忡，心煩等症；舌紅，脈細數，是心火盛而陰血虛之征。治當瀉其亢盛之火，補其陰血之虛而安神","","1. 辨證要點：本方是治心肝血虛而致虛煩失眠之常用方。臨床應用以虛煩失眠，咽乾口燥，舌紅，脈弦細為辨證要點。 2. 現代運用：本方常用於神經衰弱、心臟神經官能症、更年期綜合征等屬於心肝血虛，虛熱內擾者","甘麥大棗湯《金匱要略》甘草 三兩 (9g) 小麥一升 (15g) 大棗十枚 (10枚) 上三味，以水六升，煮取三升，溫分三服。功用：養心安神，和中緩急。主治：臟躁。精神恍惚，常悲傷欲哭，不能自主，心中煩亂，睡眠不安，甚則言行失常，呵欠頻作，舌淡紅苔少，脈細略數","酸棗仁湯治失眠，川芎知草茯苓煎， 養血除煩清內熱，安然入睡夢鄉甜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("98","安宮牛黃丸","An Gong Niu Huang Wan","Peaceful Palace Bovine Bezoar Pill","開竅劑","《溫病條辨》","牛黃 郁金 黃連 朱砂 山梔 雄黃 黃芩各一兩 (各30g) 犀角一兩 (水牛角濃縮粉代，60g) 冰片 麝香各二錢五分 (各7.5g) 珍珠五錢 (15g)","以上11味，珍珠水飛或粉碎成極細粉，朱砂、雄黃分別水飛或粉碎成極細粉；黃連、黃芩、梔子、郁金粉碎成細粉；將牛黃、水牛角濃縮粉及麝香、冰片研細，與上述粉末配研、過篩、混勻，加適量煉蜜製成大蜜丸 (原方並用金箔為衣)。每服1丸，每日1次；小兒3歲以內1次1/4丸，4~6歲1次1/2丸，每日1次；或遵醫囑。另有安宮牛黃散、安宮牛黃膠囊、安宮牛黃栓，可按說明使用","清熱解毒，開竅醒神","邪熱內陷心包證。高熱煩躁，神昏譫語，舌謇肢厥，舌紅或絳，脈數有力。亦治中風昏迷，小兒驚厥，屬邪熱內閉者","本方證是邪熱內陷心包者。溫病熱邪熾盛，逆傳心包，必擾及神明，故高熱煩躁，神昏譫語；裏熱熾盛，灼津煉液成痰，痰濁上蒙清竅，勢必加重神昏譫語；舌為心竅，熱閉竅機，則舌謇不語；熱深厥亦深，故伴見熱厥之手足厥冷。所治中風痰熱昏迷、小兒高熱驚厥，亦屬熱閉之證。此證的病機是溫熱之邪內陷心包，痰熱蒙蔽清竅，治宜清熱解毒，開竅醒神","","1. 辨證要點：臨床應用以神昏譫語，伴高熱煩躁，舌紅或絳，脈數為辨證要點。 2. 現代運用：本方常用於流行性乙型腦炎、流行性腦脊髓膜炎、中毒性痢疾、尿毒癥、腦血管意外、肝昏迷、肺性腦病、顱腦外傷以及感染或中毒引起的高熱神昏等，辨證屬熱閉心包證者。 3. 注意事項：本方含香竄、寒涼及有毒之品，不宜過服、久服；舌苔白膩，寒病阻竅證，勿用；孕婦忌服","牛黃清心丸《痘疹世醫心法》黃連生 五錢 (15g) 黃芩 梔子仁 各三錢 (各9g) 郁金二錢 (6g) 辰砂一錢半 (4.5g) 牛黃二分半 (0.65g) 上為細末，臘雪調麵糊為丸，如黍米大。每服七八丸，燈心湯送下 (現代用法：以上六味，將牛黃研細，朱砂水飛或粉碎成極細粉，其餘黃連等四味粉碎成細粉，與上述粉末配研，過篩，混勻，加煉蜜適量，製成大蜜丸，每丸重1.5g或3g。口服，小丸1次2丸，大丸1次1丸，1日2~3次；小兒酌減)。功用：清熱解毒，開竅安神。主治：溫熱病熱閉心包證。身熱煩躁，神昏譫語，以及小兒高熱驚厥，中風昏迷等屬熱閉心包證者","安宮牛黃開竅方，芩連梔鬱朱雄黃， 牛角珍珠冰麝箔，熱閉心包功效良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("99","紫雪丹","Zi Xue Dan","Purple Snow Elixir","開竅劑","《外臺秘要》","石膏 寒水石 滑石 磁石各三斤 (各1.5kg) 犀角屑五兩 (水牛角濃縮粉代，100g) 羚羊角屑 沉香 木香各五兩 (各150g) 玄參 升麻各一斤 (各500g) 炙甘草八兩 (240g) 丁香一兩 (30g) (原用黃金百兩，現不用)","先用石膏、寒水石、滑石、磁石砸成小塊，加水煎煮3次。再將玄參、木香、沉香、升麻、甘草、丁香用石膏等煎液煎煮3次，合併煎液，濾過，濾液濃縮成膏，取芒硝 (5kg) 、硝石 (950g) 粉碎，兌入膏中，混勻，乾燥，粉碎成中粉或細粉；羚羊角銼研成細粉；取朱砂 (90g) 水飛成極細粉；取麝香 (1.5g) 與水牛角濃縮粉均研細，並與上述粉末配研、過篩、混勻即得 (不用黃金)，每瓶裝1.5g。口服，每次1.5~3g，每日2次；周歲小兒每次0.3g，5歲以內小兒每增1歲，遞增0.3g，每日1次，5歲以上小兒酌情服用","清熱開竅，熄風止痙","熱邪內陷心包，熱盛動風證。高熱煩燥，神昏譫語，痙厥，口渴引飲，唇焦齒燥，尿赤便秘，舌紅絳，苔乾黃，脈數有力或弦，以及小兒熱盛驚厥","本方證是熱邪內陷心包，熱盛動風者。熱邪內陷心包，熱擾心神，故神昏譫語，煩躁不安；熱極生風，故痙厥；熱盛傷津，故口渴引飲，唇焦齒燥。小兒熱盛驚厥，亦屬邪熱內閉，肝風內動之候。此證的病機為邪熱熾盛，內陷心包，熱盛動風，治宜寒涼清熱與芳香開竅為主，配合熄風安神","","1. 辨證要點：臨床應用以高熱煩躁，神昏譫語，痙厥，舌紅絳，苔乾黃，脈數有力為辨證要點。 2. 現代運用：本方常用於各種發熱性感染性疾病，如流行性腦脊髓膜炎、乙型腦炎的極期，重症肺炎、猩紅熱、化膿性感染等疾患的敗血症期，肝昏迷以及小兒高熱驚厥、小兒麻疹熱毒熾盛所致的高熱神昏抽搐，辨證屬熱邪內陷心包熱盛動風證者。 3. 注意事項：服用過量有損傷元氣之弊，故應中病即止；氣虛體弱者慎用；孕婦忌用","小兒回春丹《敬修堂藥說》川貝母 陳皮 木香 白豆蔻 枳殼 法半夏 沉香 天竹黃 僵蠶 全蠍 檀香各一兩二錢半 (各37.5g) 牛黃 麝香各四錢 (各12g) 膽南星二兩 (60g) 鉤藤八兩 (240g) 大黃二兩 (60g) 天麻一兩二錢半 (37.5g) 甘草八錢七分半 (26g) 朱砂適量 上藥為小丸，每丸重0.09g。口服，周歲以下，每次1丸；1~2歲，每次2丸，每日2~3次。功用：開竅定驚，清熱化痰。主治：小兒急驚風，痰熱蒙蔽心竅證。發熱煩躁，神昏驚厥，或反胃嘔吐，夜啼吐乳，痰嗽哮喘，腹痛泄瀉","紫雪羚牛朱樸硝，硝磁寒水滑石膏， 丁沉木麝升玄草，更用赤金法亦超")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("100","至寶丹","Zhi Bao Dan","Supreme Jewel Elixir","開竅劑","《蘇沈良方》","犀角一兩 (水牛角濃縮粉代，65g) 朱砂 雄黃 生玳瑁 琥珀各一兩 (各30g) 牛黃 麝香 冰片各一分 (各0.3g) 安息香一兩半 (45g)，酒浸，重湯煮令化，濾去滓，約取一兩淨 (原用金銀箔各五十片，現不用)","玳瑁、安息香、琥珀分別研碎成細粉；朱砂、雄黃分別水飛成極細粉；將水牛角濃縮粉、牛黃、麝香、冰片研細，與上述粉末配研、過篩、混勻；加適量煉蜜製成大蜜丸，每丸重3g。口服，每次1丸，每日1次，小兒酌量。本方改為散劑，名“局方至寶散”，每瓶裝2g。每服2g，每日1次；小兒3歲以內每次0.5g，4~6歲每次1g；或遵醫囑","化濁開竅，清熱解毒","痰熱內閉心包證。神昏譫語，身熱煩躁，痰盛氣粗，舌紅苔黃垢膩，脈滑數，以及中風、中暑、小兒驚厥屬於痰熱內閉者","本方證是痰熱內閉心包者。痰熱擾亂神明，故神昏譫語，身熱煩躁；痰涎壅盛，阻塞氣道，故痰鳴氣粗；舌紅苔黃垢膩，脈滑數，為痰熱內閉之象。中風、小兒驚厥等，機理亦同。此證的病機皆為邪熱亢盛，痰濁內閉心包，治宜化濁開竅，清熱解毒","","1. 辨證要點：臨床應用以神昏譫語，身熱煩躁，痰盛氣粗為辨證要點。 2. 現代運用：本方常用於流行性腦脊髓膜炎、乙型腦炎、中毒性痢疾、尿毒癥、腦血管意外、肝昏迷、冠心病心絞痛、癲癇等，辨證屬痰熱內閉心包證者。 3. 注意事項：方中芳香辛燥之品較多，有耗液竭陰之弊，故神昏譫語由於陽盛陰虛所致者不宜使用；孕婦慎服","行軍散《隨息居霍亂論》西牛黃 當門子 真珠 梅片 硼砂各一錢 (各3g) 明雄黃飛淨，八錢 (24g) 火硝三分 (0.9g) 飛金二十頁 八味各研極細如粉，再合研勻，瓷瓶密收，以蠟封之。每服三五分 (0.3~0.9g，1日2~3次)，涼開水調下。功用：辟穢解毒，清熱開竅。主治：暑穢，吐瀉腹痛，煩悶欲絕，頭目昏暈，不省人事；以及口瘡咽痛；風熱障翳 (現代主要用於夏季中暑、食物中毒、急性胃腸炎等屬暑熱穢濁者。外用可治口腔粘膜潰瘍、急性扁桃體炎、咽炎等熱毒病證。夏季以本品適量塗抹於鼻腔內，有預防瘟疫之效)","至寶朱砂麝息香，雄黃牛角與牛黃， 金銀二箔兼龍腦，琥珀還同玳瑁良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("101","蘇合香丸","Su He Xiang Wan","Storax Pill","開竅劑","《外臺秘要》","蘇合香 冰片 乳香 (各半兩) 各15g 麝香 安息香 木香 香附 白檀香 丁香 沉香 蓽茇 吃力伽 (即白朮) 訶子皮 朱砂各一兩 (各30g) 犀角一兩 (水牛角濃縮粉代，65g)","以上15味，除蘇合香、麝香、冰片、水牛角濃縮粉外，朱砂水飛成極細粉；其餘安息香等十味粉碎成細粉；將麝香、冰片、水牛角濃縮粉研細，與上述粉末配研、過篩、混勻。再將蘇合香燉化，加適量煉蜜與水製成水蜜丸，低溫乾燥；或加適量煉蜜製成大蜜丸，每丸重3g。口服，每次1丸，小兒酌減，每日1~2次，溫開水送服。昏迷不能口服者，可鼻飼給藥","芳香開竅，行氣止痛","寒閉證。突然昏倒，牙關緊閉，不省人事，苔白，脈遲。亦治心腹卒痛，甚則昏厥屬於寒閉證者","本方治證是屬於寒閉之證。寒痰穢濁，阻滯氣機，蒙蔽清竅，故突然昏倒、牙關緊閉、不省人事；陰寒內盛，故苔白脈遲；若寒凝胸中，氣血瘀滯，則心胸疼痛；邪壅中焦，氣滯不通，故脘腹脹痛難忍。此證的病機為寒邪穢濁，閉阻機竅，閉者宜開，治宜芳香開竅為主，對於寒邪、氣鬱、穢濁之病因，須配伍溫裏散寒、行氣活血及辟穢化濁之品","","1. 辨證要點：臨床應用以突然昏倒，不省人事，牙關緊閉，苔白，脈遲為辨證要點。 2. 現代運用：本方常用於急性腦血管病、癔病性昏厥、癲癇、老年癡呆、流行性乙型腦炎、肝昏迷、冠心病心絞痛、心肌梗死等，辨證屬寒閉或寒凝氣滯證者。 3. 注意事項：本品多用於急救或止痛，久服耗散正氣；脫證 熱閉證忌服；方中藥物辛香走竄，有損胎氣，孕婦忌服","1. 冠心蘇合丸《中華人民共和國藥典》蘇合香50g 冰片105g 乳香制，105g 檀香210g 青木香210g 以上五味，除蘇合香、冰片外，其餘乳香等三味粉碎成細粉，過篩；冰片研細，與上述粉末配研，過篩，混勻。另取煉蜜適量微溫後加入蘇合香，攪勻，再與上述粉末混勻，製成1000丸即得。嚼碎服，1次1丸，1日1~3次；或遵醫囑。功用：理氣活血，寬胸止痛。主治：心絞痛。胸悶，憋氣，屬於痰濁氣滯血瘀者。 2. 紫金錠《丹溪心法附餘》(又名玉樞丹) 雄黃一兩 (30g) 文蛤一名五倍子，捶碎，洗淨，焙三兩 (90g) 山慈菇去皮，洗淨，焙二兩 (60g) 紅芽大戟去皮，洗淨，焙乾燥一兩半 (45g) 千金子一名續隨子，去殼，研，去油取霜一兩 (30g) 朱砂五錢 (15g) 麝香三錢 (9g) 上除雄黃、朱砂、千金子、麝香另研外，其餘三味為細末，卻入前四味再研勻，以糯米糊和劑，杵千餘下，作餅子四十個，如錢大，陰乾。體實者一餅作二服，體虛者一餅作三服，凡服此丹但得通利一二行，其效尤速；如不要行，以米粥補之。若用塗瘡，立消。孕婦不可服 (現代用法：上為細末，糯米糊作錠。外用，磨水外搽，塗於患處，日3~4次。內服，1~3歲，每次0.3~0.5g；4~7歲，每次0.7~0.9g；8~10歲，每次1.0~1.2g；11~14歲，每次1.3~1.5g；15歲以上，每次1.5g。1日2~3次，溫開水送服)。功用：辟穢解毒，化痰開竅，消腫止痛。主治：暑令時疫。脘腹脹悶疼痛，噁心嘔吐，泄瀉，痢疾，舌潤，苔厚膩或濁膩，以及痰厥。外敷治療疔瘡腫毒，蟲咬損傷，無名腫毒，以及痄腮、丹毒、喉風等","蘇合香丸麝息香，木丁蓽茇乳檀方， 犀冰朮沉訶香附，衣用朱砂中惡嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("102","越鞠丸","Yue Ju Wan","Constraint-Resolving Pill","理氣劑","《丹溪心法》","香附 川芎 蒼朮 梔子 神曲各等分 (各6~10g)","為末，水泛為丸，如綠豆大 (現代用法：水丸，每服6~9g，溫開水送服；亦可作湯劑，水煎服)","行氣解鬱","六鬱證。胸膈痞悶，脘腹脹滿或疼痛，噯腐吞酸，噁心嘔吐，飲食不消","本方所治，乃氣、血、痰、火、濕、食六鬱而以氣鬱為主之證。氣為人之根本，氣機沖和調達，升降出入有序，周流運行不息，則臟腑功能協調，肢體百骸舒暢。若喜怒無常，憂思過度，寒溫不適，飲食不節，則可引起氣機失常而致病。氣機鬱滯，可影響血液運行而致血鬱，影響津液敷布而致濕鬱、痰鬱，影響脾胃受納運化而致食鬱，氣鬱不解又可生熱化火，諸鬱隨之而起。六鬱既生，故見胸膈痞悶，脘腹脹痛，吞酸嘔吐，飲食不消等症。本方證以氣鬱為先，氣鬱、血鬱、火鬱、濕鬱、痰鬱、食鬱相因為患，治宜行氣解鬱為主，兼解諸鬱，使氣行則血行，氣暢則痰、火、濕、食諸鬱得解","","1. 辨證要點：本方是治療六鬱證的代表方。臨床應用以以胸膈痞悶、脘腹脹痛、飲食不消等為辨證要點。 2. 現代運用：本方常用於胃神經官能症、胃及十二指腸潰瘍、慢性胃炎、膽石症、膽囊炎、肝炎、肋間神經痛、婦女痛經、月經不調等，辨證屬氣、血、痰、火、濕、食鬱滯為患者。 3. 注意事項：方中諸藥大多溫燥辛散，兼陰液不足者慎用","","行氣解鬱越鞠丸，香附芎蒼梔曲研， 氣血痰火濕食鬱，隨證易君並加減")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("103","枳實薤白桂枝湯","Zhi Shi Xie Bai Gui Zhi Tang","Immature Bitter Orange/ Chinese Chive and Cinnamon Twig Decoction","理氣劑","《金匱要略》","枳實四枚 (12g) 厚樸四兩 (12g) 薤白半升 (9g) 桂枝一兩 (6g) 瓜蔞實一枚，搗 (12g)","以水五升，先煮枳實、厚樸，取二升，去滓，內諸藥，煮數沸，分溫三服 (現代用法：水煎服)","通陽散結，祛痰下氣","胸陽不振，痰結氣逆之胸痹。胸滿而痛，甚或胸痛徹背，喘息咳唾，短氣，脅下氣逆上沖心胸，舌苔白膩，脈沉弦或緊","本方證因胸陽不振，聚津成痰，痰氣互結，陰寒氣逆所致。痰為陰邪，易阻氣機，結於胸中，則胸滿而痛，甚或胸痛徹背；痰濁阻滯，肺失宣降，故見咳唾喘息，短氣；胸陽不振，則陰寒氣逆，故有氣從脅下沖逆，上攻心胸之感。本方證以胸陽不振為本，痰阻氣滯而氣逆為標，故立法組方當通陽散結，祛痰下氣","","1. 辨證要點：本方是治療胸陽不振，痰阻氣滯而氣逆之胸痹的常用方。臨床應用以胸滿而痛，脅下氣逆上沖心胸，舌苔白膩，脈沉弦或緊為辨證要點。 2. 現代運用：本方常用於冠心病心絞痛、肋間神經痛、非化膿性肋軟骨炎等，辨證屬胸陽不振，痰阻氣滯者。 3. 注意事項：陽虛氣弱之胸痹，不宜單用本方","1. 瓜蔞薤白白酒湯《金匱要略》瓜蔞實一枚 (12g) 薤白半升 (12g) 白酒七升 (適量) 三味同煮，取二升，分溫再服 (現代用法：用適量黃酒加水煎服)。功用：通陽散結，行氣祛痰。主治：胸陽不振，痰氣互結之胸痹輕證。胸部滿痛，甚至胸痛徹背，喘息咳唾，短氣，舌苔白膩，脈沉弦或緊。 2. 瓜蔞薤白半夏湯《金匱要略》瓜蔞實一枚，搗 (12g) 薤白三兩 (9g) 半夏半升 (12g) 白酒一斗 (適量) 四味同煮，取四升，溫服一升，日三服 (現代用法：用黃酒適量，加水煎服)。功用：通陽散結，祛痰寬胸。主治：胸痹而痰濁較甚，胸痛徹背，不能安臥者","枳實薤白桂枝湯，厚蔞合治胸痹方， 胸陽不振痰氣結，通陽散結下氣強")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("104","半夏厚樸湯","Ban Xia Hou Po Tang","Pinellia and Officinal Magnolia Bark Decoction","理氣劑","《金匱要略》","半夏一升 (12g) 厚樸三兩 (9g) 茯苓四兩 (12g) 生薑五兩 (15g) 蘇葉二兩 (6g)","以水七升，煮取四升，分溫四服，日三夜一服 (現代用法：水煎服)","行氣散結，降逆化痰","梅核氣。咽中如有物阻，咯吐不出，吞咽不下，胸膈滿悶，或咳或嘔，舌苔白潤或白滑，脈弦緩或弦滑","梅核氣以咽中如有物阻，咯吐不出，咽之不下，但飲食吞咽並無妨礙為臨床特徵。本方證多因痰氣鬱結於咽喉所致。情志不遂，肝氣鬱結，肺胃失於宣降，津液不得正常輸布，聚而成痰，痰氣相搏，阻於咽喉，則咽中如有物阻，吐之不出，吞之不下；肺胃失於宣降，可致胸中氣機不暢，故見胸脅滿悶，或咳嗽喘急，或噁心嘔吐等。針對本方證病機，立法組方宜行氣散結，化痰降逆","","1. 辨證要點：本方為治療痰氣鬱結所致梅核氣的常用方。臨床應用以咽中如有物阻，吞吐不得，胸膈滿悶，苔白膩，脈弦滑為辨證要點。 2. 現代運用：本方常用於癔病、胃神經官能症、慢性咽炎、慢性支氣管炎、食道痙攣等，辨證屬痰氣鬱結者。 3. 注意事項：方中多辛溫苦燥之品，僅適宜於痰氣互結而無熱者，若見顴紅口苦，舌紅少苔，屬於氣鬱化火，陰傷津少者，雖具梅核氣之特徵，亦不宜使用本方","","半夏厚樸與紫蘇，茯苓生薑共煎服， 痰凝氣聚成梅核，降逆開鬱氣自舒")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("105","金鈴子散","Jin Ling Zi San","Toosendan Powder","理氣劑","《太平聖惠方》錄自《袖珍方》","金鈴子 玄胡各一兩 (各30g)","為細末，每服二三錢，酒調下，溫湯亦可 (現代用法：為細末，每服6~9g，酒或開水送下；亦可水煎服，用量按原方比例酌定)","疏肝泄熱，活血止痛","肝鬱化火證。胸腹脅肋諸痛，時發時止，口苦，或痛經，或疝氣痛，舌紅苔黃，脈弦數","本方證因肝鬱氣滯，氣鬱化火所致。肝藏血而喜條達，主疏泄，其經脈布兩脅、抵少腹、絡陰器。肝鬱氣滯則疏泄失常，血行不暢，故見胸腹脅肋諸痛，或因情志變化而疼痛加劇，時發時止；氣鬱化火，故見口苦、舌紅苔黃、脈弦數。治宜疏肝氣，泄肝火，暢血行，止疼痛","","1. 辨證要點：本方為治療肝鬱化火之胸腹脅肋疼痛的常用方，亦是治療氣鬱血滯而致諸痛的基礎方。臨床應用以胸腹脅肋諸痛，口苦，苔黃，脈弦數為辨證要點。 2. 現代運用：本方常用於胃炎、膽囊炎、胃腸痙攣、肋間神經痛、肋軟骨炎等，辨證屬肝鬱化火者","延胡索湯《濟生方》當歸去蘆，浸酒，銼炒 延胡索炒，去皮 蒲黃炒 赤芍藥 官桂不見火，各半兩 (各15g) 片子薑黃洗 乳香 沒藥 木香不見火各三兩 (各90g) 炙甘草，二錢半 (7.5g) 上藥 咀，每服四錢 (12g)，水一盞半，生薑七片，煎至七分去滓，食前溫服。功用：行氣活血，調經止痛。主治：婦人室女，七情傷感，遂使氣與血並，心腹作痛，或連腰脅，或連背膂，上下攻刺，經候不調，一切血氣疼痛，並可服之","金鈴子散止痛方，延胡酒調效更強， 疏肝泄熱行氣血，心腹胸脅痛經良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("106","厚樸溫中湯","Hou Po Wen Zhong Tang","Officinal Magnolia Bark Center-Warming Decoction","理氣劑","《內外傷辨惑論》","厚樸薑制 陳皮去白，各一兩 (各30g) 炙甘草 茯苓去皮 草豆蔻仁 木香各五錢 (各15g) 乾薑七分 (2g)","合為粗散，每服五錢匕 (15g)，水二盞，生薑三片，煎至一盞，去滓溫服，食前。忌一切冷物 (現代用法：按原方比例酌定用量，加薑三片，水煎服)","行氣除滿，溫中燥濕","脾胃寒濕氣滯證。脘腹脹滿，或疼痛，不思飲食，四肢倦怠，舌苔白膩，脈沉弦","本方證因脾胃傷於寒濕所致。寒性凝滯，濕性粘膩，易阻氣機，若寒濕著而不行，困於脾胃，則致脾胃氣機阻滯，升降失常，遂成脘腹脹滿或疼痛，不思飲食，四肢倦怠等症。寒不溫不去，濕不燥不除，氣不行不暢，故治當行其氣，溫其中，祛其寒，燥其濕。方中厚樸辛苦溫燥，行氣消脹，燥濕除滿，為君藥。草豆蔻辛溫芳香，溫中散寒，燥濕運脾，為臣藥。陳皮、木香行氣寬中助厚樸消脹除滿；乾薑、生薑溫脾暖胃助草豆蔻散寒止痛；茯苓滲濕健脾，均為佐藥。甘草益氣和中，調和諸藥，功兼佐使。諸藥合用，共成行氣除滿，溫中燥濕之功。使寒濕得除，氣機調暢，脾胃復健，則痛脹自解。 方中厚樸辛苦溫燥，行氣消脹，燥濕除滿，為君藥。草豆蔻辛溫芳香，溫中散寒，燥濕運脾，為臣藥。陳皮、木香行氣寬中助厚樸消脹除滿；乾薑、生薑溫脾暖胃助草豆蔻散寒止痛；茯苓滲濕健脾，均為佐藥。甘草益氣和中，調和諸藥，功兼佐使。諸藥合用，共成行氣除滿，溫中燥濕之功","","1. 辨證要點：本方為治療脾胃寒濕氣滯的常用方。以脘腹脹痛，舌苔白膩為辨證要點。 2. 現代運用：本方常用於慢性腸炎、慢性胃炎、胃潰瘍、婦女白帶等屬寒濕氣滯者","良附丸《良方集腋》高良薑酒洗七次，焙，研 香附子醋洗七次，焙，研各等分 (各9g) 藥各焙、各研、各貯，用時以米飲加生薑汁一匙，鹽一撮為丸，服之立止 (現代用法：上二味為細末，作散劑或水丸，每日1~2次，每次6g，開水送下)。功用：行氣疏肝，祛寒止痛。主治：肝胃氣滯寒凝證。胃脘疼痛，胸脅脹悶，畏寒喜溫，苔白脈弦。以及婦女痛經等","厚樸溫中陳草苓，乾薑草蔻木香停， 煎服加薑治腹痛，虛寒脹滿用皆靈")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("107","天臺烏藥散","Tian Tai Wu Yao San","Tian Tai Combined Spicebush Root Powder","理氣劑","《聖濟總錄》","天臺烏藥 木香 小茴香微炒 青皮湯浸，去白，焙 高良薑炒，各半兩 (各15g) 檳榔銼，二個 (9g) 川楝子十個 (12g) 巴豆七十粒 (12g)","上八味，先將巴豆微打破，同川楝子用麩炒黑，去巴豆及麩皮不用，合餘藥共研為末，和勻，每服一錢 (3g)，溫酒送下 (現代用法：巴豆與川楝子同炒黑，去巴豆，水煎取汁，沖入適量黃酒服)","行氣疏肝，散寒止痛","肝經寒凝氣滯之小腸疝氣。少腹引控睾丸而痛，偏墜腫脹，或少腹疼痛，舌淡苔白，脈沉遲或弦。亦治婦女痛經，瘕聚等屬寒凝氣滯者","足厥陰肝經抵於少腹，絡於陰器，若寒客肝脈，氣機阻滯，可見少腹疼痛，痛引睾丸，偏墜腫脹，發為小腸疝氣，故有 「諸疝皆歸肝經」《儒門事親》之說。本方證病機特點是寒凝肝脈，氣機阻滯，故立法組方宜行氣疏肝，散寒止痛，即張景嶽所謂 「治疝必先治氣」《景嶽全書》之義","","1. 辨證要點：本方是治療肝經寒凝氣滯所致疝痛的常用方。臨床應用以少腹痛引睾丸，舌淡苔白，脈沉弦為辨證要點。 2. 現代運用：本方常用於腹股溝疝、睾丸炎、附睾炎、胃腸功能紊亂、腸痙攣和痛經等，辨證屬肝經寒凝氣滯者。 3. 注意事項：本方藥性溫散，疝痛屬肝腎陰虛氣滯或兼有內熱者，不宜使用","1. 四磨湯《濟生方》人參 (6g) 檳榔 (9g) 沉香 (6g) 天臺烏藥 (6g) 四味各濃磨水，和作七分盞，煎三、五沸，放溫服 (現代用法：作湯劑，水煎服)。功用：行氣降逆，寬胸散結。主治：七情所傷，肝氣鬱結證。胸膈煩悶，上氣喘急，心下痞滿，不思飲食，苔白脈弦。 2. 橘核丸《濟生方》橘核炒 海藻洗 昆布洗 海帶洗 川楝子去肉，炒 桃仁 麩炒各一兩 (各30g) 厚樸去皮，薑汁炒 木通 枳實麩炒 延胡索炒，去皮 桂心不見火 木香不見火，各半兩 (各15g) 為細末，酒糊為丸，如桐子大，每服七十丸，空心溫酒鹽湯送下 (現代用法：為細末，酒糊為小丸，每日服1~2次，每次9g，空腹溫酒或淡鹽湯送下。亦可按原方比例酌定用量，水煎服)。功用：行氣止痛，軟堅散結。主治：寒濕疝氣。睾丸腫脹偏墜，或堅硬如石，或痛引臍腹，甚則陰囊腫大，輕者時出黃水，重者成膿潰爛","天臺烏藥木茴香，巴豆制楝青檳薑， 行氣疏肝且暖下，寒疝腹痛是良方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("108","暖肝煎","Nuan Gan Jian","Liver-Warming Decoction","理氣劑","《景嶽全書》","當歸二錢 (6g) 枸杞子三錢 (9g) 茯苓二錢 (6g) 小茴香二錢 (6g) 肉桂一錢 (3g) 烏藥二錢 (6g) 沉香一錢，或木香亦可 (3g)","加生薑3~5片，水煎服","溫補肝腎，行氣止痛","肝腎不足，寒滯肝脈證。睾丸冷痛，或小腹疼痛，畏寒喜暖，舌淡苔白，脈沉遲","本方證因肝腎不足，寒客肝脈，氣機鬱滯所致。寒為陰邪，其性收引凝滯，若肝腎不足，則寒易客之，使肝脈失和，氣機不暢，故見睾丸冷痛、或小腹疼痛、或疝氣痛諸症。治宜補肝腎，散寒凝，行氣滯","","1. 辨證要點：本方為治療肝腎不足，寒凝氣滯之小腹疼痛、疝氣痛的常用方。臨床應用以睾丸或小腹疼痛，畏寒喜溫，舌淡苔白，脈沉遲為辨證要點。 2. 現代運用：本方常用於精索靜脈曲張、睾丸炎、附睾炎、鞘膜積液、腹股溝疝等，辨證屬肝腎不足，寒凝氣滯者。 3. 注意事項：若因濕熱下注，陰囊紅腫熱痛者，切不可誤用","","暖肝煎中杞茯歸，茴沉烏藥合肉桂， 下焦虛寒疝氣痛，溫補肝腎此方推")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("109","蘇子降氣湯","Su Zi Jiang Qi Tang","Perilla Fruit Qi-Descending Decoction","理氣劑","《備急千金要方》錄自《太平惠民和劑局方》","紫蘇子 半夏湯洗七次，各二兩半 (各75g) 川當歸去蘆，兩半 (45g) 甘草爁，二兩 (60g) 前胡去蘆 厚樸去粗皮，薑汁拌炒，各一兩 (各30g) 肉桂去皮，一兩半 (45g)","為細末，每服二大錢 (6g)，水一盞半，入生薑二片，棗子一個，紫蘇五葉，同煎至八分，去滓熱服，不拘時候 (現代用法：加生薑2片，棗子1個，蘇葉2g，水煎服，用量按原方比例酌定)","降氣祛痰，平喘止咳","上實下虛喘咳證。痰涎壅盛，胸膈滿悶，咳喘短氣，呼多吸少，或腰疼腳弱、肢體倦怠，或肢體浮腫，舌苔白滑或白膩，脈弦滑","本方證屬於 「上實下虛」 所謂 「上實」 是指痰涎壅肺，肺失宣暢於上，而見胸膈滿悶，喘咳痰多，舌苔白滑或白膩，脈弦滑；所謂 「下虛」，是指腎陽虛衰於下，一則腎不納氣，呼多吸少而氣短，二則腎不主骨而腰疼腳弱，三則腎不主水，水不化氣而致水泛為痰、外溢為腫等。本方證病機特點是痰涎壅肺，腎陽不足，雖屬上實下虛，但以上實為主。故立法組方當以降氣平喘、祛痰止咳為主，兼顧下元","","1. 辨證要點：本方為治療上實下虛喘咳證的常用方。臨床應用以胸膈滿悶、痰多稀白、苔白滑或白膩為辨證要點。 2. 現代運用：本方常用於慢性支氣管炎、肺氣腫、支氣管哮喘等，辨證屬痰涎壅肺或兼腎陽不足者。 3. 注意事項：本方藥性偏溫燥，以降氣祛痰為主，對於肺腎陰虛的喘咳，以及肺熱痰喘之證，均不宜使用","","蘇子降氣半夏歸，前胡桂樸草薑隨， 上實下虛痰嗽喘，或加沉香去肉桂")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("110","定喘湯","Ding Chuan Tang","Arrest Wheezing Decoction","理氣劑","《攝生眾妙方》","白果去殼，砸碎炒黃，二十一枚 (9g) 麻黃三錢 (9g) 蘇子二錢 (6g) 甘草一錢 (3g) 款冬花三錢 (9g) 杏仁去皮、尖，一錢五分 (4.5g) 桑白皮蜜炙，三錢 (9g) 黃芩微炒，一錢五分 (4.5g) 法制半夏如無，用甘草湯泡七次，去臍用，三錢 (9g)","上藥用水三盅，煎二盅，作二服。每服一盅，不用薑，不拘時候徐徐服 (現代用法：水煎服)","宣降肺氣，清熱化痰","痰熱蘊肺之哮喘。哮喘咳嗽，痰多氣急，痰稠色黃，或微惡風寒，舌苔黃膩，脈滑數","本方所致哮喘乃因素體痰熱內蘊，復感風寒，肺氣壅閉，不得宣降所致，故見哮喘咳嗽，痰多稠黃，舌苔黃膩，脈滑數。針對本方證病位雖涉表裏，但以痰熱內蘊、肺失宣肅為主要病機，故立法組方應以宣肺降氣，清熱化痰為主，兼以宣散表邪","","1. 辨證要點：本方是治療痰熱內蘊所致哮喘的常用方。臨床應用以哮喘咳嗽，痰多稠黃，苔黃膩，脈滑數為辨證要點。 2. 現代運用：本方常用於支氣管哮喘、喘息性支氣管炎等，辨證屬痰熱蘊肺者。 3. 注意事項：哮喘日久，肺腎陰虛者，不宜使用","","定喘白果與麻黃，款冬半夏白皮桑， 蘇杏黃芩兼甘草，風寒痰熱喘哮嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("111","小半夏湯","Xiao Ban Xia Tang","Minor Pinellia Decoction","理氣劑","《金匱要略》","半夏一升 (20g) 生薑半斤 (10g)","以水七升，煮取一升半，分溫再服 (現代用法：水煎服)","化痰散飲，和胃降逆","痰飲嘔吐。嘔吐痰涎，口不渴，或乾嘔呃逆，穀不得下，小便自利，舌苔白滑","本方證因痰飲停於心下，胃氣失於和降所致。痰飲停於胃，胃失和降則嘔吐，嘔多必津傷致渴，渴者為飲隨嘔去，故為欲解；若嘔反不渴，是支飲仍在心下之故。治宜化痰散飲，和胃降逆","","1. 辨證要點：本方為治療痰飲嘔吐的基礎方。臨床應用以嘔吐不渴，苔白滑為辨證要點。 2. 現代運用：本方常用於胃炎、內耳眩暈症及化療後所致的胃腸反應等，辨證屬痰飲嘔吐者。 3. 注意事項：本方偏於溫燥，嘔吐屬熱者不宜使用","大半夏湯《金匱要略》 半夏二升 洗完用 (15g) 人參三兩 (9g) 白蜜一升 (9g)，以水一斗二升，和蜜揚之二百四十遍，煮藥取二升半，溫服一升，餘分再服。功用：和胃降逆，益氣潤燥。主治：胃反證。朝食暮吐，或暮食朝吐，宿穀不化，吐後轉舒，神疲乏力，面色少華，肢體羸弱，大便燥結如羊屎狀，舌淡紅，苔少，脈細弱","小半夏湯有生薑，化痰降逆基礎方， 主治痰飲嘔吐證，若加茯苓效力彰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("112","旋覆代赭湯","Xuan Fu Dai Zhe Tang","Inula and Hematite Decoction","理氣劑","《傷寒論》","旋覆花三兩 (9g) 人參二兩 (6g) 生薑五兩 (15g) 代赭石一兩 (6g) 炙甘草，三兩 (9g) 半夏洗，半升 (9g) 大棗擘，十二枚 (4枚)","以水一斗，煮取六升，去滓再煎，取三升，溫服一升，日三服 (現代用法：水煎服)","降逆化痰，益氣和胃","胃氣虛弱，痰濁內阻證。心下痞鞕，噫氣不除，或反胃嘔逆，吐涎沫，舌淡，苔白滑，脈弦而虛","本方原書用於 「傷寒發汗，若吐，若下，解後，心下痞鞕，噫氣不除者」，此乃外邪雖經汗、吐、下而解，但中氣受損，痰濁內生，阻於中焦，胃氣上逆所致。痰濁中阻，氣機閉塞，故見心下痞鞕，按之不痛；胃氣上逆，故頻頻喛氣，甚或嘔吐、呃逆等。本方證病機特點是中虛痰阻，胃氣上逆，故立法組方應以化痰降逆為主，兼以益氣補虛","","1. 辨證要點：本方是治療中虛痰阻氣逆證的常用方。臨床應用以心下痞鞕，噫氣頻作，嘔呃，苔白滑，脈弦而虛為辨證要點。 2. 現代運用：本方常用於胃神經官能症、胃擴張、慢性胃炎、胃及十二指腸潰瘍、幽門不完全性梗阻、神經性呃逆、膈肌痙攣等，辨證屬中虛痰阻氣逆者。 3. 注意事項：方中代赭石性寒沉降，質重礙胃，胃虛者用量宜小","","旋覆代赭用人參，半夏薑甘大棗臨， 化痰降逆兼調補，痞硬噫氣力能禁")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("113","橘皮竹茹湯","Ju Pi Zhu Ru Tang","Tangerine Peel and Bamboo Shavings Decoction","理氣劑","《金匱要略》","橘皮二斤 (12g) 竹茹二升 (12g) 大棗三十枚 (5枚) 生薑半斤 (9g) 甘草五兩 (6g) 人參一兩 (3g)","以水一斗，煮取三升，溫服一升，日三服 (現代用法：水煎服)","降逆止呃，益氣清熱","胃虛有熱之呃逆。呃逆或乾嘔，虛煩少氣，口乾，舌紅嫩，脈虛數","呃逆之證，皆因胃氣不能和降所致，但有寒、熱、虛、實之分。本方證為久病或吐利傷中，胃虛有熱，氣逆不降所致，故見呃逆或乾嘔，虛煩少氣，口乾，舌紅嫩，脈虛數等。針對本方證病機，氣逆宜降，有熱宜清，胃虛宜補，故治以降逆止呃、清熱和胃為主，兼以益氣補中","","1. 辨證要點：本方是治療胃虛有熱嘔逆的常用方。臨床應用以呃逆頻作或嘔吐、舌紅嫩、脈虛數為辨證要點。 2. 現代運用：本方常用於妊娠嘔吐、幽門不完全性梗阻、膈肌痙攣及術後呃逆不止等，辨證屬胃虛有熱氣逆者。 3. 注意事項：若因實熱或虛寒所致呃逆、嘔吐，則非本方所宜","丁香柿蒂湯《症因脈治》丁香 (6g) 柿蒂 (9g) 人參 (3g) 生薑 (6g) (原書未著用量) 用法：水煎服。功用：溫中益氣，降逆止呃。主治：胃氣虛寒。呃逆不已，胸痞脈遲者","橘皮竹茹治嘔逆，人參甘草棗薑益， 胃虛有熱失和降，久病之後更相宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("114","桃核承氣湯","Tao He Cheng Qi Tang","Peach Kernel Qi-Guiding Decoction","理血劑","《傷寒論》","桃仁去皮尖，五十個 (12g) 大黃四兩 (12g) 桂枝去皮二兩 (6g) 炙甘草，二兩 (6g) 芒硝二兩 (6g)","水煎前四味，沖芒硝服","破血下瘀","下焦蓄血證。少腹急結，小便自利，甚則譫語煩躁，神志如狂，至夜發熱；以及血瘀經閉，痛經，脈沉實而澀者","本方主治邪在太陽不解，隨經入腑化熱，與血相搏結於下焦之蓄血證。瘀熱互結於下焦少腹部位，故少腹急結；病在血分，與氣分無涉，膀胱氣化未受影響，故小便自利，至夜發熱；心主血脈而藏神，瘀熱上擾，心神不寧，故煩躁譫語，如狂。證屬瘀熱互結，治當破血下瘀，以祛除下焦之蓄血","","1. 辨證要點：本方為治療瘀熱互結，下焦蓄血證的常用方。臨床應用以少腹急結，小便自利，脈沉實或澀為辨證要點。 2. 現代運用：本方常用於急性盆腔炎、胎盤滯留、附件炎、腸梗阻、子宮內膜異位症等屬瘀熱互結下焦者。 3. 注意事項：表證未解者，當先解表，而後再用本方。因本方破血下瘀，故孕婦禁用","1.下瘀血湯《金匱要略》大黃二兩 (6g) 桃仁二十枚 (12g) 䗪蟲熬，去足，二十枚 (9g) 右三味，末之，煉蜜和為四丸，以酒一升，煎一丸，取八合，頓服之，新血下如豚肝。功用：瀉熱逐瘀。主治：瘀血化熱，瘀熱內結證。產後少腹刺痛拒按，按之有硬塊，或見惡露不下，口燥舌乾，大便結燥，甚則可見肌膚甲錯，舌質紫紅而有瘀斑瘀點，苔黃燥，脈沉澀有力。亦治血瘀而致經水不利之證。 2. 大黃䗪蟲丸《金匱要略》大黃蒸，十分 (75g) 黃芩二兩 (60g) 甘草三兩 (90g) 桃仁一升 (60g) 杏仁一升 (60g) 芍藥四兩 (120g) 乾地黃十兩 (300g) 乾漆一兩 (30g) 虻蟲一升 (60g) 水蛭百枚 (60g) 蠐螬一升 (60g) 䗪蟲半升 (30g) 右十二味，末之，煉蜜和丸小豆大，酒飲服五丸 (3g)，日三服 (現代用法：將蠐螬另串；桃仁、杏仁另研成泥。其餘9味共研為細粉，過羅，與桃仁等同混合均勻，共為細粉。煉蜜為丸，每粒3g，蠟皮封固。每服1丸，溫開水或酒送服)。功用：祛瘀生新。主治：五勞虛極，乾血內停證。形體羸瘦，少腹攣急，腹痛拒按，或按之不減，腹滿食少，肌膚甲錯，兩目無神，目框黯黑，舌有瘀斑，脈沉澀或弦","桃核承氣硝黃草，少佐桂枝溫通妙， 下焦蓄血小腹脹，瀉熱破瘀微利效")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("115","血府逐瘀湯","Xue Fu Zhu Yu Tang","Blood Stasis-Expelling Decoction","理血劑","《醫林改錯》","桃仁四錢 (12g) 紅花三錢 (9g) 當歸三錢 (9g) 生地黃三錢 (9g) 川芎一錢半 (4.5g) 赤芍二錢 (6g) 牛膝三錢 (9g) 桔梗一錢半 (4.5g) 柴胡一錢 (3g) 枳殼二錢 (6g) 甘草二錢 (6g)","水煎服","活血化瘀，行氣止痛","胸中血瘀證。胸痛，頭痛，日久不愈，痛如針刺而有定處或呃逆日久不止，或飲水即嗆，乾嘔，或內熱瞀悶，或心悸怔忡失眠多夢，急躁易怒，入暮潮熱，唇暗或兩目暗黑，舌質黯紅，或舌有瘀斑、或瘀點，脈澀或弦緊","本方主治諸證皆為瘀血內阻胸部，氣機鬱滯所致。即 「胸中血府血瘀」 之證。胸中為氣之所宗，血之所聚，肝經循行之分野。血瘀胸中，氣機阻滯，清陽鬱遏不升，則胸痛、頭痛日久不愈，痛如針刺，且有定處；胸中血瘀，影響及胃，胃氣上逆，故呃逆乾嘔，甚則水入即嗆；瘀久化熱，則內熱瞀悶，入暮潮熱；瘀熱擾心，則心悸怔忡，失眠多夢；鬱滯日久，肝失條達，故急躁易怒；至於唇、目、舌、脈所見，皆為瘀血徵象。治宜活血化瘀，兼以行氣止痛","","1. 辨證要點：本方廣泛用於因胸中瘀血而引起的多種病證。臨床應用以胸痛、頭痛，痛有定處，舌暗紅或有瘀斑，脈澀或弦緊為辨證要點。 2. 現代運用：本方常用於冠心病心絞痛、風濕性心臟病、胸部挫傷及肋軟骨炎之胸痛，以及腦血栓形成、高血壓病、高脂血症、血栓閉塞性脈管炎、神經官能症，腦震盪後遺症之頭痛、頭暈等屬瘀阻氣滯者。 3. 注意事項：方中藥物多為活血祛瘀，行氣通絡之品，故孕婦及體弱者忌用","1. 通竅活血湯《醫林改錯》赤芍 川芎各一錢 (各3g) 桃仁研泥 紅花各三錢 (各9g) 老蔥切碎3根 鮮薑三錢切碎 (9g) 紅棗去核7個 麝香絹包五厘 (0.16g) 黃酒半斤 (250g) 將前七味煎一盅，去滓，將麝香入酒內再煎二沸，臨臥服。功用：活血通竅。主治：瘀阻頭面的頭痛昏暈，或耳聾、脫髮、面色青紫，或酒渣鼻，或白癜風，以及婦女乾血癆、小兒疳積見肌肉消瘦，腹大青筋、潮熱等。 2. 膈下逐瘀湯《醫林改錯》五靈脂炒、二錢 (6g) 當歸三錢 (9g) 川芎二錢 (6g) 桃仁研泥三錢 (9g) 丹皮 赤芍 烏藥各二錢 (各6g) 延胡索一錢 (3g) 甘草三錢 (9g) 香附一錢半 (4.5g) 紅花三錢 (9g) 枳殼一錢半 (4.5g) 水煎服。功用：活血祛瘀，行氣止痛。主治：膈下瘀血阻滯，形成結塊，或小兒痞塊；或肚腹疼痛，痛處不移；或臥則腹墜似有物者。 3. 少腹逐瘀湯《醫林改錯》小茴香炒，七粒 (1.5g) 乾薑炒二分 (3g) 延胡索一錢 (3g) 沒藥二錢 (6g) 當歸三錢 (9g) 川芎二錢 (6g) 官桂一錢 (3g) 赤芍二錢 (6g) 蒲黃三錢 (9g) 五靈脂炒二錢 (6g) 水煎服。功用：活血祛瘀，溫經止痛。主治：少腹瘀血積塊疼痛或不痛，或痛而無積塊，或少腹脹滿，或經期腰酸，少腹作脹，或月經一月見三五次，接連不斷，斷而又來，其色或紫或黑，或有瘀塊，或崩漏兼少腹疼痛等症。 4. 身痛逐瘀湯《醫林改錯》秦艽一錢 (3g) 川芎二錢 (6g) 桃仁 紅花各三錢 (各9g) 甘草二錢 (6g) 羌活一錢 (3g) 沒藥二錢 (6g) 當歸三錢 (9g) 五靈脂炒，二錢 (6g) 香附一錢 (3g) 牛膝三錢 (9g) 地龍二錢，去土 (6g) 水煎服。功用：活血行氣，祛瘀通絡，通痹止痛。主治：氣血痹阻經絡所致的肩痛、臂痛、腰痛、腿痛，或周身疼痛，經久不愈","血府當歸生地桃，紅花甘草殼赤芍， 柴胡芎桔牛膝等，血化下行不作勞")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("116","補陽還五湯","Bu Yang Huan Wu Tang","Yang-Supplementing and Five-Returning Decoction","理血劑","《醫林改錯》","黃芪生，四兩 (120g) 當歸尾二錢 (6g) 赤芍一錢半 (5g) 地龍去土一錢 (3g) 川芎一錢 (3g) 紅花一錢 (3g) 桃仁一錢 (3g)","水煎服","補氣，活血，通絡","中風，氣虛血瘀證。半身不遂，口眼渦斜，語言蹇澀，口角流涎，小便頻數或遺尿失禁，舌黯淡，苔白，脈緩無力","本方證由中風之後，正氣虧虛，氣虛血滯，脈絡瘀阻所致。正氣虧虛，不能行血，以致脈絡瘀阻，筋脈肌肉失去濡養，故見半身不遂，口眼歪斜；正如《靈樞》刺節真邪第七十五所言：「虛邪偏客於身半，其入深，內居榮衛，榮衛稍衰則真氣去，邪氣獨留，發為偏枯」。氣虛血瘀，舌本失養，故語言蹇澀；氣虛失於固攝，故口角流涎，小便頻數，遺尿失禁；而舌黯淡、苔白、脈緩無力，為氣虛血瘀之象。本證以氣虛為本，血瘀為標，即王清任所謂 「因虛致瘀」。治當補氣為主，活血通絡為輔","","1. 辨證要點：本方乃益氣活血法的代表方，又是治療中風後遺症的常用方。臨床以半身不遂，口眼渦斜，舌黯淡，苔白，脈緩無力為辨證要點。 2. 現代運用：本方常用於腦血管意外後遺症、冠心病、小兒麻痹後遺症，以及其他原因引起的偏癱、截癱，或單側上肢或下肢痿軟，屬氣虛血瘀者。 3. 注意事項：使用本方需久服才能有效，愈後還應繼續服用，以鞏固療效，防止復發，王氏謂：「服此方愈後，藥不可斷，或隔三五日吃一付，或七八日吃一付」。中風後，半身不遂，屬陰虛陽亢，痰阻血瘀，舌紅苔黃，脈洪大有力者，非本方所宜","","補陽還五赤芍芎，歸尾通經佐地龍， 四兩黃芪為主藥，血中瘀滯用桃紅")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("117","復元活血湯","Fu Yuan Huo Xue Tang","Original Qi-Restoring and Blood-Moving Decoction","理血劑","《醫學發明》","柴胡半兩 (15g) 瓜蔞根、當歸各三錢 (各9g) 紅花、甘草、穿山甲炮，各二錢 (各6g) 大黃酒浸，一兩 (30g) 桃仁酒浸，去皮尖，研如泥，五十個 (15g)","除桃仁外，銼如麻豆大，每服一兩，水一盞半，酒半盞，同煎至七分，去滓，大溫服之，食前，以利為度，得利痛減，不盡服 (現代用法：共為粗末，每服30g，加黃酒30ml，水煎服)","活血祛瘀，疏肝通絡","跌打損傷，瘀血阻滯證。瘀阻脅下，痛不可忍","本方證因跌打損傷，瘀血滯留於脅下，氣機阻滯所致。脅下為肝經循行之處，跌打損傷，瘀血停留，氣機阻滯，故脅下疼痛，甚至痛不可忍。治當活血祛瘀，兼之疏肝行氣通絡","","1. 辨證要點：本方為治療跌打損傷，瘀血阻滯證的常用方。臨床應用以脅肋瘀腫疼痛為辨證要點。若化裁得當，亦可廣泛用於一切跌打損傷。 2. 現代運用：本方常用於肋間神經痛、肋軟骨炎、胸脅部挫傷、乳腺增生症等屬瘀血停滯者。 3. 注意事項：服藥後應 「以利為度」，若雖 「得利痛減」，而病未痊癒，需繼續服藥者，必須更換方劑或調整原方劑量。孕婦忌服","七厘散《同壽錄》(卷尾) 上朱砂水飛淨一錢二分 (3.6g) 真麝香一分二厘 (0.36g) 梅花冰片一分二厘 (0.36g) 淨乳香一錢五分 (4.5g) 紅花一錢五分 (4.5g) 明沒藥一錢五分 (4.5g) 瓜兒血竭一兩 (30g) 粉口兒茶二錢四分 (7.2g) 上為極細末，瓷瓶收貯，黃蠟封口，貯久更妙。治外傷，先以藥七厘 (0.5~1g) 燒酒沖服，復用藥以燒酒調敷傷處。如金刃傷重，急用此藥乾滲。功用：散瘀消腫，定痛止血。主治：跌打損傷，筋斷骨折，瘀血腫痛，或刀傷出血。並治無名腫毒，燒傷燙傷等。傷輕者不必服，只用敷","復元活血用柴胡，大黃花粉桃紅入， 當歸山甲與甘草，跌打損傷瘀痛除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("118","溫經湯","Xiao Qing Long Tang","Channel-Warming Decoction","理血劑","《金匱要略》","吳茱萸三兩 (9g) 當歸二兩 (6g) 芍藥二兩 (6g) 川芎二兩 (6g) 人參二兩 (6g) 桂枝二兩 (6g) 阿膠二兩 (6g) 牡丹皮去心，二兩 (6g) 生薑二兩 (6g) 甘草二兩 (6g) 半夏半升 (6g) 麥冬去心，一升 (9g)","上十二味，以水一斗，煮取三升，分溫三服 (現代用法：水煎服，阿膠烊沖)","溫經散寒，祛瘀養血","沖任虛寒，瘀血阻滯證。漏下不止，或血色黯而有塊，淋漓不暢，月經不調，超前延後，或逾期不止，或一月再行，或經停不至，而見傍晚發熱，手心煩熱，唇口乾燥，少腹裏急，腹滿。舌質黯紅，脈細而澀。亦治婦人宮冷，久不受孕","本方證因沖任虛寒，瘀血阻滯所致。沖為血海，任主胞胎，二脈皆起於胞宮，循行於少腹，與經、產關係密切。沖任虛寒，血凝氣滯，故少腹裏急，腹滿，月經不調，或久不受孕；若瘀血阻滯，血不循經，或沖任不固，則月經先期，或一月再行，甚或崩中漏下；若寒凝血瘀，脈經不暢，則月經後期，甚或經停不至；瘀血不去，新血不生，不能濡潤，故唇口乾燥；至於傍晚發熱、手心煩熱為陰血耗損，虛熱內生之象。本方證雖屬瘀、寒、虛、熱錯雜，然以沖任虛寒，瘀血阻滯為主，治當溫經散寒，祛瘀養血，兼清虛熱之法","","1. 辨證要點：本方為婦科調經的常用方，主要用於沖任虛寒而有瘀滯的月經不調、痛經、崩漏、不孕等。臨床應用以月經不調，小腹冷痛，經血夾有瘀塊，時有煩熱，舌質黯紅，脈細澀為辨證要點。 2. 現代運用：本方常用於功能性子宮出血、慢性盆腔炎、痛經、不孕症等屬沖任虛寒，瘀血阻滯者。 3. 注意事項：月經不調屬實熱或無瘀血內阻者忌用，服藥期間忌食生冷之品","溫經湯《婦人大全良方》當歸 川芎 肉桂 莪朮醋炒 牡丹皮各五分 (各6g) 人參 牛膝 甘草各七分 (各9g) 水煎服。功用：溫經補虛，化瘀止痛。主治：血海虛寒，血氣凝滯證。月經不調，臍腹作痛，其脈沉緊","溫經湯用桂萸芎，歸芍丹皮薑夏冬， 參草阿膠調氣血，暖宮祛瘀在溫通")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("119","生化湯","Sheng Hua Tang","Engendering and Transforming Decoction","理血劑","《傅青主女科》","全當歸八錢 (24g) 川芎三錢 (9g) 桃仁去皮尖，十四枚 (6g) 乾薑炮黑，五分 (2g) 炙甘草，五分 (2g)","黃酒、童便各半煎服 (現代用法：水煎服，或酌加黃酒同煎)","養血袪瘀，溫經止痛","血虛寒凝，瘀血阻滯證。產後惡露不行，小腹冷痛","本方證由產後血虛寒凝，瘀血內阻所致。婦人產後，血虧氣弱，寒邪極易乘虛而入，寒凝血瘀，故惡露不行；瘀阻胞宮，不通則痛，故小腹冷痛。治宜活血養血，溫經止痛","","1. 辨證要點：本方為婦女產後常用方，甚至有些地區民間習慣作為產後必服之劑，雖多屬有益，但應以產後血虛瘀滯偏寒者為宜，以產後惡露不行，小腹冷痛為辨證要點。 2. 現代運用：本方常用於產後子宮復舊不良，產後宮縮疼痛，胎盤殘留等屬產後血虛寒凝，瘀血內阻者。 3. 注意事項：若產後血熱而有瘀滯者不宜使用；若惡露過多，出血不止，甚則汗出氣短神疲者，當屬禁用","","生化湯宜產後嘗，歸芎桃草酒炮薑， 惡露不行少腹痛，溫養活血最見長")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("120","失笑散","Shi Xiao San","Sudden Smile Powder","理血劑","《太平惠民和劑局方》","五靈脂酒研，淘去沙土 蒲黃炒香，各二錢 (各6g)","先用釅醋調二錢，熬成膏，入水一盞，煎七分，食前熱服。(現代用法：共為細末，每服6克，用黃酒或醋沖服，亦可每日取8~12克，用紗布包煎，作湯劑服)","活血祛瘀，散結止痛","瘀血停滯證。心腹刺痛，或產後惡露不行，或月經不調，少腹急痛等","本方所治諸痛，均由瘀血內停，脈道阻滯所致。瘀血內停，脈絡阻滯，血行不暢，不通則痛，故見心腹刺痛，或少腹急痛；瘀阻胞宮，則月經不調，或產後惡露不行。治宜活血祛瘀止痛","","1. 辨證要點：本方是治療瘀血所致多種疼痛的基礎方，尤以肝經血瘀者為宜。以心腹刺痛，或婦人月經不調，少腹急痛等為辨證要點。 2. 現代運用：本方常用於痛經、冠心痛、高血脂症、宮外孕、慢性胃炎等屬瘀血停滯者。 3. 注意事項：孕婦禁用，脾胃虛弱及婦女月經期慎用","1. 活絡效靈丹《醫學衷中參西錄》當歸 丹參 生乳香 生沒藥各五錢 (各15g) 上藥四味作湯服。若為散，一劑分作四次服，溫酒送下。功用：活血祛瘀，通絡止痛。主治：氣血凝滯證。心腹疼痛，腿痛臂痛，跌打瘀腫，內外瘡瘍以及癥瘕積聚等。 2. 丹參飲《時方歌括》丹參一兩 (30g) 檀香 砂仁各一錢半 (各4.5g) 以水一杯，煎七分服。功用：活血祛瘀，行氣止痛。主治：血瘀氣滯之心胃諸痛","失笑靈脂蒲黃同，等量為散釅醋沖， 瘀滯心腹時作痛，祛瘀止痛有奇功")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("121","桂枝茯苓丸","Gui Zhi Fu Ling Wan","Cinnamon Twig and Poria Pill","理血劑","《金匱要略》","桂枝 茯苓 丹皮去心 桃仁去皮尖，熬 芍藥各等分 (9g)","右三味，末之，煉蜜和丸，如兔屎大，每日食前服一丸 (3g)，不知，加至三丸 (現代用法，共為末，煉蜜和丸，每日服3~5g；亦可水煎，用量按原方比例酌定)","活血化瘀，緩消癥塊","瘀阻胞宮證。婦人素有癥塊，妊娠漏下不止，或胎動不安，血色紫黑晦暗，腹痛拒按，或經閉腹痛，或產後惡露不盡而腹痛拒按者，舌質紫黯或有瘀點，脈沉澀","本方原治婦人素有癥塊，致妊娠胎動不安或漏下不止之證。證由瘀阻胞宮所致。瘀血癥塊，停留於胞宮，沖任失調，胎元不固，則胎動不安；瘀阻胞宮，阻遏經脈，以致血溢脈外，故見漏下不止，血色紫黑晦暗；瘀血內阻胞宮，血行不暢，不通則痛，故腹痛拒按等。治宜活血化瘀，緩消癥塊","","1. 辨證要點：本方為治療瘀血留滯胞宮，妊娠胎動不安，漏下不止的常用方。以少腹有癥塊，血色紫黑晦暗，腹痛拒按為辨證要點。婦女經行不暢、閉經、痛經，以及產後惡露不盡等屬瘀阻胞宮者，亦可以本方加減治之。 2. 現代運用：本方常用於子宮肌瘤、子宮內膜異位症、卵巢囊腫、附件炎，慢性盆腔炎等屬瘀血留滯者。 3. 注意事項：對婦女妊娠而有瘀血癥塊者，只能漸消緩散，不可峻猛攻破。原方對其用量、用法規定甚嚴，臨床使用切當注意","","金匱桂枝茯苓丸，桃仁芍藥與牡丹， 等分為末蜜丸服，緩消癥塊胎可安")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("122","鱉甲煎丸","Bie Jia Jian Wan","Turtle Shell Decocted Pill","理血劑","《金匱要略》","鱉甲十二分 (90g)，炙 烏扇燒 黃芩 鼠婦熬 乾薑 大黃 桂枝 石韋去毛 厚樸 紫葳 阿膠各三分 (各22.5g) 柴胡 蜣螂熬，各六分 (各45g) 芍藥 牡丹去心 䗪蟲熬，各五分 (各37g) 蜂窠炙，四分 (30g) 赤硝十二分 (90g) 桃仁 瞿麥各二分 (15g) 人參 半夏 葶藶各一分 (各7.5g)","上二十三味，取煆灶下灰一斗，清酒一斛五斗，浸灰，候酒盡一半，著鱉甲於中，煮令泛爛如膠漆，絞取汁，內諸藥，煎為丸，如梧桐子大。空心服七丸，日三服 (現代用法：除硝石、鱉甲膠、阿膠外，20味烘乾碎斷，加黃酒600g拌勻，加蓋封閉，隔水燉至酒盡藥熟，乾燥，與硝石等三味混合粉碎成細粉，煉蜜為丸，每丸重3g。每次服1~2丸日2~3次，溫開水送下)","行氣活血，祛濕化痰，軟堅消癥","瘧母、癥瘕。瘧疾日久不愈，脅下痞鞕 (或硬) 成塊，結成瘧母；以及癥瘕結於脅下，推之不移，腹中疼痛，肌肉消瘦，飲食減少，時有寒熱，女子月經閉止等","本方原治瘧母結下脅下，今常以之治腹中癥瘕。瘧母之成，每因瘧邪久踞少陽，正氣日衰，氣血運行不暢，寒熱痰濕之邪與氣血搏結，聚而成形，留於脅下所致。癥瘕一病，亦屬氣滯血凝日久漸積所成，二者成因頗近，故均可用本方治之","","1. 辨證要點：本方為治瘧母、癥瘕之常用方。臨床應用以癥瘕結於脅下，推之不移，腹中疼痛，肌肉消瘦，飲食減少，時有寒熱，女子月經閉止等為辨證要點。 2. 現代運用：本方常用於肝硬化，肝脾腫大，肝癌，子宮肌瘤，卵巢囊腫等證屬正氣日衰，氣滯血瘀者","","鱉甲煎丸瘧母方，䗪蟲鼠婦及蜣螂， 蜂窠石韋人參射，桂樸紫葳丹芍薑， 瞿麥柴芩膠半夏，桃仁葶藶和硝黃， 瘧疾日久脅下硬，癥消積化保安康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("123","十灰散","Shi Hui San","Ten Charred Substances Powder","理血劑","《十藥神書》","大薊 小薊 荷葉 側柏葉 茅根 茜根 山梔 大黃 牡丹皮 棕櫚皮各等分 (各9g)","上藥各燒灰存性，研極細末，用紙包，碗蓋於地上一夕，出火毒，用時先將白藕搗汁或蘿蔔汁磨京墨半碗，調服五錢，食後服下 (現代用法：各藥燒炭存性，為末，藕汁或蘿蔔汁磨京墨適量，調服9~15克；亦可作湯劑，水煎服，用量按原方比例酌定)","涼血止血","血熱妄行證。嘔血、吐血、咯血、嗽血、衄血，血色鮮紅，來勢急暴，舌紅，脈數","本方主治上部出血諸證，乃因火熱熾盛，氣火上沖，損傷血絡，離經妄行所致。治宜涼血止血","","1. 辨證要點：本方為主治血熱妄行所致的各種上部出血證而設，以血色鮮紅，舌紅苔黃，脈數為辨證要點。 2. 現代運用：本方常用於上消化道出血、支氣管擴張及肺結核咯血等屬血熱妄行者。 3. 注意事項：本方為急則治標之劑，血止之後，還當審因圖本，方能鞏固療效。對虛寒性出血則不宜使用。本方為散劑，既可內服，也能外用，但應預先製備，使火氣消退，方可使用。方中藥物皆燒炭，但應注意 「存性」，否則藥效不確","四生丸《婦人大全良方》生荷葉 生艾葉 生柏葉 生地黃各等分，共研，丸如雞子大，每服一丸。亦可作湯劑水煎服，用量按原方比例酌定。功用：涼血止血。主治：血熱妄行所致之吐血、衄血、血色鮮紅，口乾咽燥，舌紅或絳，脈弦數","十灰散用大小薊，荷柏茅茜棕丹皮， 山梔大黃俱為灰，上部出血此方宜")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("124","咳血方","Ke Xue Fang","Coughing with Blood Treating Decoction","理血劑","《丹溪心法》","青黛水飛 (6g) 瓜蔞仁去油 (9g) 海粉 (9g) 山梔子炒黑 (9g) 訶子 (6g)","上為末，以蜜同薑汁為丸，噙化 (現代用法：共研末為丸，每服9g。亦可作湯劑，水煎服，用量按原方比例酌定)","清肝寧肺，涼血止血","肝火犯肺之咳血證。咳嗽痰稠帶血，咯吐不爽，心煩易怒，胸脅作痛，咽乾口苦，頰赤便秘，舌紅苔黃，脈弦數","本方證系肝火犯肺，灼傷肺絡所致。肺為清虛之臟，木火刑金，肺津受灼為痰，清肅之令失司，則咳嗽痰稠，咯吐不爽；肝火灼肺，損傷肺絡，血滲上溢，故見痰中帶血；肝火內熾，故心煩易怒，胸脅作痛，咽乾口苦，頰赤便秘；舌紅苔黃，脈弦數為火熱熾盛之征。是證病位雖在肺，但病本則在肝。按治病求本的原則，治當清肝瀉火，使火清氣降，肺金自寧","","1. 辨證要點：本方為治療肝火犯肺之咳血證的常用方。臨床應用以咳痰帶血，胸脅作痛，舌紅苔黃，脈弦數為辨證要點。 2. 現代運用：本方常用於支氣管擴張、肺結核等咳血，屬肝火犯肺者。 3. 注意事項：本方屬寒涼降泄之劑，故肺腎陰虛及脾虛便溏者，不宜使用","","咳血方中梔青黛，訶子海粉瓜蔞仁， 薑汁蜜丸口噙化，木火刑金咳血平")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("125","小薊飲子","Xiao Ji Yin Zi","Field Thistle Drink","理血劑","《濟生方》錄自《玉機微義》","生地黃 小薊 滑石 木通 蒲黃 藕節 淡竹葉 當歸 山梔子 甘草 各等分 (各9g)","上㕮咀，每服半兩 (15g)，水煎，空心服 (現代用法：作湯劑，水煎服，用量據病證酌情增減)","涼血止血，利水通淋","熱結下焦之血淋、尿血。尿中帶血，小便頻數，赤澀熱痛，舌紅，脈數","本方證因下焦瘀熱，損傷膀胱血絡，氣化失司所致。熱聚膀胱，損傷血絡，血隨尿出，故尿中帶血，其痛者為血淋，若不痛者為尿血。由於瘀熱蘊結下焦，膀胱氣化失司，故見小便頻數，赤澀熱痛。舌紅脈數，亦為熱結之征。治宜涼血止血，利水通淋","","1. 辨證要點：本方為治療血淋、尿血屬實熱證的常用方。臨床應用以尿中帶血，小便赤澀熱痛，舌紅，脈數為辨證要點。 2. 現代運用：本方常用於急性泌尿系感染，泌尿系結石，腎結核等屬下焦瘀熱，蓄聚膀胱者。 3. 注意事項：方中藥物多屬寒涼通利之品，只宜於實熱證。若血淋、尿血日久兼寒或陰虛火動或氣虛不攝者，均不宜使用","","小薊飲子藕蒲黃，木通滑石生地黃， 歸草梔子淡竹葉，熱結血淋服之良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("126","槐花散","Huai Hua San","Pagoda Tree Flower Powder","理血劑","《普濟本事方》","槐花炒 (12g) 柏葉杵，焙 (12g) 荊芥穗 (6g) 枳殼麩炒 (6g) 各等分","上為細末，用清米飲調下二錢，空心食前服。(現代用法：為細末，每服6g，開水或米湯調下；亦可作湯劑，水煎服，用量按原方比例酌定)","清腸止血，疏風行氣","風熱濕毒，壅遏腸道，損傷血絡證。便前出血，或便後出血，或糞中帶血，以及痔瘡出血，血色鮮紅或晦暗，舌紅苔黃脈數","本方所治為腸風、臟毒，皆因風熱或濕熱邪毒，壅遏腸道血分，損傷脈絡，血滲外溢所致。一般地說，「腸風者，下血新鮮，直出四射，皆由便前而來……臟毒者，下血瘀晦，無淪便前便後皆然」《成方便讀》。治宜清腸涼血為主，兼以疏風行氣","","1. 辨證要點：本方是治療腸風、臟毒下血的常用方。臨床應用以便血，血色鮮紅，舌紅，脈數為辨證要點。 2. 現代運用：本方常用於治療痔瘡、結腸炎或其他大便下血屬風熱或濕熱邪毒，壅遏腸道，損傷脈絡者。腸癌便血亦可應用。 3. 注意事項：由於方中藥性寒涼，故只可暫用，不宜久服。便血日久屬氣虛或陰虛者，以及脾胃素虛者均不宜使用","","槐花散為便血方，側柏芥穗枳殼襄， 槐角防榆歸芩枳，清腸止血亦可嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("127","黃土湯","Huang Tu Tang","Yellow Earth Decoction","理血劑","《金匱要略》","甘草 乾地黃 白朮 附子炮 阿膠 黃芩各三兩 (各9g) 灶心黃土半斤 (30g)","上七味，以水八升，煮取三升，分溫二服 (現代用法：先將灶心土水煎過濾取湯，再煎餘藥。阿膠烊化沖服)","溫陽健脾，養血止血","脾陽不足，脾不統血證。大便下血，先便後血，以及吐血、衄血、婦人崩漏，血色暗淡，四肢不溫，面色萎黃，舌淡苔白，脈沉細無力","本方證因脾陽不足，統攝無權所致。脾主統血，脾陽不足失去統攝之權，則血從上溢而為吐血、衄血；血從下走則為便血、崩漏。血色暗淡，四肢不溫，面色萎黃、舌淡苔白，脈沉細無力，皆為中焦虛寒，陰血不足之象。治宜溫陽止血為主，兼以健脾養血","","1. 辨證要點：本方為治療脾陽不足所致的便血或崩漏的常用方。以血色暗淡，舌淡苔白，脈沉細無力為辨證要點。 2. 現代運用：本方常用於消化道出血及功能性子宮出血等屬脾陽不足者。 3. 注意事項：凡熱迫血妄行所致出血者忌用","","黃土湯用芩地黃，朮附阿膠甘草嘗， 溫陽健脾能攝血，吐衄便崩服之康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("128","川芎茶調散","Chuan Xiong Cha Tiao San","Tea-Mix and Chuanxiong Powder","治風劑","《太平惠民和劑局方》","川芎 荊芥各四兩 (各120g) 白芷 羌活 甘草爁，各二兩 (各60g) 細辛一兩 (30g) 防風一兩半 (45g) 薄荷葉八兩 (240g)","散劑。每服6g，日服3次，食後用茶清調服。亦可水煎服，用量按原方比例酌減","疏風止痛","外感風邪頭痛。偏正頭痛，或巔頂作痛，目眩鼻塞，或惡風發熱，舌苔薄白，脈浮","本方所治之頭痛，為外感風邪所致。風邪外襲，上犯頭目，遏阻清陽，經絡氣血不暢，故頭痛，目眩鼻塞；由於風邪所犯之經絡不同，故頭痛有或偏或正，或在巔頂的不同；風邪犯表，則見惡風發熱；舌苔薄白，脈浮為外感風邪的重要佐證。外感風邪而致頭痛，治當疏散風邪以止頭痛","","1. 辨證要點：本方是治療外感風邪頭痛之常用方。臨床應用以頭痛，鼻塞，舌苔薄白，脈浮為辨證要點。 2. 現代運用：本方常用於感冒頭痛、偏頭痛、血管神經性頭痛、慢性鼻炎引起的頭痛等屬於外感風邪所致者。 3. 注意事項：內傷頭痛，不宜使用","菊花茶調散《醫方集解》薄荷八錢 (24g) 川芎 荊芥四錢 (各12g) 羌活 白芷 炙甘草 一錢 (各3g) 防風錢半 (4.5g) 細辛一錢 (3g) 菊花一錢 (3g) 僵蠶三分 (1g) 每三錢 (9g)，食後茶調服。功用：疏風止痛，清利頭目。主治：風熱上犯頭目之偏正頭痛，或巔頂作痛，頭暈目眩","川芎茶調有荊防，辛芷薄荷甘草羌， 目昏鼻塞風攻上，偏正頭痛悉能康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("129","大秦艽湯","Da Qin Jiao Tang","Large Gentian Decoction","治風劑","《素問病機氣宜保命集》","秦艽三兩 (90g) 甘草二兩 (60g) 川芎二兩 (60g) 當歸二兩 (60g) 白芍藥二兩 (60g) 細辛半兩 (15g) 川羌活 防風 黃芩各一兩 (各30g) 石膏二兩 (60g) 吳白芷一兩 (30g) 白朮一兩 (30g) 生地黃一兩 (30g) 熟地黃一兩 (30g) 白茯苓一兩 (30g) 川獨活二兩 (60g)","水煎服。用量按原方比例酌減","疏風清熱，養血活血","風邪初中經絡證。口眼斜，舌強不能言語，手足不能運動，或惡寒發熱，肢體攣急，苔白或黃，脈浮數或弦細","本方所治之中風，乃風邪中於經絡所致。多因正氣不足，營血虛弱，脈絡空虛，風邪乘虛入中，氣血痹阻，經絡不暢，加之 「血弱不能養筋」，筋肉痿弱，而見口眼斜，手足不能運動，舌強不能言語；風邪外襲，故或見惡寒發熱，脈浮等。治以祛風散邪為主，兼以養血、活血通絡為法","","1. 辨證要點：本方是治風邪初中經絡之常用方。臨床應用以口眼斜，舌強不能言語，手足不能運動，微惡風發熱，苔薄微黃，脈浮數為辨證要點。 2. 現代運用：本方常用於腦血管痙攣、腦血栓形成所致的語言蹇澀，半身不遂，以及顏面神經麻痹等屬於風邪初中經絡者；對風濕性關節炎屬於風濕熱痹者，亦可斟酌加減用之。 3. 注意事項：內風證不宜運用","","大秦艽湯羌獨防，辛芷芎芍二地當， 苓朮石膏黃芩草，風邪初中經絡康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("130","小活絡丹","Xiao Huo Luo Dan","Minor Channel-Activating Elixir","治風劑","《太平惠民和劑局方》","川烏炮 草烏炮 地龍 天南星炮，各六兩 (各180g) 乳香 沒藥各二兩二錢 (各66g)","丸劑。每次3g，每日2次，用陳酒或溫開水送服；亦可水煎服，劑量按原方比例酌減，川烏、草烏先煎30分鐘","祛風除濕，化痰通絡，活血止痛","1. 風寒濕痹證。肢體筋脈疼痛，麻木拘攣，關節屈伸不利，疼痛遊走不定，舌淡紫，苔白，脈沉弦或澀。 2. 中風之濕痰瘀血阻絡證。手足不仁，日久不愈，腰腿沉重，或腿臂間作痛等","本方所治之痹證，乃風寒濕邪與瘀血痰濁痹阻經絡所致。風寒濕邪痹著於經絡，日久不愈，以致氣血不得宣通，營衛失其流暢，津液凝聚為痰，血行痹阻為瘀。風寒濕邪與痰瘀交阻，經絡不通，故見肢體筋脈疼痛，麻木拘攣，屈伸不利等；中風手足不仁，日久不愈，而見腰腿沉重，或腿臂間作痛，其理亦同。治宜祛風散寒除濕與化痰、活血兼顧","作丸劑的意義：「丸者，緩也」，取緩治之意。因寒濕痰瘀阻於經絡，為時日久，雖需峻利之品以搜剔，但亦不宜過於峻猛，否則，有形之邪非但不易消散，反而傷正。正氣愈虛，則邪氣益盛。只宜緩消，是 「治之以峻，行之以緩」 之理。故本方雖亦可作湯劑，但以丸劑為好","1. 辨證要點：本方為治療風濕頑痰瘀血留滯經絡的常用方。臨床應用以肢體筋脈攣痛，關節屈伸不利，舌淡紫，苔白為辨證要點。 2. 現代運用：本方常用於慢性風濕性關節炎、類風濕性關節炎、骨質增生症以及坐骨神經痛、肩周炎等屬於風濕痰瘀留滯經絡者。 3. 注意事項：風濕熱痹、陰虛有熱者忌用，體虛及孕婦慎用。川烏、草烏為大毒之品，不宜過量，慎防中毒","大活絡丹《蘭臺軌範》白花蛇 烏梢蛇 威靈仙 兩頭尖俱酒浸 草烏 天麻煨 全蠍去毒 首烏黑豆水浸 龜板炙 麻黃 貫仲 炙甘草 羌活 官桂 藿香 烏藥 黃連 熟地 大黃蒸 木香 沉香 各二兩 (各60g) 細辛 赤芍 沒藥去油，另研 丁香 乳香去油，另研 僵蠶 天南星薑制 青皮 骨碎補 白豆蔻仁 安息香酒熬 黑附子制 黃芩蒸 茯苓 香附酒浸，焙 玄參 白朮 各一兩 (各30g) 防風 二兩半 (75g) 葛根 豹骨炙 當歸 各一兩半 (45g) 血竭另研 七錢 (21g) 地龍炙 水牛角 麝香另研 松脂 各五錢 (15g) 牛黃另研 片腦另研 各一錢五分 (各4.5g) 人參 三兩 (90g) 上共五十味為末，蜜丸如桂圓核大，金箔為衣，每服一丸 (5g)，陳酒送下。功用：祛風濕，益氣血，活絡止痛。主治：風濕痰瘀阻於經絡，正氣不足之中風癱瘓，痿痹，陰疽，流注以及跌打損傷等","小活絡丹天南星，二烏乳沒與地龍， 寒濕瘀血成痹痛，搜風活血經絡通")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("131","牽正散","Qian Zheng San","Symmetry-Correcting Powder","治風劑","《楊氏家藏方》","白附子 白僵蠶 全蠍去毒，各等分，並生用","散劑。每次服3g，熱酒送下，不拘時候。亦可水煎服，用量按原方比例酌定","祛風化痰，通絡止痙","風中頭面經絡。口眼斜，或面肌抽動，舌淡紅，苔白","本方主治之證，為風痰阻於頭面經絡所致。素體陽明內蓄痰濁，陽明外中於風，風痰阻於頭面經絡，經隧不利，筋肉失養，馳緩不用。緩者為急者牽引，故口眼斜；風盛則動，故或面肌抽動。風痰阻於經絡為患，治宜祛風化痰，通絡止痙","","1. 辨證要點：本方是治療風痰阻於頭面經絡之常用方。臨床應用以卒然口眼斜，舌淡苔白為辨證要點。 2. 現代運用：本方常用於顏面神經麻痹、三叉神經痛、偏頭痛等屬於風痰阻於頭面經絡者。 3. 注意事項：氣虛血瘀，或肝風內動之口眼斜，半身不遂，不宜使用。方中白附子、全蠍有一定的毒性，用量不宜過重","止痙散《流行性乙性腦炎中醫治療法》全蠍 蜈蚣 各等分 上研細末，每服1~1.5g，溫開水送服，每日2~4次。功用：祛風止痙，通絡止痛。主治：痙厥，四肢抽搐等。對頑固性頭痛、偏頭痛、關節痛亦有較好的療效","牽正散是楊家方，全蠍僵蠶白附襄， 服用少量熱酒下，口眼斜療效彰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("132","玉真散","Yu Zhen San","True Jade Powder","治風劑","《外科正宗》","南星 防風 白芷 天麻 羌活 白附子 各等分","散劑。內服：每次6g，每日3次，用熱酒調服；若牙關緊急，腰背反張者，每次9g，每日3次，用熱童便調服。外用：適量，敷患處。亦可水煎服，用量按比例酌定","祛風化痰，止痙定搐","破傷風。牙關緊急，口撮唇緊，身體強直，角弓反張，甚則咬牙縮舌，脈弦緊","破傷風為風毒之邪從破傷之處侵入經脈，津液凝聚成痰所致。風勝則動，引動內風，故見牙關緊急，口撮唇緊，身體強直，角弓反張等破傷風之症候。治宜祛風化痰，止痙定搐","","1. 辨證要點：本方為治療破傷風之常用方。臨床應用以有創傷史，牙關緊急，身體強直，角弓反張，脈弦緊為辨證要點。 2. 現代運用：本方常於破傷風、面神經麻痹、三叉神經痛等屬於風邪襲於經絡者。 3. 注意事項：破傷風而見津氣兩虛者，不宜使用；肝經熱盛動風者忌用。白附子、天南星均有毒性，用量宜慎，孕婦忌服","","玉真散治破傷風，牙關緊急反張弓， 星麻白附羌防芷，外敷內服一方通")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("133","消風散","Xiao Feng San","Wind-Dispersing Powder","治風劑","《外科正宗》","當歸 生地 防風 蟬蛻 知母 苦參 胡麻 荊芥 蒼朮 牛蒡子 石膏 各一錢 (各6g) 甘草 木通 各五分 (各3g)","水煎服","疏風除濕，清熱養血","風疹、濕疹。皮膚瘙癢，疹出色紅，或遍身雲片斑點，抓破後滲出津水，苔白或黃，脈浮數","本方所治之風疹、濕疹，為風熱或風濕鬱於肌膚腠理所致，風濕熱邪侵襲人體，浸淫血脈，外不得透達，風不能疏泄，鬱於肌膚腠理，故見皮膚瘙癢，疹出色紅，或抓破後津水流溢等。治宜疏風為主，佐以清熱、除濕之法","","1. 辨證要點：本方是治療風疹、濕疹的常用方。臨床應用以皮膚瘙癢，疹出色紅，脈浮為辨證要點。 2. 現代運用：本方常用於急性蕁麻疹、濕疹、過敏性皮炎、稻田性皮炎、藥物性皮炎、神經性皮炎等屬於風熱或風濕所致者。 3. 注意事項：風疹屬虛寒者，則不宜用。服藥期間，應忌食辛辣、魚腥、煙酒、濃茶等，以免影響療效","","消風散中有荊防，蟬蛻胡麻苦參蒼， 知膏蒡通歸地草，風疹濕疹服之康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("134","羚角鉤藤湯","Ling Jiao Gou Teng Tang","Antelope Horn and Uncaria Decoction","治風劑","《通俗傷寒論》","羚角片 錢半 (4.5g)，先煎 霜桑葉 二錢 (6g) 京貝母 四錢，去心 (12g) 鮮生地 五錢 (15g) 雙鉤藤 三錢 (9g)，後入 滁菊花 三錢 (9g) 茯神木三錢 (9g) 生白芍 三錢 (9g) 生甘草 八分 (2.4g) 淡竹茹 五錢，鮮刮 (15g)，與羚羊角先煎代水","水煎服","涼肝熄風，增液舒筋","熱盛動風證。高熱不退，煩悶躁擾，手足抽搐，發為痙厥，甚則神昏，舌絳而乾，或舌焦起刺，脈弦而數","本方所治之證，為溫熱病邪內傳厥陰，肝經熱盛，熱極動風所致。肝經熱盛，故高熱不退；熱盛動風，風火相煽，且熱盛灼津耗液，筋脈失養，故手足抽搐，發為痙厥。邪熱灼津煉液為痰，痰熱內擾心神，則煩悶躁擾，甚則神昏；舌絳而乾，或舌焦起刺，脈弦而數，為肝經熱盛陰傷之象。治宜清熱涼肝熄風為主，佐以養陰增液舒筋為法","","1. 辨證要點：本方是治療肝經熱盛動風的常用方。臨床應用以高熱煩躁，手足抽搐，舌絳而乾，脈弦數為辨證要點。 2. 現代運用：本方常用於乙腦以及妊娠子癇、高血壓所致的頭痛、眩暈、抽搐等屬肝經熱盛、熱極動風，或肝熱風陽上逆者。 3. 注意事項：溫病後期，熱勢已衰，陰液大虧，虛風內動者，不宜用","鉤藤飲《醫宗金鑒》人參 (3g) 全蠍 去毒 (1g) 羚羊角 (0.5g) 天麻 (6g) 甘草 炙 (1.5g) 鉤藤鉤 (9g) 水煎服。功用：清熱熄風，益氣解痙。主治：小兒天釣。壯熱驚悸，牙關緊閉，手足抽搐，頭目仰視等","羚角鉤藤菊花桑，地芍貝茹伏草襄， 涼肝熄風又養陰，肝熱生風急煎嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("135","鎮肝熄風湯","Zhen Gan Xi Feng Tang","Liver-Sedating and Wind-Extinguishing Decoction","治風劑","《醫學衷中參西錄》","懷牛膝一兩 (30g) 生赭石一兩 (30g) 生龍骨五錢 (15g) 生牡蠣五錢 (15g) 生龜板五錢 (15g) 生杭芍五錢 (15g) 玄參五錢 (15g) 天冬五錢 (15g) 川楝子二錢 (6g) 生麥芽二錢 (6g) 茵陳二錢 (6g) 甘草一錢半 (4.5g)","水煎服","鎮肝熄風，滋陰潛陽","類中風。頭目眩暈，目脹耳鳴，腦部熱痛，面色如醉，心中煩熱；或時常噫氣；或肢體漸覺不利，口眼漸形歪斜；甚或眩暈顛仆，昏不知人，移時始醒，或醒後不能復元，脈弦長有力","本方所治之類中風，是由肝腎陰虛，肝陽偏亢，肝風內動，氣血逆亂，並走於上所致。肝腎陰虛，肝陽偏亢，陽亢化風，風陽上擾，故見頭目眩暈，目脹耳鳴；血隨風陽上逆，氣血並走於上，則腦部熱痛，面紅如醉；甚或氣血逆亂，發為中風，輕者中經絡，見肢體漸覺不利，口眼漸形歪斜；重者中臟腑，猝然眩暈顛仆，不知人事。脈弦長有力，為肝陽有餘之征。本證以肝腎陰虛為本，肝陽上亢，氣血逆亂為標，但以標實為主。治以鎮肝熄風，引血下行為主，佐以滋養肝腎之法","肝陽上亢，風陽上擾之證，為何配伍疏肝理氣之品？ 肝為將軍之官，其性剛強，性喜升發條達而惡抑鬱。過用重鎮降逆之品以強制肝陽下行，勢必影響其升發條達之性而致抑鬱不舒，肝氣越鬱則愈逆。故配疏肝理氣之品，以順其升發條達之性，使肝氣不鬱，則肝陽易於潛降","1. 辨證要點：本方是治療類中風之常用方。臨床應用，無論是中風之前，還是中風之時，抑或中風之後，皆可運用。以頭目眩暈，腦部熱痛，面色如醉，脈弦長有力為辨證要點。 2. 現代運用：本方常用於高血壓、腦血栓形成、腦出血、血管神經性頭痛等屬於肝腎陰虛，肝陽上亢者。 3. 注意事項：氣虛血瘀之中風，不宜用","建瓴湯《醫學衷中參西錄》生淮山藥 一兩 (30g) 懷牛膝 一兩 (30g) 生赭石 八錢 (24g)，軋細 生龍骨 六錢 (18g)，搗細 生牡蠣 六錢 (18g)，搗細 生懷地黃 六錢 (18g) 生杭芍四錢 (12g) 柏子仁 四錢 (12g) 磨取鐵銹濃水，以之煎藥。功用：鎮肝熄風，滋陰安神。主治：肝腎陰虛，肝陽上亢證。頭目眩暈，耳鳴目脹，健忘，煩躁不寧，失眠多夢，脈弦硬而長","鎮肝熄風芍天冬，玄參龜板赭茵從， 龍牡麥芽膝草楝，肝陽上亢能奏功")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("136","天麻鉤藤飲","Tian Ma Gou Teng Yin","Gastrodia and Uncaria Decoction","治風劑","《中醫內科雜病證治新義》","天麻 (9g) 鉤藤 (12g) 生決明 (18g) 山梔 黃芩 (各9g) 川牛膝 (12g) 杜仲 益母草 桑寄生 夜交藤 朱茯神 (各9g)","水煎服","平肝熄風，清熱活血，補益肝腎","肝陽偏亢，肝風上擾證。頭痛，眩暈，失眠多夢，或口苦面紅，舌紅苔黃，脈弦或數","本方證由肝腎不足，肝陽偏亢，生風化熱所致。肝陽偏亢，風陽上擾，故頭痛、眩暈；肝陽有餘，化熱擾心，則心神不安，失眠多夢；舌紅苔黃，脈弦數，為陽亢化熱之征。本證本虛標實，以標實為主，故治以平肝熄風為主，佐以清熱安神，補益肝腎之法","","1. 辨證要點：本方是治療肝陽偏亢，肝風上擾的常用方。臨床應用以頭痛，眩暈，失眠，舌紅苔黃，脈弦為辨證要點。 2. 現代運用：本方常用於高血壓、腦血管意外、內耳性眩暈等屬於肝陽上亢，肝風上擾者","","天麻鉤藤石決明，梔杜寄生膝與芩， 夜藤茯神益母草，主治眩暈與耳鳴")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("137","大定風珠","Da Ding Feng Zhu","Major Wind-Stabilizing Pill","治風劑","《溫病條辨》","生白芍 六錢 (18g) 阿膠 三錢 (9g) 生龜板 四錢 (12g) 乾地黃 六錢 (18g) 麻仁 二錢 (6g) 五味子 二錢 (6g) 生牡蠣 四錢 (12g) 麥冬連心，六錢 (18g) 炙甘草 四錢 (12g) 雞子黃生，二枚 (2個) 鱉甲生，四錢 (12g)","水煎服。阿膠烊化，再入雞子黃，攪勻","滋陰熄風","陰虛風動證。手足瘈疭，形消神倦，舌絳少苔，脈氣虛弱，時時欲脫者","本方所治之證，乃溫病後期，邪熱久羈，灼傷真陰，或因誤汗、妄攻，重傷陰液，陰虛風動所致。肝腎陰液大虧，水不涵木，虛風內動，故手足瘈疭；真陰欲竭，陽無所附，故見形瘦神倦，舌絳少苔，脈氣虛弱，有時時欲脫之勢。此證病機的特點是，邪熱已去八、九，真陰僅存一、二，且有欲脫之勢。治當滋陰養液，以填補欲竭之真陰，平熄內動之虛風","","1. 辨證要點：本方是治溫病後期，真陰大虧，虛風內動之常用方。臨床應用以瘈疭神倦，舌絳少苔，脈虛弱為辨證要點。 2. 現代運用：本方常用於乙腦後遺症、中風後遺症、甲壯腺功能亢進症、神經性震顫等屬於陰虛風動者。 3. 注意事項：若陰液雖虧而邪熱尤盛者，則非本方所宜","1. 三甲復脈湯《溫病條辨》炙甘草 六錢 (18g) 乾地黃 六錢 (18g) 生白芍 六錢 (18g) 麥冬 不去心，五錢 (15g) 阿膠 三錢 (9g) 麻仁 三錢 (9g) 生牡蠣 五錢 (15g) 生鱉甲 八錢 (24g) 生龜板 一兩 (30g) 水八杯，煮取三杯，分三次服。功用：滋陰熄風。主冶：溫病邪熱久羈下焦，熱深厥甚，心中憺憺大動，甚則心中痛，或手足蠕動，舌絳少苔，脈細促者。 2. 阿膠雞子黃湯《通俗傷寒論》陳阿膠 二錢 (6g)，烊沖 生白芍 三錢 (9g) 石決明五錢 (15g)，杵 雙鉤藤 二錢 (6g) 大生地 四錢 (12g) 清甘草 六分 (2g) 生牡蠣 四錢 (12g)，杵 絡石藤 三錢 (9g) 茯神木 四錢 (12g) 雞子黃 二枚 (2個)，先煎代水 水煎服。功用：滋陰養血，柔肝熄風。主治：邪熱久羈，陰血不足，虛風內動。筋脈拘急，手足瘈疭，心煩不寐，或頭目眩暈，舌絳少苔，脈細數","大定風珠雞子黃，麥地膠芍草麻襄， 三甲並同五味子，滋陰熄風是妙方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("138","杏蘇散","Xing Su San","Apricot Kernel and Perilla Powder","治燥劑","《溫病條辨》","蘇葉 (9g) 半夏 (9g) 茯苓 (9g) 前胡 (9g) 苦桔梗 (6g) 枳殼 (6g) 甘草 (3g) 生薑 (3片) 大棗 (3枚) 杏仁 (9g) 橘皮 (6g) (原書未著用量)","水煎溫服","輕宣涼燥，理肺化痰","外感涼燥證。惡寒無汗，頭微痛，咳嗽痰稀，鼻塞，咽乾，苔白，脈弦","本方證為涼燥外襲，肺氣失宣，痰濕內阻所致。涼燥傷及皮毛，故惡寒無汗，頭微痛，所謂頭微痛者，不似傷寒之痛甚也。涼燥傷肺，肺失宣降，津液不布，聚而為痰，則咳嗽痰稀；涼燥束肺，肺氣不利，而致鼻塞、咽乾。苔白、脈弦為涼燥兼痰濕佐證。遵《素問》至真要大論 「燥淫於內，治以苦溫，佐以甘辛」 之旨，治當輕宣涼燥為主，輔以理肺化痰","","1. 辨證要點：本方為輕宣涼燥的代表方，亦是治療風寒咳嗽的常用方。臨床應用以惡寒無汗，咳嗽痰稀，咽乾，苔白，脈弦為辨證要點。 2. 現代運用：本方常用於上呼吸道感染、慢性支氣管炎、肺氣腫等證屬外感涼燥 (或外感風寒輕證)，肺氣不宣，痰濕內阻者。 3. 注意事項：若涼燥化熱則不宜使用","","杏蘇散內夏陳前，枳桔苓草薑棗研， 輕宣溫潤治涼燥，咳止痰化病自痊")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("139","桑杏湯","Sang Xing Tang","Mulberry Leaf and Apricot Kernel Decoction","治燥劑","《溫病條辨》","桑葉一錢 (3g) 杏仁一錢五分 (4.5g) 沙參二錢 (6g) 象貝一錢 (3g) 香豉一錢 (3g) 梔皮一錢 (3g) 梨皮一錢 (3g)","水二杯，煮取一杯，頓服之，重者再作服 (現代用法：水煎服)","清宣溫燥，潤肺化痰","外感溫燥證。身熱不甚，口渴，咽乾鼻燥，乾咳無痰，或痰少而粘，舌紅，苔薄白而乾，脈浮數而右脈大者","本方證系溫燥外襲，肺津受灼之輕證。因秋感溫燥之氣，傷於肺衛，其病輕淺，故身熱不甚；燥氣傷肺，耗津灼液，肺失清肅，故口渴，咽乾鼻燥，乾咳無痰，或痰少而粘。本方證雖似於風熱表證，但因溫燥為患，肺津已傷，故治當外以清宣燥熱，內以潤肺化痰","","1. 辨證要點：本方為治療溫燥傷肺輕證的常用方。臨床應用以身熱不甚，乾咳無痰或痰少而粘，右脈數大為辨證要點。 2. 現代運用：本方常用於上呼吸道感染、急慢性支氣管炎、支氣管擴張咯血、百日咳等證屬外感溫燥，邪犯肺衛者。 3. 注意事項：因本方證邪氣輕淺，故諸藥用量較輕，且煎煮時間也不宜過長，正如原書方後注云：「輕藥不得重用，重用必過病所」","","桑杏湯中象貝宜，沙參梔豉與梨皮， 乾咳鼻燥右脈大，辛涼甘潤燥能醫")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("140","清燥救肺湯","Qing Zao Jiu Fei Tang","Eliminate Dryness and Rescue the Lung Decoction","治燥劑","《醫門法律》","桑葉經霜者，去枝梗，淨葉三錢 (9g) 石膏煆，二錢五分 (8g) 甘草一錢 (3g) 人參七分 (2g) 胡麻仁炒，研，一錢 (3g) 真阿膠八分 (3g) 麥門冬去心，一錢二分 (4g) 杏仁泡，去皮尖，炒黃，七分 (2g) 枇杷葉一片，刷去毛，蜜塗，炙黃 (3g)","水一碗，煎六分，頻頻二三次滾熱服 (現代用法：水煎，頻頻熱服)","清燥潤肺，養陰益氣","溫燥傷肺，氣陰兩傷證。身熱頭痛，乾咳無痰，氣逆而喘，咽喉乾燥，鼻燥，心煩口渴，胸滿脅痛，舌乾少苔，脈虛大而數","本方所治乃溫燥傷肺之重證。秋令氣候乾燥，燥熱傷肺，故頭痛身熱；肺為熱灼，氣陰兩傷，失其清肅潤降之常，故乾咳無痰，氣逆而喘，口渴鼻燥；《素問》至真要大論說：「諸氣膹鬱，皆屬於肺」，肺氣不降，故胸膈滿悶/甚則脅痛。舌乾少苔、脈虛大而數均為溫燥傷肺佐證。治當清宣潤肺與養陰益氣兼顧","","1. 辨證要點：本方為治療溫燥傷肺重證的常用方。臨床應用以身熱，乾咳無痰，氣逆而喘，舌紅少苔，脈虛大而數為辨證要點。 2. 現代運用：肺炎、支氣管哮喘、急慢性支氣管炎、支氣管擴張、肺癌等屬燥熱犯肺，氣陰兩傷者","","清燥救肺桑麥膏，參膠胡麻杏杷草， 清宣潤肺養氣陰，溫燥傷肺氣陰耗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("141","增液湯","Zeng Ye Tang","Humor-Increasing Decoction","治燥劑","《溫病條辨》","玄參一兩 (30g) 麥冬連心，八錢 (24g) 細生地八錢 (24g)","水八杯，煮取三杯，口乾則與飲令盡；不便，再作服 (現代用法：水煎服)","增液潤燥","陽明溫病，津虧便秘證。大便秘結，口渴，舌乾紅，脈細數或沉而無力","陽明溫病不大便，不外熱結、液乾兩端。若陽邪熾盛，熱結之實證，則用承氣湯急下存陰；若熱病陰虧液涸，《溫病條辨》所謂 「水不足以行舟，而結糞不下者」，當增水行舟。本方所治大便秘結，即為熱病耗損津液，陰虧液涸，不能濡潤大腸，「無水舟停」 所致。津液虧乏，不能上承，則口渴。舌乾紅，脈細數者，為陰虛內熱之象；脈沉而無力者，主裏主虛之候。治宜增液潤燥","","1. 辨證要點：本方為治療津虧腸燥所致大便秘結之常用方，又是治療多種內傷陰虛液虧病證的基礎方。臨床以便秘，口渴，舌乾紅，脈細數或沉而無力為辨證要點。 2. 現代運用：本方常用於慢性咽喉炎、復發性口腔潰瘍、糖尿病、皮膚乾燥綜合征、肛裂、慢性牙周炎等證屬陰液不足者","增液承氣湯《溫病條辨》玄參一兩 (30g) 麥冬連心，八錢 (24g) 細生地八錢 (24g) 大黃三錢 (9g) 芒硝一錢五分 (4.5g) 水八杯，煮取二杯，先服一杯，不知，再服。功用：滋陰增液，泄熱通便。主治：熱結陰虧證。燥屎不行，下之不通，脘腹脹滿，口乾唇燥，舌紅苔黃，脈細數","增液玄參與地冬，熱病津枯便不通， 補藥之體作瀉劑，若非重用不為功")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("142","麥門冬湯","Mai Men Dong Tang","Ophiopogon Decoction","治燥劑","《金匱要略》","麥門冬七升 (42g) 半夏一升 (6g) 人參三兩 (9g) 甘草二兩 (6g) 粳米三合 (3g) 大棗四枚 (2枚)","上六味，以水一斗二升，煮取六升，溫服一升，日三夜一服 (現代用法：水煎服)","清養肺胃，降逆下氣","1. 虛熱肺痿。咳嗽氣喘，咽喉不利，咯痰不爽，或咳吐涎沫，口乾咽燥，手足心熱，舌紅少苔，脈虛數。 2. 胃陰不足證。嘔吐，納少，呃逆，口渴咽乾，舌紅少苔，脈虛數","本方所治虛熱肺痿乃肺胃陰虛，氣火上逆所致。病雖在肺，其源在胃。蓋土為金母，胃主津液，胃津不足，則肺之陰津亦虧，終成肺胃陰虛之證。肺胃陰虛，虛火灼津為痰，肺失清肅，則咳逆上氣，咳吐涎沫；咽喉為肺胃之門戶，肺胃陰傷，津不上承，則口乾咽燥；虛熱內盛，故手足心熱。胃陰不足，失和氣逆則嘔吐；舌紅少苔、脈虛數為陰虛內熱之佐證。治宜清養肺胃，降逆下氣","","1. 辨證要點：本方為治療肺胃陰虛，氣機上逆所致咳嗽或嘔吐之常用方。臨床應用以咳唾涎沫，短氣喘促，或口乾嘔逆，舌乾紅少苔，脈虛數為辨證要點。 2. 現代運用：本方常用於慢性支氣管炎、支氣管擴張、慢性咽喉炎、矽肺、肺結核等屬肺胃陰虛，氣火上逆者。亦治胃及十二指腸潰瘍、慢性萎縮性胃炎、妊娠嘔吐等屬胃陰不足，氣逆嘔吐者","","麥門冬湯用人參，棗草粳米半夏存， 肺痿咳逆因虛火，清養肺胃此方珍")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("143","益胃湯","Yi Wei Tang","Stomach-Boosting Decoction","治燥劑","《溫病條辨》","沙參三錢 (9g) 麥冬五錢 (15g) 冰糖一錢 (3g) 細生地五錢 (15g) 玉竹炒香，一錢五分 (4.5g)","水五杯，煮取二杯，分二次服，渣再煮一杯服 (現代用法：水煎2次分服)","養陰益胃","胃陰損傷證。胃脘灼熱隱痛，饑不欲食，口乾咽燥，大便乾結，舌紅少苔，脈細數者","胃為陽土，喜潤惡燥，主受納，其氣以降為順。若熱病消灼陰津，或過食辛辣之物，或過用吐、下之劑，或胃病遷延不愈，每致胃陰耗損，虛熱內生。胃陰不足，絡脈失養，則胃脘隱痛；若陰虛有熱，則見胃脘灼痛；受納失司，故而饑不欲食。胃之陰津不足，上不能滋潤口咽則口乾咽燥，下不能濡潤大腸則便結。舌紅少苔，脈細數為陰虛內熱之征。胃為水穀之海，十二經皆稟氣於胃，胃陰復則氣降能食。故治宜甘涼生津，養陰益胃為法","","1. 辨證要點：本方為滋養胃陰的常用方。以胃脘灼熱隱痛，食欲不振，口乾咽燥，舌紅少苔，脈細數為辨證要點。 2. 現代運用：本方常用於慢性胃炎、糖尿病、小兒厭食等證屬胃陰虧損者","玉液湯《醫學衷中參西錄》生山藥一兩 (30g) 生黃芪五錢 (15g) 知母六錢 (18g) 生雞內金二錢，搗細 (6g) 葛根錢半 (6g) 五味子三錢 (9g) 天花粉三錢 (9g) 水煎服。功用：益氣滋陰，固腎止渴。主治：消渴氣陰兩虛證。口乾而渴，飲水不解，小便數多，困倦氣短，脈虛細無力","溫病條辨益胃湯，沙參麥地合成方， 玉竹冰糖同煎服，溫病須慮把津傷")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("144","養陰清肺湯","Yang Yin Qing Fei Tang","Yin-Nourishing and Lung-Clearing Decoction","治燥劑","《重樓玉鑰》","大生地二錢 (6g) 麥冬一錢二分 (9g) 生甘草五分 (3g) 玄參錢半 (9g) 貝母去心，八分 (5g) 丹皮八分 (5g) 薄荷五分 (3g) 白芍炒，八分 (5g)","水煎服。一般日服1劑，重證可日服2劑","養陰清肺，解毒利咽","白喉之陰虛燥熱證。喉間起白如腐，不易拭去，咽喉腫痛，初起或發熱或不發熱，鼻乾唇燥，或咳或不咳，呼吸有聲，似喘非喘，脈數無力或細數","白喉一證，多由素體陰虛蘊熱，復感燥氣疫毒，津液被灼，熱毒薰蒸於上所致。《重樓玉鑰》卷上云：「緣此證發於肺腎，凡本質不足者，或遇燥氣流行，或多食辛熱之物，感觸而發」。喉為肺系，少陰腎脈循喉嚨系舌本，肺腎陰虛，虛火上炎，復加燥熱疫毒上犯，肺失清肅，以致喉間起白如腐，咽喉腫痛，或咳或不咳，呼吸有聲，似喘非喘等症；鼻乾唇燥，脈數無力或細數。乃燥熱傷津，正虛蘊毒之征。治之之法，「不外肺腎，總要養陰清肺，兼辛涼而散為主」。《重樓玉鑰》卷上","","1. 辨證要點：本方是治療陰虛燥熱白喉的常用方。以喉間起白如腐，不易拭去，咽喉腫痛，鼻乾唇燥，脈數無力為辨證要點。白喉忌表，尤忌辛溫發汗，據原方後記載；「如有內熱及發熱，不必投表藥，照方服去，其熱自除」。 2. 現代運用：常用於急性扁桃體炎、急性咽喉炎、鼻咽癌等證屬陰虛燥熱者","","養陰清肺是妙方，玄參草芍冬地黃， 薄荷貝母丹皮入，時疫白喉急煎嘗")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("145","百合固金湯","Bai He Gu Jin Tang","Lily Bulb Metal-Securing Decoction","治燥劑","《慎齋遺書》","熟地 生地 當歸身各三錢 (9g) 白芍 (6g) 甘草 (3g) 各一錢 桔梗 (6g) 玄參各八分 (3g) 貝母 (6g) 麥冬 (9g) 百合 (12g) 各一錢半","水煎服","滋養肺腎，止咳化痰","肺腎陰虧，虛火上炎證。咳嗽氣喘，痰中帶血，咽喉燥痛，頭暈目眩，午後潮熱，舌紅少苔，脈細數","本方證由肺腎陰虧所致。肺乃腎之母，肺虛及腎，病久則肺腎陰虛，陰虛生內熱，虛火上炎，肺失肅降，則咳嗽氣喘；虛火煎灼津液，則咽喉燥痛，午後潮熱，甚者灼傷脈絡，以致痰中帶血。治宜滋養肺腎之陰血，兼以清熱化痰止咳，以圖示本兼顧","","1. 辨證要點：本方為治療肺腎陰虧，虛火上炎而致咳嗽痰血證的常用方。臨床應用以咳嗽氣喘，咽喉燥痛，舌紅少苔，脈細數為辨證要點。 2. 現代運用：本方常用於肺結核、慢性支氣管炎、支氣管擴張咯血、慢性咽喉炎、自發性氣胸等屬肺腎陰虛，虛火上炎者","補肺阿膠湯《小兒藥證直訣》阿膠麩炒，一兩五錢 (9g) 黍粘子 (牛蒡子) 炒香，二錢五分 (3g) 炙甘草，二錢五分 (1.5g) 馬兜鈴焙，五錢 (6g) 杏仁去皮尖，七個 (6g) 糯米炒，一兩 (6g) 上為細末，每服一二錢 (6g)，水煎，食後溫服。功用：養陰補肺，清熱止血。主治：小兒肺陰虛有熱證。咳嗽氣喘，咽喉乾燥，喉中有聲，或痰中帶血，舌紅少苔，脈細數","百合固金二地黃，玄參貝母桔草藏， 麥冬芍藥當歸配，喘咳痰血肺家傷")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("146","平胃散","Ping Wei San","Stomach-Calming Powder","祛濕劑","《簡要濟眾方》","蒼朮去黑皮，搗為粗末，炒黃色，四兩 (120g) 厚樸去粗皮，塗生薑汁，炙令香熟，三兩 (90g) 陳橘皮洗令淨，焙乾，二兩 (60g) 炙甘草黃，一兩 (30g)","共為細末，每服4~6g，薑棗煎湯送下；或作湯劑，水煎服","燥濕運脾，行氣和胃","濕滯脾胃證。脘腹脹滿，不思飲食，口淡無味，噁心嘔吐，噯氣吞酸，肢體沉重，怠惰嗜臥，常多自利，舌苔白膩而厚，脈緩","本方證由濕滯脾胃所致。脾為太陰濕土，居中州而主運化，其性喜燥惡濕，濕邪滯於中焦，則脾運不健，且氣機受阻，故見脘腹脹滿、食少無味；胃失和降，上逆而為嘔吐噁心、噯氣吞酸；濕為陰邪，其性重著粘膩，故為肢體沉重、怠惰嗜臥。濕邪中阻，下注腸道，則為泄瀉。治當燥濕運脾為主，兼以行氣和胃，使氣行則濕化","","1. 辨證要點：本方為治療濕滯脾胃證之基礎方。臨床應用以脘腹脹滿，舌苔厚膩為辨證要點。 2. 現代運用：本方常用於慢性胃炎、消化道功能紊亂、胃及十二指腸潰瘍等辨證屬濕滯脾胃者。 3. 注意事項：因本方辛苦溫燥，陰虛氣滯，脾胃虛弱者，不宜使用","1. 不換金正氣散《易簡方》藿香 厚樸 蒼朮 陳皮 半夏 甘草各等分 (各10g) 上為散，每服四錢 (12g)，水一盞，加生薑三片，煎至六分，去滓熱服。功用：解表化濕，和胃止嘔。主治：濕濁內停，兼有表寒證。嘔吐腹脹，惡寒發熱，或霍亂吐瀉，或不服水土，舌苔白膩等。 2. 柴平湯《景嶽全書》柴胡 黃芩 人參 半夏 甘草 陳皮 蒼朮 厚樸 加薑棗煎服。功用：和解少陽，祛濕和胃。主治：濕瘧。一身盡疼，手足沉重，寒多熱少，脈濡","平胃散內君蒼朮，厚樸陳草薑棗煮， 燥濕運脾又和胃，濕滯脾胃脹滿除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("147","藿香正氣散","Huo Xiang Zheng Qi San","Agastache Qi-Correcting Powder","祛濕劑","《太平惠民和劑局方》","大腹皮 白芷 紫蘇 茯苓去皮，各一兩 (30g) 半夏曲 白朮 陳皮去白 厚樸去粗皮，薑汁炙 苦桔梗各二兩 (各60g) 藿香去土，三兩 (90g) 炙甘草，二兩半 (75g)","散劑，每服9g，生薑、大棗煎湯送服；或作湯劑，加生薑、大棗，水煎服","解表化濕，理氣和中","外感風寒，內傷濕滯證。惡寒發熱，頭痛，胸膈滿悶，脘腹疼痛，噁心嘔吐，腸鳴泄瀉，舌苔白膩，以及山嵐瘴瘧等","本方證由外感風寒，內傷濕滯所致，為夏月常見病證。風寒外束，衛陽鬱遏，故見惡寒發熱等表證；內傷濕滯，濕濁中阻，脾胃不和，升降失常，則為上吐下瀉；濕阻氣滯，則胸膈滿悶、脘腹疼痛。治宜外散風寒，內化濕濁，兼以理氣和中之法。 感受山嵐瘴氣及水土不服者，本方亦可治之","","1. 辨證要點：本方為治外感風寒，內傷濕滯證之常用方。臨床應用以惡寒發熱，上吐下瀉，舌苔白膩為辨證要點。 2. 現代運用：本方常用於急性胃腸炎或四時感冒辨證屬濕滯脾胃，外感風寒者。 3. 注意事項：本方重在化濕和胃，解表散寒之力較弱，故服後宜溫覆以助解表。濕熱霍亂之吐瀉，則非本方所宜","六和湯《太平惠民和劑局方》縮砂仁 半夏湯泡七次 杏仁去皮尖 人參 炙甘草，各一兩 (各30g) 赤茯苓去皮 藿香葉拂去塵 白扁豆薑汁略炒 木瓜各二兩 (各60g) 香薷 厚樸薑汁制，各四兩 (各120g) 上銼，每服四錢 (12g) 水一盞半，生薑三片，棗子一枚，煎至八分，去滓，不拘時服 (現代用法：亦可作湯劑，水煎服，用量按原方比例酌定)。功用：祛暑化濕，健脾和胃。主治：濕傷脾胃，暑濕外襲。霍亂吐瀉，倦怠嗜臥，胸膈痞滿，舌苔白滑等","藿香正氣腹皮蘇，甘桔陳苓樸白朮， 夏曲白芷加薑棗，風寒暑濕並能除")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("148","茵陳蒿湯","Yin Chen Hao Tang","Virgate Wormwood Decoction","祛濕劑","《傷寒論》","茵陳六兩 (18g) 梔子十四枚 (12g) 大黃二兩 (6g)，去皮","水煎服","清熱，利濕，退黃","濕熱黃疸。一身面目俱黃，黃色鮮明，發熱，無汗或但頭汗出，口渴欲飲，噁心嘔吐，腹微滿，小便短赤，大便不爽或秘結，舌紅苔黃膩，脈沉數或滑數有力","本方為治療濕熱黃疸之常用方，《傷寒論》用其治療瘀熱發黃，《金匱要略》以其治療穀疸。病因皆緣於邪熱入裏，與脾濕相合，濕熱壅滯中焦所致。濕熱壅結，氣機受阻，故腹微滿、噁心嘔吐、大便不爽甚或秘結；無汗而熱不得外越，小便不利則濕不得下泄，以致濕熱薰蒸肝膽，膽汁外溢，浸漬肌膚，則一身面目俱黃、黃色鮮明；濕熱內鬱，津液不化，則口中渴。舌苔黃膩，脈沉數為濕熱內蘊之征。治宜清熱，利濕，退黃","","1. 辨證要點：本方為治療濕熱黃疸之常用方，其證屬濕熱並重。臨床應用以一身面目俱黃，黃色鮮明，舌苔黃膩，脈沉數或滑數有力為辨證要點。 2. 現代運用： 本方常用於急性黃疸型傳染性肝炎、膽囊炎、膽石症、鉤端螺旋體病等所引起的黃疸，辨證屬濕熱內蘊者","1. 梔子柏皮湯《傷寒論》梔子十五枚 (10g) 甘草一兩，炙 (3g) 黃柏二兩 (6g) 上三味，以水四升，煮取一升半，去滓，分溫再服。功用：清熱利濕。主治：黃疸，熱重於濕證。身熱，發黃，心煩懊，口渴，苔黃。 2. 茵陳四逆湯《傷寒微旨論》甘草 茵陳各二兩 (各6g) 乾薑一兩半 (4.5g) 附子一個，破八片 (6g) 功用：溫裏助陽，利濕退黃。主治：陰黃。黃色晦暗，皮膚冷，背惡寒，手足不溫，身體沉重，神倦食少，口不渴或渴喜熱飲，大便稀溏，舌淡苔白，脈緊細或沉細無力","茵陳蒿湯大黃梔，瘀熱陽黃此方施， 便難尿赤腹脹滿，功在清熱與利濕")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("149","八正散","Ba Zheng San","Eight Corrections Powder","祛濕劑","《太平惠民和劑局方》","車前子 瞿麥 萹蓄 滑石 山梔子仁 炙甘草 木通 大黃面裹煨，去面，切，焙，各一斤 (各500g)","散劑，每服6~10g，燈心煎湯送服；湯劑，加燈心，水煎服","清熱瀉火，利水通淋","濕熱淋證。尿頻尿急，溺時澀痛，淋瀝不暢，尿色渾赤，甚則癃閉不通，小腹急滿，口燥咽乾，舌苔黃膩，脈滑數","本方證因濕熱下注膀胱所致。濕熱下注蘊於膀胱，水道不利，故尿頻尿急、溺時澀痛、淋瀝不暢，甚則癃閉不通；濕熱蘊蒸，故尿色渾赤；濕熱鬱遏，氣機不暢，則少腹急滿；津液不布，則口燥咽乾。治宜清熱利水通淋","","1. 辨證要點：本方為主治濕熱淋證之常用方。臨床應用以尿頻尿急，溺時澀痛，舌苔黃膩，脈滑數為辨證要點。 2. 現代運用：常用於膀胱炎、尿道炎、急性前列腺炎、泌尿系結石、腎盂腎炎、術後或產後尿瀦留等辨證屬濕熱下注者","五淋散《太平惠民和劑局方》赤茯苓六兩 (180g) 當歸去蘆 甘草生用，各五兩 (各150g) 赤芍藥去蘆，剉 山梔仁各二十兩 (各600g) 上為細末，每服二錢 (6g)，水一盞，煎至八分，空心食前服。功用：清熱涼血，利水通淋。主治：濕熱血淋，尿如豆汁，溺時澀痛，或溲如砂石，臍腹急痛","八正木通與車前，萹蓄大黃梔滑研， 草梢瞿麥燈心草，濕熱諸淋宜服煎")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("150","三仁湯","San Ren Tang","Three Kernels Decoction","祛濕劑","《溫病條辨》","杏仁五錢 (15g) 飛滑石六錢 (18g) 白通草二錢 (6g) 白蔻仁二錢 (6g) 竹葉二錢 (6g) 厚樸二錢 (6g) 生薏苡仁六錢 (18g) 半夏五錢 (15g)","水煎服","宣暢氣機，清利濕熱","濕溫初起及暑溫夾濕之濕重於熱證。頭痛惡寒，身重疼痛，肢體倦怠，面色淡黃，胸悶不饑，午後身熱，苔白不渴，脈弦細而濡","本方是治療濕溫初起，邪在氣分，濕重於熱的常用方劑。究其病因，一為外感濕熱之邪；一為濕飲內停，再感外邪，內外合邪，釀成濕溫。衛陽為濕邪遏阻，則見頭痛惡寒；濕性重濁，故身重疼痛、肢體倦怠；濕熱蘊於脾胃，運化失司，氣機不暢，則見胸悶不饑；濕為陰邪，旺於申酉，邪正交爭，故午後身熱","其證頗多疑似，每易誤治，如惡寒一證，為濕邪遏阻衛陽所致，與表證之惡寒有別；午後身熱，為濕遏熱伏所致，與陰虛之潮熱不同。故吳瑭於《溫病條辨》中明示 「三戒」：一者，不可見其頭痛惡寒，以為傷寒而汗之，汗傷心陽，則神昏耳聾，甚則目瞑不欲言；二者，不可見其中滿不饑，以為停滯而下之，下傷脾胃，濕邪乘勢下注，則為洞泄；三者，不可見其午後身熱，以為陰虛而用柔藥潤之，濕為膠滯陰邪，再加柔潤陰藥，兩陰相合，則有錮結不解之勢。故治療之法，惟宜宣暢氣機、清熱利濕","1. 辨證要點：本方主治屬濕溫初起，濕重於熱之證。臨床應用以頭痛惡寒，身重疼痛，午後身熱，苔白不渴為辨證要點。 2. 現代運用：本方常用於腸傷寒、胃腸炎、腎盂腎炎、布氏桿菌病、腎小球腎炎以及關節炎等辨證屬濕重於熱者。 3. 注意事項：舌苔黃膩，熱重於濕者則不宜使用","1. 藿樸夏苓湯《感證輯要》引《醫原》藿香二錢 (6g) 半夏錢半 (4.5g) 赤苓三錢 (9g) 杏仁三錢 (9g) 生苡仁四錢 (12g) 白蔻仁一錢 (3g) 通草一錢 (3g) 豬苓三錢 (9g) 淡豆豉三錢 (9g) 澤瀉錢半 (4.5g) 厚樸一錢 (3g) 水煎服。功用：解表化濕。主治：濕溫初起，身熱惡寒，肢體倦怠，胸悶口膩，舌苔薄白，脈濡緩。 2. 黃芩滑石湯《溫病條辨》黃芩三錢 (9g) 滑石三錢 (9g) 茯苓皮三錢 (9g) 大腹皮二錢 (6g) 白蔻仁一錢 (3g) 通草一錢 (3g) 豬苓三錢 (9g) 水煎服。功用：清熱利濕。主治：濕溫邪在中焦，發熱身痛，汗出熱解，繼而復熱，渴不多飲，或竟不渴，舌苔淡黃而滑，脈緩","三仁杏蔻薏苡仁，樸夏通草滑竹存， 宣暢氣機清濕熱，濕重熱輕在氣分")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("151","甘露消毒丹","Gan Lu Xiao Du Dan","Sweet Dew Toxin-Removing Elixir","祛濕劑","《醫效秘傳》","飛滑石十五兩 (450g) 淡黃芩十兩 (300g) 綿茵陳十一兩 (330g) 石菖蒲六兩 (180g) 川貝母 木通各五兩 (各150g) 藿香 連翹 白蔻仁 薄荷 射干各四兩 (各120g)","散劑，每服6~9g；丸劑，每服9~12g；湯劑，水煎服","利濕化濁，清熱解毒","濕溫時疫，邪在氣分，濕熱並重證。發熱倦怠，胸悶腹脹，肢酸咽痛，身目發黃，頤腫口渴，小便短赤，泄瀉淋濁，舌苔白或厚膩或乾黃，脈濡數或滑數","本方主治濕溫、時疫，邪留氣分，濕熱並重之證。濕熱交蒸，則發熱、肢酸、倦怠；濕邪中阻，則胸悶腹脹；濕熱薰蒸肝膽，則身目發黃；熱毒上壅，故口渴、咽頤腫痛；濕熱下注，則小便短赤，甚或泄瀉、淋濁；舌苔白或厚膩或乾黃為濕熱稽留氣分之征。治宜利濕化濁，清熱解毒","","1. 辨證要點：本方治療濕溫時疫，濕熱並重之證，為夏令暑濕季節常用方，故王士雄譽之為 「治濕溫時疫之主方」。臨床應用以身熱肢酸，口渴尿赤，或咽痛身黃，舌苔白膩或微黃為辨證要點。 2. 現代運用：本方常用於腸傷寒、急性胃腸炎、黃疸型傳染性肝炎、鉤端螺旋體病、膽囊炎等辨證屬濕熱並重者。 3. 注意事項：若濕熱入營、譫語舌絳者，則非本方所宜","","甘露消毒蔻藿香，茵陳滑石木通菖， 芩翹貝母射干薄，濕熱時疫是主方")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("152","連樸飲","Lian Po Yin","Coptis and Officinal Magnolia Bark Beverage","祛濕劑","《霍亂論》","制厚樸二錢 (6g) 川連薑汁炒 石菖蒲 制半夏各一錢 (各3g) 香豉炒 焦梔各三錢 (各9g) 蘆根二兩 (60g)","水煎，溫服","清熱化濕，理氣和中","濕熱霍亂。上吐下瀉，胸脘痞悶，心煩躁擾，小便短赤，舌苔黃膩，脈滑數","本方為主治濕熱霍亂以嘔吐為主之常用方。其證因於濕熱蘊伏，清濁相干，屬濕熱並重之證。濕熱中阻，脾胃升降失職，濁氣不降則吐，清氣不升則瀉，氣機不暢則胸脘煩悶；濕熱下注則小便短赤；舌苔黃膩，脈滑乃濕熱內蘊之佐證。治療當清熱化濕，理氣和中","","1. 辨證要點：本方為治療濕熱並重之霍亂的常用方。臨床應用以吐瀉煩悶，小便短赤，舌苔黃膩，脈滑數為辨證要點。 2. 現代運用：本方常用於急性胃腸炎、腸傷寒、副傷寒等辨證屬濕熱並重者","","連樸飲用香豆豉，菖蒲半夏焦山梔， 蘆根厚樸黃連入，濕熱霍亂此方施")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("153","當歸拈痛湯","Dang Gui Nian Tong Tang","Chinese Angelica Pain-Alleviating Decoction","祛濕劑","《醫學啟源》","羌活半兩 (15g) 防風三錢 (9g) 升麻一錢 (3g) 葛根二錢 (6g) 白朮一錢 (3g) 蒼朮三錢 (9g) 當歸身三錢 (9g) 人參二錢 (6g) 甘草五錢 (15g) 苦參酒浸二錢 (6g) 黃芩炒，一錢 (3g) 知母酒洗，三錢 (9g) 茵陳酒炒，五錢 (15g) 豬苓三錢 (9g) 澤瀉三錢 (9g)","水煎服","利濕清熱，疏風止痛","濕熱相搏，外受風邪證。遍身肢節煩痛，或肩背沉重，或腳氣腫痛，腳膝生瘡，舌苔白膩微黃，脈弦數","本方所治證候乃因濕熱內蘊，復感風邪，或風濕化熱而致風濕熱三邪合而為患者，但以濕邪偏重為其特點。風濕熱邪留滯經脈，氣血運行不暢，故遍身肢節煩痛；且濕邪偏勝，其性重濁，故肩背沉重；濕熱下注，則腳氣腫痛、腳膝生瘡；舌苔白膩微黃，脈弦數乃濕熱內蘊之征。治療宜以祛濕為主，輔以清熱疏風止痛","","1. 辨證要點：本方為治療風濕熱痹及濕熱腳氣屬濕邪偏重之常用方。臨床應用以肢節沉重腫痛，舌苔白膩微黃，脈數為辨證要點。 2. 現代運用：本方常用於風濕性關節炎、類風濕性關節炎辨證屬濕熱內蘊而兼風濕表證者","宣痹湯《溫病條辨》防己五錢 (15g) 杏仁五錢 (15g) 滑石五錢 (15g) 連翹三錢 (9g) 山梔三錢 (9g) 薏苡五錢 (15g) 半夏醋炒三錢 (9g) 晚蠶沙三錢 (9g) 赤小豆皮三錢 (9g) 乃五穀中之赤小豆，味酸肉赤，涼水浸取皮用。水八杯，煮取三杯，分溫三服。痛甚者加片子薑黃二錢 (6g)，海桐皮三錢 (9g) 功用：清熱祛濕，通絡止痛。主治：濕熱痹證。濕聚熱蒸，蘊於經絡，寒戰熱熾，骨骱煩疼，面目萎黃，舌色灰滯","當歸拈痛豬苓澤，二朮茵芩苦羌葛， 升麻防風知參草，濕重熱輕兼風邪")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("154","二妙散","Er Miao San","Two Mysterious Powder","祛濕劑","《丹溪心法》","黃柏炒 蒼朮米泔水浸，炒 (各15g)","為散劑，各等分，每次服3~5g，或為丸劑，亦可作湯劑，水煎服","清熱燥濕","濕熱下注證。筋骨疼痛，或兩足痿軟，或足膝紅腫疼痛，或濕熱帶下，或下部濕瘡、濕疹，小便短赤，舌苔黃膩者","本方為治療濕熱下注之基礎方。濕熱下注，流於下肢，使筋脈弛緩，則兩足痿軟無力，而成痿證。濕熱痹阻筋脈，以致筋骨疼痛、足膝紅腫，或為腳氣；濕熱下注於帶脈與前陰，則為帶下臭穢或下部濕瘡；小便短赤，舌苔黃膩是為濕熱之證。治宜清熱燥濕","","1. 辨證要點：本方為治療濕熱下注所致痿、痹、腳氣、帶下、濕瘡等病證的基礎方，其清熱燥濕之力較強，宜於濕熱俱重之證。臨床應用以足膝腫痛，小便短赤，舌苔黃膩為辨證要點。 2. 現代運用：本方適用於風濕性關節炎、陰囊濕疹、陰道炎等辨證屬濕熱下注者。 3. 注意事項：方中藥物均系輕清之品，故不宜久煎","1. 三妙丸《醫學正傳》黃柏四兩 (120g) 切片，酒拌，略炒 蒼朮六兩 (180g) 米泔浸一二宿，細切，焙乾 川牛膝二兩 (60g) 去蘆 上為細末，麵糊為丸，如梧桐子大，每服五七十丸 (10~15g)，空腹，薑、鹽湯下。忌魚腥、蕎麥、熱面、煎炒等物。功用：清熱燥濕。主治：濕熱下注之痿痹。兩腳麻木或腫痛，或如火烙之熱，痿軟無力。 2. 四妙丸《成方便讀》黃柏 蒼朮 牛膝 薏苡仁各八兩 (各240g) 水泛為丸，每服6~9g，溫開水送下。功用：清熱利濕，舒筋壯骨。主治：濕熱痿證。兩足麻木，痿軟，腫痛","二妙散中蒼柏兼，若云三妙牛膝添， 四妙再加薏苡仁，濕熱下注痿痹痊")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("155","五苓散","Wu Ling San","Five Substances Powder with Poria","祛濕劑","《傷寒論》","豬苓十八銖 (9g)，去皮 澤瀉一兩六銖 (15g) 白朮十八銖 (9g) 茯苓十八銖 (9g) 桂枝半兩 (6g)，去皮","散劑，每服6~10g；湯劑，水煎服，多飲熱水，取微汗","利水滲濕，溫陽化氣","膀胱氣化不利之蓄水證。小便不利，頭痛微熱，煩渴欲飲，甚則水入即吐；或臍下動悸，吐涎沫而頭目眩暈；或短氣而咳；或水腫、泄瀉，舌苔白，脈浮或浮數","本方主治病症雖多，但其病機均為水濕內盛，膀胱氣化不利所致。在《傷寒論》中原治蓄水證，乃由太陽表邪不解，循經傳腑，導致膀胱氣化不利，而成太陽經腑同病。太陽表邪未解，故頭痛微熱；膀胱氣化失司，故小便不利；水蓄不化，鬱遏陽氣，氣不化津，津液不得上承於口，故渴欲飲水；其人本有水蓄下焦，飲入之水不得輸布而上逆，致水入即吐，故此又稱 「水逆證」；水濕內盛，泛溢肌膚，則為水腫；水濕之邪，下注大腸，則為泄瀉；水濕稽留腸胃，升降失常，清濁相干，則為霍亂吐瀉；水飲停於下焦，水氣內動，則臍下動悸；水飲上犯，阻遏清陽，則吐涎沫而頭眩；水飲淩肺，肺氣不利，則短氣而咳。治宜利水滲濕為主，兼以溫陽化氣之法","","1. 辨證要點：本方為利水化氣之劑。臨床應用以小便不利，舌苔白，脈浮或緩為辨證要點。 2. 現代運用：本方常用於急慢性腎炎水腫、肝硬化腹水、心源性水腫、急性腸炎、尿瀦留、腦積水等辨證屬水濕內停者","1. 四苓散《丹溪心法》白朮 茯苓 豬苓各一兩半 (各45g) 澤瀉二兩半 (75g)，四味共為末，每次12g，水煎服。功用：健脾滲濕。主治：脾胃虛弱，水濕水停證。小便赤少，大便溏泄。 2. 胃苓湯《世醫得效方》五苓散 平胃散 (各6~10g) 上二藥合和，蘇子、烏梅煎湯送下，未效，加木香、縮砂、白朮、丁香煎服。功用：祛濕和胃，行氣利水。主治：夏秋之間，脾胃傷冷，水穀不分，泄瀉如水，以及水腫，腹脹，小便不利者。 3. 茵陳五苓散《金匱要略》茵陳蒿末十分 (4g) 五苓散五分 (2g) 上二物合，先食，飲方寸匕 (6g)，日三服。功用：利濕退黃。主治：濕熱黃疸，濕重於熱，小便不利者","五苓散治太陽腑，白朮澤瀉豬茯苓， 桂枝溫通助氣化，利便解表煩渴清")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("156","豬苓湯","Zhu Ling Tang","Polyporus Decoction","祛濕劑","《傷寒論》","豬苓去皮 茯苓 澤瀉 阿膠 滑石碎，各一兩 (各10g)","水煎服，阿膠分二次烊化","利水養陰，清熱","水熱互結證。小便不利，發熱，口渴欲飲，或心煩不寐，或兼有咳嗽、嘔惡、下利，舌紅苔白或微黃，脈細數。又治血淋，小便澀痛，點滴難出，小腹滿痛者","傷寒之邪傳入於裏，化而為熱，與水相搏，遂成水熱互結，熱傷陰津之證。水熱互結，氣化不利，熱灼陰津，津不上承，故小便不利、發熱、口渴欲飲；陰虛生熱，內擾心神，則心煩不寐；水氣上逆於肺則為咳嗽，流於胃脘則為嘔惡，注於大腸則為下利；舌紅苔白或微黃、脈細數為裏熱陰虛之征。治宜利水清熱養陰。血淋而小便不利者，亦可用本方利水通淋、清熱止血","","1. 辨證要點：本方以利水為主，兼以養陰清熱，主治水熱互結而兼陰虛之證。臨床應用以小便不利，口渴，身熱，舌紅，脈細數為辨證要點。 2. 現代運用：本方適用於泌尿系感染、腎炎、膀胱炎、產後尿瀦留等辨證屬水熱互結兼陰虛者。 3. 注意事項：因本方為滲利之劑，若內熱盛，汗出多而渴者忌用","","豬苓湯內二苓全，澤瀉阿膠滑石添； 利水育陰兼瀉熱，溺秘心煩嘔渴痊")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("157","防己黃芪湯","Fang Ji Huang Qi Tang","Stephania Root and Astragalus Decoction","祛濕劑","《金匱要略》","防已一兩 (12g) 黃芪一兩一分 (15g) 甘草半兩 (6g)，炒 白朮七錢半 (9g)","湯劑，加生薑四片、大棗一枚，水煎服","益氣祛風，健脾利水","表虛不固之風水或風濕證。汗出惡風，身重微腫，或肢節疼痛，小便不利，舌淡苔白，脈浮","本方所治風水或風濕，乃因表虛衛氣不固，風濕之邪傷於肌表，水濕鬱於肌腠所致。風性開泄，有虛不固，營陰外泄則汗出，衛外不密故惡風；濕性重濁，水濕鬱於肌腠，則身體重著，或微有浮腫；風濕鬱於肌肉、筋骨，則肢節疼痛。舌淡苔白，脈浮為風邪在表之象。風濕在表，當以汗解，表氣不足，則又不可單行解表除濕，只宜益氣固表與祛風並施","","1. 辨證要點：本方是治療風濕、風水屬表虛證之常用方。臨床應用以汗出惡風，小便不利，苔白脈浮為辨證要點。 2. 現代運用：本方適用於慢性腎小球腎炎、心源性水腫、風濕性關節炎等辨證屬風水、風濕而兼表虛證者。 3. 注意事項：若水濕壅盛腫甚者，非本方所宜","","防己黃芪金匱方，朮甘薑棗共煎嘗， 此治風水與風濕，身重汗出服之良")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("158","五皮散","Wu Pi San","Five-Peel Powder","祛濕劑","《華氏中藏經》","生薑皮 桑白皮 陳橘皮 大腹皮 茯苓皮各等分 (各9g)","水煎服","利水消腫，理氣健脾","脾虛濕盛，氣滯水泛之皮水證。一身悉腫，肢體沉重，心腹脹滿，上氣喘急，小便不利，以及妊娠水腫，苔白膩，脈沉緩","本方所治之皮水證，系由脾濕壅盛，泛溢肌膚而致。水濕泛溢，故一身悉腫：濕性重濁，則肢體沉重；濕邪最易阻礙氣機，氣機壅滯則心腹脹滿；肺氣不降，則上氣喘急。治宜利水消腫，理氣健脾","","1. 辨證要點：本方藥性平和，為治療皮水之常用方。臨床應用以一身悉腫，心腹脹滿，小便不利為辨證要點。 2. 現代運用：本方常用於腎炎水腫、心源性水腫、妊娠水腫等辨證屬脾濕壅盛者","","五皮散用五般皮，陳茯薑桑大腹奇， 或以五加易桑白，脾虛膚脹此方施")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("159","苓桂朮甘湯","Ling Gui Zhu Gan Tang","Poria/ Cinnamon Twig/ Atractylodes Macrocephala and Licorice Decoction","祛濕劑","《金匱要略》","茯苓四兩 (12g) 桂枝去皮三兩 (9g) 白朮二兩 (6g) 炙甘草，二兩 (6g)","水煎溫服","溫陽化飲，健脾利濕","中陽不足之痰飲。胸脅支滿，目眩心悸，短氣而咳，舌苔白滑，脈弦滑或沉緊","本方所治痰飲乃中陽素虛，脾失健運，氣化不利，水濕內停所致。蓋脾主中州，職司氣化，為氣機升降之樞紐，若脾陽不足，健運失職，則濕滯而為痰為飲。而痰飲隨氣升降，無處不到，停於胸脅，則見胸脅支滿；阻滯中焦，清陽不升，則見頭暈目眩；上淩心肺，則致心悸、短氣而咳；舌苔白滑，脈沉滑或沉緊皆為痰飲內停之征。仲景云：「病痰飲者，當以溫藥和之。」《金匱要略》故治當溫陽化飲，健脾利水","","1. 辨證要點：本方為治療中陽不足痰飲病之代表方。臨床應用以胸脅支滿，目眩心悸，舌苔白滑為辨證要點。 2. 現代運用：本方適用於慢性支氣管炎、支氣管哮喘、心源性水腫、慢性腎小球腎炎水腫、梅尼埃病、神經官能症等辨證屬水飲停於中焦者。 3. 使用注意：若飲邪化熱，咳痰粘稠者，非本方所宜","甘草乾薑茯苓白朮湯 (又名腎著湯)《金匱要略》甘草二兩 (6g) 乾薑四兩 (12g) 茯苓四兩 (12g) 白朮二兩 (6g) 上四味，以水五升，煮取三升，分溫三服。功用：溫脾勝濕。主治：寒濕下侵之腎著。腰部冷痛沉重，但飲食如故，口不渴，小便不利，舌淡苔白，脈沉遲或沉緩","苓桂朮甘是經方，中陽不足痰飲猖， 悸眩咳逆胸脅滿，溫陽化飲功效彰")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("160","真武湯","Zhen Wu Tang","True Warrior Decoction","祛濕劑","《傷寒論》","茯苓三兩 (9g) 芍藥三兩 (9g) 白朮二兩 (6g) 生薑切三兩 (9g) 附子一枚，炮，去皮，破八片 (9g)","水煎溫服","溫陽利水","陽虛水泛證。畏寒肢厥，小便不利，心下悸動不寧，頭目眩暈，身體筋肉瞤動，站立不穩，四肢沉重疼痛，浮腫，腰以下為甚；或腹痛，泄瀉；或咳喘嘔逆。舌質淡胖，邊有齒痕，舌苔白滑，脈沉細","本方為治療脾腎陽虛，水濕泛溢的基礎方。蓋水之制在脾，水之主在腎，脾陽虛則濕難運化，腎陽虛則水不化氣而致水濕內停。腎中陽氣虛衰，寒水內停，則小便不利；水濕泛溢於四肢，則沉重疼痛，或肢體浮腫；水濕流於腸間，則腹痛下利；上逆肺胃，則或咳或嘔；水氣淩心，則心悸；水濕中阻，清陽不升，則頭眩。若由太陽病發汗太過，耗陰傷陽，陽失溫煦，加之水漬筋肉，則身體筋肉瞤動、站立不穩。其證因於陽虛水泛，故治療當以溫陽利水為基本治法","","1. 辨證要點：本方為溫陽利水之基礎方。臨床應用以小便不利，肢體沉重或浮腫，舌質淡胖，苔白脈沉為辨證要點。 2. 現代運用： 本方常用於慢性腎小球腎炎、心源性水腫、甲狀腺功能低下、慢性支氣管炎、慢性腸炎、腸結核等辨證屬脾腎陽虛，水濕內停者","附子湯《傷寒論》附子二枚，炮，去皮，破八片 (15g) 茯苓三兩 (9g) 人參二兩 (6g) 白朮四兩 (12g) 芍藥三兩 (9g) 以水八升，煮取三升，去滓，溫服一升，日三服。功用：溫經助陽，祛寒化濕。主治：寒濕內侵，身體骨節疼痛，惡寒肢冷，苔白滑，脈沉微","真武湯壯腎中陽，茯苓朮芍附生薑， 陽虛水飲停為患，悸眩潤惕保安康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("161","實脾散","Shi Pi San","Spleen-Strengthening Powder","祛濕劑","《重訂嚴氏濟生方》","厚樸去皮，薑制，炒 白朮 木瓜去瓤 木香不見火 草果仁 大腹子 附子炮，去皮臍 白茯苓去皮 乾薑炮，各一兩 (各30g) 炙甘草，半兩 (15g)","加生薑五片、大棗一枚，水煎服","溫陽健脾，行氣利水","脾腎陽虛，水氣內停之陰水。身半以下腫甚，手足不溫，口中不渴，胸腹脹滿，大便溏薄，舌苔白膩，脈沉弦而遲者","本方所治之水腫，亦謂陰水，乃由脾腎陽虛，陽不化水，水氣內停所致。水濕內盛，泛溢肌膚，則肢體浮腫；水為陰邪，其性下趨，故身半以下腫甚；脾腎陽虛，失于溫煦，則手足不溫；水氣內阻，氣機不暢，則胸腹脹滿；脾陽不足，腐熟無權則便溏；口中不渴，舌苔白膩，脈沉弦而遲為陽虛水停之征。治以溫陽健脾，行氣利水","","1. 辨證要點：本方為治療脾腎陽虛水腫之常用方。臨床應用以身半以下腫甚，胸腹脹滿，舌淡苔膩，脈沉遲為辨證要點。 2. 現代運用：本方常用於慢性腎小球腎炎、心源性水腫、肝硬化腹水等辨證屬脾腎陽虛氣滯證者。 3. 使用注意：若屬陽水者，非本方所宜","","實脾苓朮與木瓜，甘草木香大腹加， 草果附薑兼厚樸，虛寒陰水效堪誇")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("162","萆薢分清散","Bi Xie Fen Qing San","Hypoglaucae Root Turbidity-Clearing Powder","祛濕劑","《楊氏家藏方》","益智 川萆薢 石菖蒲 烏藥各等分 (各9g)","水煎服，加入食鹽少許","溫腎利濕，分清化濁","下焦虛寒之膏淋、白濁。小便頻數，渾濁不清，白如米泔，凝如膏糊，舌淡苔白，脈沉","本方主治之白濁，乃由下焦虛寒，濕濁不化所致。下焦虛寒，氣化不利，腎失封藏，膀胱失約，故小便頻數，尿濁如米泔，或如脂膏。治宜溫暖下元，利濕化濁","","1. 辨證要點：本方為主治下焦虛寒淋濁的常用方。臨床應用以小便渾濁頻數，舌淡苔白，脈沉為辨證要點。 2. 現代運用：本方適用於乳糜尿、慢性前列腺炎、慢性腎盂腎炎、慢性腎炎、慢性盆腔炎等辨證屬下焦虛寒，濕濁不化者。 3. 使用注意：濕熱白濁則非本方所宜","萆薢分清飲《醫學心悟》川萆薢二錢 (6g) 黃柏炒褐色 石菖蒲各五分 (各2g) 茯苓 白朮各一錢 (各3g) 蓮子心七分 (2g) 丹參 車前子各一錢五分 (各4.5g) 水煎服。功用：清熱利濕，分清化濁。主治：濕熱白濁，小便混濁，尿有餘瀝，舌苔黃膩等","萆薢分清石菖蒲，萆薢烏藥益智俱； 或益茯苓鹽水服，通心固腎濁精驅")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("163","羌活勝濕湯","Qiang Huo Sheng Shi Tang","Notopterygium Dampness-Drying Decoction","祛濕劑","《脾胃論》","羌活 獨活各一錢 (各6g) 槁本 防風 炙甘草，各五分 (各3g) 蔓荊子三分 (2g) 川芎二分 (1.5g)","作湯劑，水煎服","祛風，勝濕，止痛","風濕在表之痹證。肩背痛不可回顧，頭痛身重，或腰脊疼痛，難以轉側，苔白，脈浮","本方主治為風濕在表，其證多由汗出當風，或久居濕地，風濕之邪侵襲肌表所致。風濕之邪客手太陽經脈，經氣不暢，致頭痛身重、或腰脊疼痛、難以轉側。風濕在表，宜從汗解，故以祛風勝濕為法","","1. 辨證要點：本方長於祛風勝濕止痛，主治風濕在表之頭身重痛而表證不明顯者。臨床應用以頭身重痛或腰脊疼痛，苔白脈浮為辨證要點。 2. 現代運用：本方適用於風濕性關節炎、類風濕性關節炎、骨質增生症、強直性脊柱炎等辨證屬風濕在表者","蠲痹湯《楊氏家藏方》當歸去土，酒浸一宿 羌活去蘆頭 薑黃 黃芪蜜炙 白芍藥 防風去蘆頭 各一兩半 (各45g) 炙甘草 半兩 (15g) 上 咀，每服半兩 (15g)，水二盞，加生薑五片，同煎至一盞，去滓溫服，不拘時候。功用：益氣和營，祛風勝濕。主治：風寒濕邪痹阻經絡營衛之證。肩項臂痛，舉動艱難，手足麻木等","羌活勝濕獨防風，蔓荊槁本草川芎， 祛風勝濕通經絡，善治周身風濕痛")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("164","獨活寄生湯","Du Huo Ji Sheng Tang","Pubescent Angelica and Mistletoe Decoction","祛濕劑","《備急千金要方》","獨活三兩 (9g) 桑寄生 杜仲 牛膝 細辛 秦艽 茯苓 肉桂心 防風 川芎 人參 甘草 當歸 芍藥 乾地黃各二兩 (各6g)","水煎服","祛風濕，止痹痛，益肝腎，補氣血","痹證日久，肝腎兩虛，氣血不足證。腰膝疼痛、痿軟，肢節屈伸不利，或麻木不仁，畏寒喜溫，心悸氣短，舌淡苔白，脈細弱","本方為治療久痹而肝腎兩虛，氣血不足之常用方。其證乃因感受風寒濕邪而患痹證，日久不愈，累及肝腎，耗傷氣血所致。風寒濕邪客於肢體關節，氣血運行不暢，故見腰膝疼痛，久則肢節屈伸不利，或麻木不仁，正如《素問》痹論所言：「痹在於骨則重，在於脈則不仁」。腎主骨，肝主筋，邪客筋骨，日久必致損傷肝腎，耗傷氣血。又腰為腎之府，膝為筋之府，肝腎不足，則見腰膝痿軟；氣血耗傷，故心悸氣短。《素問》逆調論云：「營氣虛則不仁，衛氣虛則不用，營衛俱虛則不仁且不用」。其證屬正虛邪實，治宜扶正與祛邪兼顧，既應祛散風寒濕邪，又當補益肝腎氣血","","1. 辨證要點：本方為治療久痹而致肝腎兩虛，氣血不足證之常用方。臨床應用以腰膝冷痛，肢節屈伸不利，心悸氣短，脈細弱為辨證要點。 2. 現代運用：本方常用於慢性關節炎、類風濕性關節炎、風濕性坐骨神經痛、腰肌勞損、骨質增生症、小兒麻痹等辨證屬風寒濕痹日久，正氣不足者。 3. 注意事項：痹證之屬濕熱實證者忌用","三痹湯《校注婦人良方》川續斷 杜仲去皮，切，薑汁炒 防風 桂心 細辛 人參 白茯苓 當歸 白芍藥 甘草各一兩 (各30g) 秦艽 生地黃 川芎 川獨活各半兩 (各15g) 黃芪 川牛膝各一兩 (各30g) 上為末，每服五錢 (各15g)，水二盞，加薑三片，大棗一枚，煎至一盞，去滓熱服，不拘時候，但腹稍空服之。功用：益氣活血，祛風除濕。主治：痹證日久耗傷氣血證。手足拘攣，或肢節屈伸不利，或麻木不仁，舌淡苔白，脈細或脈澀","獨活寄生艽防辛，芎歸地芍桂苓均， 杜仲牛膝人參草，風濕頑痹屈能伸")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("165","二陳湯","Er Chen Tang","Two Matured Substances Decoction","祛痰劑","《太平惠民和劑局方》","半夏五兩 (15g) 白茯苓三兩 (9g) 橘紅五兩 (15g) 炙甘草一兩半 (5g)","加生薑7片，烏梅1個，水煎，溫服","燥濕化痰，理氣和中","濕痰證。咳嗽痰多，色白易咯，噁心嘔吐，胸膈痞悶，肢體困重，或頭眩心悸，舌苔白滑或膩，脈滑","脾失健運，濕無以化，濕聚成痰，鬱積機體。濕痰為病，犯於肺致肺失宣降，則咳嗽痰多；停於胃令胃失和降，則噁心嘔吐；阻於胸膈，氣機不暢，則感痞悶不舒；留注於肌肉，則肢體困重；阻遏清陽，則頭目眩暈；痰濁淩心，則為心悸；舌苔白滑或膩，脈滑，乃痰濕之象。冶當燥濕化痰，理氣和中","","1. 辨證要點：本方為燥濕化痰的基礎方、常用方、代表方。臨床應用以咳嗽，痰多色白易咯，舌苔白膩，脈滑為辨證要點。 2. 現代運用：本方常用於慢性支氣管炎、急慢性胃炎、梅尼爾氏合征病、神經性嘔吐等屬濕痰者。 3. 注意事項：因本方性燥，故燥痰者慎用；吐血、消渴、陰虛、血虛者忌用本方","1. 導痰湯《傳信適用方》(引皇甫坦方) 半夏四兩，湯洗七次 (120g) 天南星一兩，細切，薑汁浸 (30g) 枳實去瓤，一兩 (30g) 橘紅一兩 (30g) 赤茯苓一兩 (30g) 上為粗末。每服三大錢 (9g)，水二盞，生薑十片，煎至一盞，去滓，食後溫服 (現代用法：加生薑4片，水煎服，用量按原方比例酌減)。功用：燥濕祛痰，行氣開鬱。主治：痰厥證。頭目眩暈，或痰飲壅盛，胸膈痞塞，脅肋脹滿，頭痛嘔逆，喘急痰嗽，涕唾稠粘，舌苔厚膩，脈滑。 2. 滌痰湯《奇效良方》南星薑制 半夏湯洗七次，各二錢半 (各7.5g) 枳實麩炒，二錢 (6g) 茯苓去皮，二錢 (6g) 橘紅一錢半 (4.5g) 石菖蒲 人參各一錢 (各3g) 竹茹七分 (2g) 甘草半錢 (1.5g) 上作一服。水二盅，生薑五片，煎至一盅，食後服 (現代用法：加生薑3片，水煎服)。功用：滌痰開竅。主治：中風痰迷心竅證。舌強不能言，喉中痰鳴，轆轆有聲，舌苔白膩，脈沉滑或沉緩。 3. 金水六君煎《景嶽全書》當歸二錢 (6g) 熟地三五錢 (9~15g) 陳皮一錢半 (4.5g) 半夏二錢 (6g) 茯苓二錢 (6g) 炙甘草一錢 (3g) 水二盅，生薑三五七片，煎七八分，食遠溫服。功用：滋養肺腎，祛濕化痰。主治：肺腎陰虛，濕痰內盛證。咳嗽嘔惡，喘急痰多，痰帶鹹味，或咽乾口燥，自覺口鹹，舌質紅苔白滑或薄膩","二陳湯用半夏陳，苓草薑梅一併存， 燥濕化痰兼利氣，濕痰為患此方珍")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("166","溫膽湯","Wen Dan Tang","Gallbladder-Warming Decoction","祛痰劑","《三因極一病證方論》","半夏二兩 (60g) 竹茹二兩 (60g) 陳皮三兩 (90g) 枳實二兩 (60g) 茯苓一兩半 (45g) 炙甘草一兩 (30g) 生薑五片，大棗一枚","上銼為散。每服四大錢 (12g)，水一盞半，加生薑五片，大棗一枚，煎七分，去滓，食前服 (現代用法：加生薑5片，大棗1枚，水煎服，用量按原方比例酌減)","理氣化痰，和胃利膽","膽鬱痰擾證。膽怯易驚，頭眩心悸，心煩不眠，夜多異夢。或嘔惡呃逆，眩暈，癲癇，苔白膩，脈弦滑","素體膽氣不足，復由情志不遂，膽失疏泄，氣鬱化熱，津聚成痰，痰濁內擾，膽胃不和。膽為清淨之府，性喜寧謐而惡煩擾。若膽為邪擾，失其寧謐，則膽怯易驚、心煩不眠、夜多異夢、驚悸不安；膽胃不和，胃失和降，則嘔吐痰涎或呃逆；痰蒙清竅，則可發為眩暈、心悸，甚至癲癇。此證病機為膽鬱痰擾，治宜理氣化痰，和胃利膽","","1. 辨證要點：本方為治療膽鬱痰擾的常用方。臨床以心煩不寐，眩悸嘔惡，苔白膩，脈弦滑為辨證要點。 2. 現代運用：本方常用於急、慢性胃炎、神經官能症、梅尼爾氏綜合征、更年期綜合征、癲癇、急慢性支氣管炎等屬膽鬱痰擾者","十味溫膽湯《世醫得效方》半夏湯洗，七次 枳實去瓤，切，麩炒 陳皮去白，各三兩 (各90g) 白茯苓去皮，一兩半 (45g) 酸棗仁微炒 大遠志去心，甘草水煮，薑汁炒 各一兩 (各30g) 北五味子 熟地黃切，酒炒 條參各一兩 (各30g) 粉草五錢 (15g) 上銼散，每服四錢 (12g)，水盞半，薑五片、棗一枚煎，不以時服。功用：益氣養血，化痰寧心。主治：心膽虛怯，痰濁內擾證。觸事易驚，驚悸不眠，夜多惡夢，短氣自汗，耳鳴目眩，四肢浮腫，飲食無味，胸中煩悶，坐臥不安，舌淡苔膩，脈沉緩","溫膽湯中苓夏草，枳竹陳皮加薑棗， 虛煩不眠舌苔膩，此系膽虛痰熱擾")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("167","茯苓丸","Fu Ling Wan","Poria Pill","祛痰劑","《是齋百—選方》錄自《全生指迷方》","茯苓一兩 (30g) 枳殼麩炒去瓤，半兩 (15g) 半夏二兩 (60g) 風化樸硝一分 (0.3g)","上四味為末，生薑自然汁煮糊為丸，如梧桐子大，每服三十丸 (6g)，生薑湯下 (現代用法：為末，薑汁糊丸，每服6g，生薑湯或溫開水送下；作湯劑，加生薑水煎去渣，風化硝溶服，用量按原方比例酌定)","燥濕行氣，軟堅化痰","痰伏中脘，流注經絡證。兩臂痠痛或抽掣，不得上舉，或左右時復轉移，或兩手麻木，或四肢浮腫，舌苔白膩，脈沉細或弦滑","脾失健運，聚濕生痰。四肢稟氣於脾，若脾失健運，聚濕生痰，停伏中脘，流注四肢，則麻木酸痛、活動受限，甚則抽掣或浮腫。舌苔白膩，脈沉細或弦滑，乃濕痰內阻之征。治宜燥濕行氣，軟堅化痰","","1. 辨證要點：本方主治痰伏中脘，流注經絡之證。臨床應用以兩臂痠痛，舌苔白膩、脈沉細或弦滑為辨證要點。凡屬風濕臂痛者忌用。 2. 現代運用：本方常用於上肢血管性水腫、慢性支氣管炎、頸惟病、前列腺增生症等屬頑痰停伏者。 3. 注意事項：本方化痰力較強，並有瀉下痰結的作用，不可久用，虛人慎用。風濕所致臂痛，亦非本方所宜","","指迷茯苓君半夏，風硝枳殼薑湯下， 中脘伏痰臂酸痛，氣行痰消痛自罷")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("168","清氣化痰丸","Qing Qi Hua Tan Wan","Qi-Clearing and Phlegm-Transforming Pill","祛痰劑","《醫方考》","瓜蔞仁一兩 (30g) 枳實一兩 (30g) 陳皮一兩 (30g) 茯苓一兩 (30g) 、黃芩一兩 (30g) 膽南星一兩半 (45g) 杏仁一兩 (30g) 制半夏一兩半 (45g)","上粉末與生薑100g汁泛丸，每服6~9g，1日2次，小兒酌減；亦可作湯劑","清熱化痰，理氣止咳","痰熱咳嗽。咳嗽氣喘，咯痰黃稠，胸膈痞悶，甚則氣急嘔惡，煩躁不寧，舌質紅，苔黃膩，脈滑數","痰阻氣滯，氣鬱化火，痰熱互結，壅肺為患。症見咳嗽氣喘、咯痰黃稠；阻礙氣機，則胸膈痞悶，甚則氣逆於上，發為氣急嘔惡；痰熱擾亂心神，可見煩躁不寧。治當清熱化痰，理氣止咳","","1. 辨證要點：本方為治療痰熱咳嗽的常用方。臨床應用以咯痰黃稠，胸膈痞悶，舌紅苔黃膩，脈滑數為辨證要點。 2. 現代運用：本方常用於肺炎、急性支氣管炎、慢性支氣管炎急性發作等屬痰熱內結者。 3. 注意事項：本方性偏苦燥，陰虛燥咳、脾虛寒痰者忌用","清金降火湯《古今醫鑒》陳皮一錢五分 (4.5g) 半夏泡一錢 (3g) 茯苓一錢 (3g) 桔梗一錢 (3g) 枳殼麩炒一錢 (3g) 貝母去心一錢 (3g) 前胡一錢 (3g) 杏仁去皮尖一錢半 (4.5g) 黃芩炒一錢 (3g) 石膏一錢 (3g) 瓜蔞仁一錢 (3g) 炙甘草三分 (1g) 上銼一劑。加生薑三片，水煎，食遠，臨臥服。功用：清金降火，化痰止嗽。主治：熱痰咳嗽","清氣化痰杏瓜蔞，茯苓枳芩膽星投， 陳夏薑汁糊丸服，專治肺熱咳痰稠")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("169","小陷胸湯","Xiao Xian Xiong Tang","Minor Chest-Draining Decoction","祛痰劑","《傷寒論》","黃連一兩 (6g) 半夏半升 (12g)，瓜蔞實一枚 (20g)","先煮瓜蔞，後納諸藥，水煎溫服","清熱化痰，寬胸散結","痰熱互結證。胸脘痞悶，按之則痛，或心胸悶痛，或咳痰黃稠，舌紅苔黃膩，脈滑數","傷寒表證誤下，邪熱內陷，與痰濁結於心下之小結胸病。痰熱互結心下或胸膈，氣鬱不通，故胃脘或心胸痞悶，按之則痛；痰熱蘊肺，則咳痰黃稠；舌紅苔黃膩，脈滑數，乃痰熱內蘊之象。治宜清熱化痰，寬胸散結","","1. 辨證要點：本方為治療痰熱結胸的常用方。臨床應用以胸膈痞悶，按之則痛，舌紅苔黃膩，脈滑數為辨證要點。 2. 現代運用：本方常用於急性胃炎、膽囊炎、肝炎、冠心病、肺心病、急性支氣管炎、胸膜炎、胸膜黏連等屬痰熱互結心下或胸膈者","柴胡陷胸湯《重訂通俗傷寒論》柴胡一錢 (3g) 薑半夏三錢 (9g) 小川連八分 (2.5g) 苦桔梗一錢 (3g) 黃芩錢半 (4.5g) 瓜蔞仁杵，五錢 (15g) 小枳實錢半 (4.5g) 生薑汁四滴，分沖 水煎服。功用：和解清熱，滌痰寬胸。主治：邪陷少陽，痰熱結胸證。寒熱往來，胸脅痞滿，按之疼痛，嘔惡不食，口苦且粘，目眩，或咳嗽痰稠，苔黃膩，脈弦滑數","小陷胸湯連夏蔞，寬胸散結滌痰優， 痰熱內結痞滿痛，苔黃脈滑此方求")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("170","滾痰丸","Gun Tan Wan","Phlegm-Removing Pill","祛痰劑","《泰定養生主論》錄自《玉機細微義》","大黃八兩 (240g) 黃芩八兩 (240g) 礞石一兩，同焰硝一兩，投入小砂罐內蓋之，鐵線縛定，鹽泥固濟，曬乾，火煆紅，候冷取出 (30g) 沉香半兩 (15g)","上為細末，水泛小丸，每服8~l0g，一日一至二次，溫開水送下","瀉火逐痰","實熱老痰證。發為癲狂驚悸，或怔忡昏迷，或咳喘痰稠，或胸脘痞悶，或眩暈耳鳴，或繞項結核，或口眼蠕動，或不寐，或夢寐奇怪之狀，或骨節卒痛難以名狀，或噎息煩悶，大便秘結，舌苔黃厚，脈滑數有力","實熱老痰，久積不去所致之多種怪證。若上蒙清竅，則發為癲狂、昏迷；擾亂心神，則為驚悸怔仲、不寐怪夢；內壅於肺，則咳嗽痰稠；阻塞氣機，則胸脘痞悶；痰火上蒙，清陽不升，則發於眩暈耳鳴；痰火膠結，無下行之路，故大便秘結；苔黃厚膩、脈滑數有力者，為實火頑痰證。治宜降火逐痰","","1. 辨證要點：本方為治療實熱老痰證的常用方。臨床應用以癲狂驚悸，大便乾燥，苔黃厚膩，脈滑數有力為辨證要點。 2. 現代運用：本方常用於中風、精神分裂症、癲癇、偏頭痛、神經官能症等屬實火頑痰膠固者。 3. 注意事項：因本方藥力峻猛，體虛之人及孕婦均宜慎用，以免損傷正氣","","滾痰丸是逐痰方，礞石黃芩及大黃， 少佐沉香為引導，實熱頑痰一掃光")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("171","貝母瓜蔞散","Bei Mu Gua Lou San","Fritillary Bulb and Snakegourd Fruit Powder","祛痰劑","《醫學心悟》","貝母一錢五分 (5g) 瓜蔞一錢 (3g) 茯苓 橘紅 花粉 桔梗各八分 (各2.5g)","水煎服","潤肺清熱，理氣化痰","燥痰咳嗽。咳嗽嗆急，咯痰不爽，澀而難出，咽喉乾燥，苔白而乾","燥熱傷肺，灼津成痰。燥痰不化，清肅無權，以致肺氣上逆，咳嗽嗆急；燥傷津液，故咯痰不爽、澀而難出、咽喉乾燥哽痛；苔白而乾為燥痰之徵象。治宜潤肺清熱，理氣化痰","","1. 辨證要點：本方為治療燥痰證的常用方。臨床應用以咳嗽嗆急，咯痰難出，咽喉乾燥，苔白而乾為辨證要點。 2. 現代運用：肺結核、肺炎等屬燥痰證者。 3. 注意事項：對於肺腎陰虛，虛火上炎之咳嗽，則非所宜","","貝母瓜蔞散茯苓，陳皮桔梗花粉增， 咳嗽咽乾痰難咯，潤燥化痰病自清")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("172","苓甘五味薑辛湯","LIng Gan Wu Wei Jiang Xin Tang","Poria/ Licorice Root/ Schisandra/ Dried Ginger/ and Asarum Decoction","祛痰劑","《金匱要略》","茯苓四兩 (12g) 甘草三兩 (9g) 乾薑三兩 (9g) 細辛三兩 (5g) 五味子半升 (5g)","水煎，溫服","溫肺化飲","寒飲咳嗽。咳痰量多，清稀色白，或喜唾涎沫，胸滿不舒，舌苔白滑，脈弦滑","多因脾陽不足，寒從中生，以致聚濕成飲，寒飲犯肺。此即 「形寒飲冷則傷肺」《靈樞》邪氣臟腑病形之義。寒飲停肺，宣降違和，故咳嗽痰多、清稀色白；飲阻氣機，故胸滿不舒；飲邪犯胃，則喜唾涎沫。治當溫陽化飲","","1. 辨證要點：本方為治寒飲咳嗽的代表方、常用方。臨床應用以咳嗽痰多稀白，舌苔白滑，脈象弦滑為辨證要點。 2. 現代運用：本方常用於慢性支氣管炎、肺氣腫等屬寒飲內停者。 3. 注意事項：凡肺燥有熱、陰虛咳嗽、痰中帶血者，忌用本方","","苓甘五味薑辛湯，溫肺化飲常用方， 半夏杏仁均可加，寒痰水飲咳嗽康")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("173","三子養親湯","San Zi Yang Qin Tang","Three-Seed Filial Devotion Decoction","祛痰劑","《皆效方》錄自《雜病廣要》","紫蘇子 (9g) 白芥子 (9g) 萊菔子 (9g) (原書末著劑量)","三藥微炒，搗碎，布包微煮，頻服","降氣快膈，化痰消食","痰壅氣逆食滯證。咳嗽喘逆，痰多胸痞，食少難消，舌苔白膩，脈滑","高年咳嗽，氣逆痰痞。年老中虛，納運無權，每致停食生痰，痰盛壅肺，肺失宣降，故見咳嗽喘逆、痰多胸痞、食少難消等症。舌苔白膩，脈滑乃痰證屬寒之征。治宜溫肺化痰，降氣消食","","1. 辨證要點：本方為治療痰壅氣逆食滯證的常用方。臨床運用以咳嗽痰多，食少胸痞，舌苔白膩，脈滑為辨證要點。無論男女老少，皆可用之，尤以老年人為宜。 2. 現代運用：本方常用於頑固性咳嗽、慢性支氣管炎、支氣管哮喘、肺心病等痰壅氣逆食滯者。 3. 注意事項：對於方中三藥的炮製，原書要求 「微炒、擊碎」，可防止辛散耗氣，減少辛味對咽喉、肺胃的不良刺激，尤能使萊菔子由生用性升變為性降下氣；搗碎則利於有效成分煎出。在用法上，每劑不過三錢，布包微煎，代茶頻服，可使藥力緩行","","三子養親祛痰方，芥蘇萊菔共煎湯， 大便實硬加熟蜜，冬寒更可加生薑")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("174","半夏白朮天麻湯","Ban Xia Bai Zhu Tian Ma Tang","Pinellia/ Atractylodes Macrocephala and Gastrodia Decoction","祛痰劑","《醫學心悟》","半夏一錢五分 (4.5g) 天麻 茯苓 橘紅 各一錢 (各3g) 白朮三錢 (9g) 甘草五分 (1.5g) 生薑一片，大棗二枚","水煎服","燥濕化痰，平肝息風","風痰上擾證。眩暈，頭痛，胸膈痞悶，噁心嘔吐，舌苔白膩，脈弦滑","脾濕生痰，濕痰壅遏，以致引動肝風，風痰上擾清空。風痰上擾，蒙蔽清陽，故眩暈、頭痛；痰阻氣滯，升降失司，故胸膈痞悶、噁心嘔吐；內有痰濁，則舌苔白膩；脈來弦滑，乃風痰之征。治當化痰熄風，健脾袪濕","","1. 辨證要點：本方為治風痰眩暈、頭痛的常用方。臨床應用以眩暈頭痛，舌苔白膩，脈弦滑為辨證要點。 2. 現代運用：本方常用於耳源性眩暈、高血壓病、神經性眩暈、癲癇、面神經癱瘓等屬風痰上擾者。 3. 注意事項：陰虛陽亢，氣血不足所致之眩暈，不宜使用","","半夏白朮天麻湯，苓草橘紅棗生薑， 眩暈頭痛風痰盛，痰化風熄復正常")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("175","定癇丸","Ding Xian Wan","Convulsion-Settling Pill","祛痰劑","《醫學心悟》","明天麻一兩 (30g) 僵蠶，五錢 (15g) 川貝母一兩 (30g) 全蠍五錢 (15g) 半夏一兩 (30g) 茯苓 茯神各一兩 (30g) 陳皮七錢 (20g) 遠志七錢 (20g) 石菖蒲五錢 (15g) 膽南星五錢 (15g) 丹參二兩 (60g) 麥冬二兩 (60g) 琥珀，五錢 (15g) 辰砂三錢 (9g)","共為細末，用甘草120g煮膏，加竹瀝汁100 ml 與生薑汁50 ml為丸，每次9g；亦可作湯劑，加甘草水煎，去渣，入竹瀝、薑汁、琥珀、朱砂沖服","滌痰熄風","風痰蘊熱之癇病。忽然發作，眩仆倒地，目晴上視，口吐白沫，喉中痰鳴，叫喊作聲，甚或手足抽搐，舌苔白膩微黃，脈弦滑略數。亦可用於癲狂","風痰蘊熱，上蒙腦竅。每因驚恐恚怒，氣機逆亂，陽亢化風，觸動積痰，痰隨風動，上蒙腦竅而卒然眩仆倒地；肝風內動，故見目睛上視，甚或手足抽搐；痰涎壅盛則口吐白沫，喉中痰鳴；舌脈為風痰蘊熱之象。急當滌痰熄風，開竅安神","","1. 辨證要點：本方為治風痰蘊熱癲癇發作的常用方。臨床應用以舌苔白膩微黃，脈弦滑略數為辨證要點。 2. 現代運用：本方常用於癲癇病發作期屬風痰蘊熱者。 3. 注意事項：因本方著重滌痰熄風先治其標，一俟癇病緩解，則須化痰熄風與培本扶正兼顧，並應注意飲食，調攝精神，以收全功","","定癇二茯貝天麻，丹麥陳遠蒲薑夏， 膽星全蠍蠶琥珀，竹瀝薑汁草朱砂")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("176","保和丸","Bao He Wan","Harmony-Preserving Pill","消食劑","《丹溪心法》","山楂六兩 (180g) 神曲二兩 (60g) 半夏 茯苓各三兩 (各90g) 陳皮 連翹 萊菔子各一兩 (各30g)","共為末，水泛為丸。每服6-9g，溫開水送下。亦可水煎服，用量按原方比例酌減","消食和胃","食滯胃脘證。脘腹痞滿脹痛，噯腐吞酸，惡食嘔吐，或大便泄瀉，舌苔厚膩，脈滑","本方證病機為飲食不節或暴飲暴食所致之食積內停。積滯內阻，氣機不暢，則脘腹痞滿脹痛；脾胃升降失職，清陽不升則泄瀉，濁陰不降則嘔吐；舌苔厚膩、脈滑皆為食積之候。治宜消食化滯","","1. 辨證要點：本方為治療一切食積之常用方。臨床應用以脘腹痞滿脹痛，噯腐吞酸，苔膩，脈滑為辨證要點。 2. 現代運用: 現代臨床常用於治療急慢性胃炎，急慢性腸炎、消化不良、嬰幼兒腹瀉等屬食積內停者。 3. 注意事項：本方屬攻伐之劑，不宜久服，對於脾虛食滯者，不宜單獨使用","","保和神曲與山楂，陳翹萊菔苓半夏， 炊餅為丸白湯下，消食和胃效堪誇")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("177","枳實導滯丸","Zhi Shi Dao Zhi Wan","Immature Bitter Orange Stagnation-Moving Pill","消食劑","《內外傷辨惑論》","大黃一兩 (30g) 枳實 神曲各五錢 (各15g) 茯苓 黃芩 黃連 白朮各三錢 (各9g) 澤瀉二錢 (6g)","共為細末，水泛為丸，每服6-9g，食後溫開水送下，每日2次。亦可作湯劑，水煎服","消食導滯，清熱祛濕","濕熱食積證。脘腹脹痛，下痢泄瀉，或大便秘結，小便短赤，舌苔黃膩，脈沉有力","本方證病機為飲食積滯，生濕化熱，或素有濕熱，又與飲食互結於腸胃所致之濕熱積滯證。積滯內停，氣機阻塞，故見脘腹脹滿疼痛，濕熱下迫大腸則大便泄瀉或下痢，若熱壅氣阻，又可見大便秘結，小便黃赤、舌苔黃膩，脈沉有力，皆為濕熱徵象。治宜消導化積，清熱利濕","","1. 辨證要點：現代臨床常用於治療胃腸功能紊亂、細菌性痢疾、腸炎、消化不良等證屬濕熱食積者。 2. 現代運用：本方常用於急、慢性胃炎、神經官能症、梅尼爾氏綜合征、更年期綜合征、癲癇、急慢性支氣管炎等屬膽鬱痰擾者。 3. 注意事項：體虛久痢、泄瀉而無積滯者和孕婦皆不可使用","木香檳榔丸《儒門事親》木香 檳榔 青皮 陳皮 廣荗燒 枳殼 黃連各一兩 (各30g) 黃柏 大黃各三兩 (90g) 香附子炒 牽牛各四兩 (各120g) 上為細末，水為丸，如小豆大，每服三十丸，食後生薑湯送下 (現代用法：為細末，水泛小丸，每服3~6g，食後生薑湯或溫開水下，日2次)。功用：行氣導滯，攻積泄熱。主治：積滯內停，濕蘊生熱證。見脘腹痞滿脹痛，赤白痢疾，裏急後重，或大便秘結，舌苔黃膩，脈沉實者","枳實導滯重大黃，芩連白朮與茯苓， 澤瀉蒸餅糊丸服，濕熱積滯此方尋")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("178","健脾丸","Jian Pi Wan","Spleen-Fortifying Pill","消食劑","《證治準繩》","白朮炒，二兩半 (75g) 木香 黃連酒炒 甘草各七錢半 (各22g) 白茯苓二兩 (60g) 人參一兩五錢 (45g) 神曲 陳皮 砂仁 麥芽 山楂 山藥 肉豆蔻各一兩 (各30g)","共為細末，糊丸或水泛為丸，每服6-9g，溫開水送下，日2次。亦可水煎服，按原方用量比例酌減","健脾和胃，消食止瀉","脾虛食積證。食少難消，脘腹痞悶，大便溏薄，苔膩微黃，脈象虛弱","本方證病機為脾胃虛弱，食積內停。脾虛脾胃納運無力，則食少難消，大便溏薄；氣血生化無源則倦怠乏力，脈象虛弱；食積阻滯氣機，生濕化熱，故脘腹痞悶、苔膩微黃。治宜健脾和胃，消食止瀉","","1. 辨證要點：本方為治療脾虛食滯之常用方。臨床應用以脘腹痞悶，食少難消，大便溏薄，苔膩微黃，脈虛弱為辨證要點。 2. 現代運用：現代臨床常用於治療慢性胃腸炎、消化不良屬脾虛食滯者","枳朮丸《內外傷辨惑論》(卷下) 枳實炒，一兩 (30g) 白朮二兩 (60g) 用法：同為極細末，荷葉裹燒飯為丸，如梧桐子大，每服五十丸，多用白湯下，無時 (現代用法：共為末，糊丸，每服6~9g，荷葉煎湯或溫開水送下，每日2次)。功用：健脾消痞。主治：脾虛氣滯，飲食停聚。胸脘痞滿，不思飲食","健脾參朮苓草陳，肉蔻香連合砂仁， 楂肉山藥曲麥炒，消補兼施此方尋")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("179","枳實消痞丸","Zhi Shi Xiao Pi Wan","Immature Bitter Orange and Glomus-Dispersing Pill","消食劑","《蘭室秘藏》","乾薑 炙甘草 麥芽 白茯苓 白朮各二錢 (各6g) 半夏 人參各三錢 (各9g) 厚樸炙，四錢 (12g) 枳實 黃連各五錢 (各15g)","共為細末，水泛為丸或糊丸，每服6-9g，飯後溫開水送下，日2次；亦可改為湯劑，水煎服","消痞除滿，健脾和胃","脾虛氣滯，寒熱互結證。心下痞滿，不欲飲食，倦怠乏力，大便不暢，苔膩微黃，脈弦","本方證病機為脾胃素虛，升降失職，寒熱互結，氣壅濕聚。脾虛胃納不振，則不欲飲食；氣血化源不足，則倦怠乏力；食積內停，傳導失司，則大便不暢；寒熱互結，氣機阻滯，則心下痞滿，脈弦。食積氣鬱而化熱，故苔膩而微黃。本證雖屬脾虛氣滯，寒熱互結，虛實相兼，但虛多實少，熱重寒輕。治宜行氣消痞，健脾補虛，平調寒熱","","1. 辨證要點：本方為治療脾虛氣滯，寒熱互結之心下痞滿證之常用方。臨床應用以心下痞滿，食少倦怠，苔膩微黃為辨證要點。 2. 現代運用：現代臨床常用於治療慢性胃炎、慢性支氣管炎、胃腸神經官能症等屬脾虛氣滯，寒熱互結者。 3. 注意事項：本方功偏行散，痞滿而虛多實少者慎用","","枳實消痞四君先，麥芽夏曲樸薑連， 脾虛痞滿結心下，痞消脾健樂天年")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("180","葛花解酲湯","Ge Hua Jie Cheng Tang","Flower of Kudzuvine Drunk-Relieving Decoction","消食劑","《內外傷辨惑論》","木香五分 (1.5g) 人參去蘆 豬苓 白茯苓 橘皮，各一錢五分 (各4.5g) 白朮 乾薑 神曲炒黃 澤瀉各二錢 (各6g) 青皮三分 (1g) 縮砂仁 白豆蔻仁 葛花各五錢 (各15g)","共為極細末，和勻，每服9g，溫開水調下。或作湯劑，水煎服","分消酒濕，理氣健脾","酒積傷脾證。眩暈嘔吐，胸膈痞悶，食少體倦，小便不利，大便泄瀉，舌苔膩，脈滑","本方為治療酒食傷脾而設。其病機為嗜酒中虛，濕傷脾胃。酒體濕性熱，其性剽悍。酒毒蘊蒸，上擾清陽，則眩暈；濕熱損傷脾胃，升降失常則嘔吐、瀉泄；脾不運化，則食少體倦；生濕滯氣，則胸膈痞悶，小便不利，苔膩脈滑。酒積乃無形之物，治療宜發散，利小便，分消酒食，兼以理氣健脾","","1. 辨證要點：本方為治療酒積傷脾證的常用方。臨床應用以眩暈嘔吐、胸膈痞悶、食少體倦、小便不利等為辨證要點。 2. 現代運用：本方常用於治療飲酒過量致醉，或嗜酒成性者。 3. 注意事項：本方耗氣傷津，不宜久服","","葛花解酲澤二苓，砂寇青陳木香並， 薑曲參朮溫健脾，分消寒化酒濕靈")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("181","烏梅丸","Wu Mei Wan","Mume Pill","驅蟲劑","《傷寒論》","烏梅三百枚 (480g) 細辛六兩 (180g) 乾薑十兩 (300g) 黃連十六兩 (480g) 當歸四兩 (120g) 附子六兩，炮去皮 (180g) 蜀椒四兩，出汗 (120g) 桂枝六兩，去皮 (180g) 人參六兩 (180g) 黃柏六兩 (180g)","醋炙烏梅去核搗爛，和餘藥打勻，烘乾，研末加蜜為丸，每服9g，日服二至三次，空腹溫開水送下","安蛔止痛","蛔厥證。脘腹陣痛，煩悶嘔吐，時發時止，得食則吐，甚則吐蛔，手足厥冷，或久瀉久痢","本方證病機為飲食不節或暴飲暴食所致之食積內停。積滯內阻，氣機不暢，則脘腹痞滿脹痛；脾胃升降失職，清陽不升則泄瀉，濁陰不降則嘔吐；舌苔厚膩、脈滑皆為食積之候。治宜消食化滯","為何此方又可用於久瀉久痢？久瀉久痢，多呈脾胃虛寒，腸滑失禁，氣血不足，而邪濁 (濕熱) 積滯末去之寒熱虛實錯雜證候，本方集酸收澀腸、溫陽補虛、清熱燥濕諸法於一方，切中病機，故可用此方","1. 辨證要點：本方為治療寒熱錯雜，蛔蟲上擾之蛔厥證的常用方、代表方。臨床應用以腹痛時作，煩悶嘔吐，常自吐蛔，手足厥冷為辨證要點。 2. 現代運用: 本方常用於治療膽道蛔蟲症、腸道蛔蟲症、慢性菌痢、慢性胃腸炎、結腸炎等證屬寒熱錯雜，氣血虛弱者。 3. 注意事項：方藥性偏溫，以寒重者為宜。運用時注意忌生冷、滑臭等物","1. 理中安蛔湯《類證治裁》人參三錢 (9g) 白朮一錢半 (4.5g) 茯苓一錢半 (4.5g) 川椒十四粒 (1g) 烏梅三個 (6g) 乾薑炒黑，一錢半 (4.5g) 水煎服。功用：溫中安蛔。主治：中陽不振，蛔蟲腹痛。便溏尿清，腹痛腸鳴，四肢不溫，饑不欲食，甚則吐蛔，舌苔薄白，脈沉遲。 2. 連梅安蛔湯《通俗傷寒論》胡黃連一錢 (3g) 川椒炒，十粒 (2g) 白雷丸三錢 (9g) 烏梅肉二枚 (5g) 生川柏八分 (2g) 尖檳榔磨汁沖，二枚 (9g) 水煎服。功用：清熱安蛔。主治：肝胃鬱熱，蟲積腹痛。饑不欲食，食則吐蛔，甚則蛔動不安，脘痛煩躁，手足厥逆，面赤口燥，舌紅，脈數","烏梅丸用細辛桂，黃連黃柏及當歸， 人參椒薑及附子，溫中寓清在安蛔")');
    await db.execute(
        'INSERT INTO $formulaeTable($formula_id,$formula_chinese_name,$formula_phonetic,$formula_english_name,$formula_classification,$formula_source,$formula_combination,$formula_method,$formula_action,$formula_indication,$formula_pathogenesis,$formula_clarification,$formula_application,additonal_$formulaeTable,$formula_formula_song) VALUES("182","瓜蒂散","Gua Di San","Melon Stalk Powder","湧吐劑","《傷寒論》","瓜蒂熬黃，一分 (3g) 赤小豆一分 (3g)","上二味，各別搗篩，為散已，合治之，取一錢匕 (2g)，以香豉一合 (9g)，用熱湯七合，煮作稀糜，去滓。取汁合散，溫，頓服之。不吐者，少少加，得快吐者乃止 (現代用法：將2藥研細末和勻，每服1~3g，用香豉9g煎湯送服。不吐者，用潔淨翎毛探喉取吐)","湧吐痰涎宿食","痰涎宿食，壅滯胸脘證。胸中痞硬，懊憹不安，欲吐不出，氣上沖咽喉不得息，寸脈微浮者","痰涎宿食填塞，氣機被遏，故胸中痞硬，懊憹不安，欲吐不出，氣上沖咽喉不得息。寸脈微浮為邪氣在上之征。治當因勢利導，遵《素問》至真要大論 「其高者，因而越之」 的原則，採用湧吐痰食法治療","","1. 辨證要點：本方為湧吐法之首要方劑。臨床應用以胸膈痞硬，懊憹不安，氣上沖喉咽不得息，或誤食毒物尚在胃中為辨證要點。 2. 現代運用：本方常用於暴飲暴食之胃擴張、誤食毒物、精神分裂症、精神抑鬱症等屬於痰食壅滯胸脘證者","三聖散《儒門事親》防風三兩 (5g) 瓜蒂三兩，炒黃用 (3g) 黎蘆去苗心，加減用之，或一兩，或半兩，或一分 (3g) 共為粗末，水煎徐徐服之，以吐為度，不必盡劑。亦可鼻內灌之。功用：湧吐風痰。主治：中風閉證。失音悶亂，口眼歪斜或不省人事，牙關緊閉，脈浮滑實者。對於癲癇，濁痰壅塞胸中，上逆時發者；誤食毒物停於上脘等證，亦可用之","瓜蒂赤豆等分研，豆豉汁調溫服研， 湧吐治法之首方，胸脘痰涎宿食蠲")');


    await db.execute(
        'CREATE TABLE $formulaHerbTable($formulaHerb_formula_id TEXT, $formulaHerb_herb_id TEXT)');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("1","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("1","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("1","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("2","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("2","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("2","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("2","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("3","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("4","0151")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("4","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("4","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("5","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0128")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0069")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0012")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0015")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("6","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("7","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("7","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("7","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("7","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("7","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0139")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0091")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("8","0123")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0149")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0140")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("9","0044")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("10","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("10","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("10","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0019")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("11","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("12","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("12","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("12","0038")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0049")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0032")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("13","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0151")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0049")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("14","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("15","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("15","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("15","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("16","0066")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("16","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("16","0091")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("16","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("17","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("17","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("18","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("18","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("18","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("19","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("19","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("19","0036")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("20","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("20","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("21","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("22","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("22","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("22","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0009")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0132")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("23","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("24","0143")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("24","0036")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("25","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("26","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("27","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("28","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("28","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("28","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("28","0186")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("29","0083")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("29","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("29","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("29","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("29","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("30","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("30","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("30","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("31","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("31","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("31","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("31","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("31","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("32","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("32","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("32","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("33","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("34","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("34","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("34","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("35","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("35","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("35","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("35","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("36","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("36","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("36","0011")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("36","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("36","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("37","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("37","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("38","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("38","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("38","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("38","0115")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("39","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("39","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("39","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("39","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0022")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0001")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0123")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0171")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("40","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0019")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0163")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0164")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0055")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0078")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0139")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("41","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("42","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("42","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("42","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0115")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0088")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("43","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("44","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("44","0109")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("45","0044")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("45","0112")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("45","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("46","0153")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("46","0160")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("46","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("47","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("47","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("47","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("47","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("48","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("48","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("48","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("48","0009")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("49","0038")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("49","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("49","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("49","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0083")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("50","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("51","0017")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("51","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("51","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("51","0158")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("52","0130")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("52","0165")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("52","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0064")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0042")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0050")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0165")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0153")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0130")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("53","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("54","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("55","0147")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("56","0134")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("56","0079")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("56","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("57","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("57","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("58","0162")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0061")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0133")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("59","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("60","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("60","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("60","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("60","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("61","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("61","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("61","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("61","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("62","0109")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("62","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("62","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("62","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("63","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("63","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("63","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("64","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0076")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("65","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("66","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("66","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("66","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("66","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("67","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("67","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("67","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("67","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0112")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0079")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("68","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("69","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("70","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("70","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("71","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("71","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("71","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0088")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("72","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("73","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("73","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("73","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("74","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("74","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0097")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0120")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("75","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("76","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("77","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("78","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("78","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("78","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("78","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("78","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0117")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0119")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0027")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("79","0107")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("80","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("80","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("80","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0004")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0117")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("81","0122")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0119")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("82","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0119")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0117")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0107")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("83","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0021")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0119")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0133")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0132")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("84","0065")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("85","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("85","0117")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("86","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("86","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("86","0173")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0141")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0160")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0121")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("87","0111")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0102")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0094")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("88","0111")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("89","0102")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("89","0084")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("89","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("89","0109")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("89","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("90","0118")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("90","0173")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("91","0176")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("91","0065")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("91","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("91","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("91","0169")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0173")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0119")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0170")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0047")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("92","0188")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("93","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("93","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("93","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("93","0058")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("94","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("94","0118")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("94","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("94","0088")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("94","0080")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("95","0184")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("95","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("95","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("95","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("95","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0011")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0065")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0081")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0120")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("96","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("97","0120")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("97","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("97","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("97","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("97","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0174")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0184")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0183")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0179")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0187")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("98","0177")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0180")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0179")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0172")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0189")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("99","0137")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0179")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0184")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0183")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0174")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0177")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("100","0187")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0187")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0164")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0177")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0058")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0137")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0189")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0082")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0184")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("101","0179")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("102","0058")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("102","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("102","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("102","0115")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("103","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("103","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("103","0059")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("103","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("104","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("104","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("104","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("104","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("106","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0057")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0110")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0101")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0037")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0083")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("107","0122")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0117")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0110")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0057")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0189")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("108","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0116")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0049")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("109","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0080")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0129")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0141")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("110","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("111","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("111","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0145")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("112","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("113","0077")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("113","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("113","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("113","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("113","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("114","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("114","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("114","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("114","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("114","0182")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0144")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0026")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0009")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("115","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0026")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0167")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0144")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("116","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0093")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0144")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("117","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0109")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("118","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("119","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("119","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("119","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("119","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("119","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("120","0142")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("121","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("121","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("121","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0165")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0150")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0024")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0105")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0131")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("122","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0126")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0127")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0147")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0146")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("123","0157")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("124","0186")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("124","0094")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0127")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0142")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("125","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("126","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("127","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("127","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("127","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("127","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("127","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0128")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0019")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("128","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0050")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("129","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("130","0167")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("130","0164")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("130","0163")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("131","0013")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("131","0175")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("132","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("132","0019")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("132","0003")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("132","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("132","0013")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0166")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0010")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0128")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0123")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("133","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0072")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0140")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0077")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("134","0172")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0173")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0054")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0122")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0098")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0136")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("135","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0003")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0072")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0027")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0154")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0135")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0075")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("136","0193")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0173")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("137","0165")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0049")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("138","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("139","0149")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("139","0004")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0149")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0185")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("140","0148")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("141","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("141","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("142","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("142","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("142","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("142","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("143","0004")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("143","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("143","0066")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("144","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("144","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("144","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("144","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("144","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0194")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0031")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0016")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0062")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("145","0152")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("146","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("146","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("146","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("146","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0090")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0019")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("147","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("148","0136")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("148","0115")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("148","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0088")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0131")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("149","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("150","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("150","0076")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("150","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("150","0112")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("150","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0136")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0053")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0074")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0125")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("151","0051")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("152","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("152","0053")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("152","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("152","0044")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0052")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0038")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0010")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0068")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0136")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0162")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("153","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("154","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("154","0025")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("155","0162")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("155","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("155","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("155","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("155","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("156","0162")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("156","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("156","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("156","0168")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("156","0181")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("157","0040")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("157","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("157","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("158","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("158","0160")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("158","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("158","0090")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("158","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("159","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("159","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("159","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("159","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("160","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("160","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("160","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("160","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0100")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("161","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("162","0053")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("162","0057")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0048")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0032")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0099")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("163","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0032")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0075")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0154")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0009")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0050")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0159")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0033")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0029")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("164","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("165","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("165","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("165","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0077")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("166","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("167","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("167","0113")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("167","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("168","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("168","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("168","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("168","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("168","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("169","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("169","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("170","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("170","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("170","0189")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("171","0093")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("171","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("171","0043")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("172","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("172","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("172","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("172","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("172","0108")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("173","0116")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("173","0095")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0003")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0007")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("174","0092")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0003")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0171")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0175")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0065")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0053")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0011")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("175","0045")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0103")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0096")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("176","0095")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0005")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0041")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("177","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0087")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0124")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0098")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0103")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0006")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("178","0102")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0070")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0098")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0071")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0156")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0114")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("179","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0046")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0162")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0161")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0020")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0067")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("180","0101")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0121")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0060")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0008")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0039")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0030")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0035")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0073")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0002")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("181","0155")');
    await db.execute(
        'INSERT INTO $formulaHerbTable($formulaHerb_formula_id,$formulaHerb_herb_id) VALUES("182","0089")');
  }

  //Fetch all herb----------------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> getHerbMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $herbTable WHERE $colHaveIcon = '1'");
    return result;
  }
  Future<List<Map<String, dynamic>>> getHerbMapListbyValue(String value) async {
    Database db = await this.database;
    String input = "%" + value + "%";
    var result = await db.rawQuery(
        "SELECT * FROM $herbTable WHERE $colEngName LIKE '$input' OR $colChName LIKE '$input' ");
    return result;
  }
  Future<List<Map<String, dynamic>>> getHerbMapListbyID(String id) async {
    Database db = await this.database;
    String input = id;
    var result = await db
        .rawQuery("SELECT * FROM $herbTable WHERE $colHerbID = '$input'");
    return result;
  }
  Future<List<Herb>> getHerbList() async {
    var herbMapList = await getHerbMapList();
    int count = herbMapList.length;
    List<Herb> herbList = List<Herb>();
    for (int i = 0; i < count; i++) {
      herbList.add(Herb.fromMapObject((herbMapList[i])));
    }
    return herbList;
  }
  Future<List<Herb>> getHerbListbyValue(String value) async {
    var herbMapList = await getHerbMapListbyValue(value);
    int count = herbMapList.length;
    List<Herb> herbList = List<Herb>();
    for (int i = 0; i < count; i++) {
      herbList.add(Herb.fromMapObject((herbMapList[i])));
    }
    return herbList;
  }
  Future<List<Herb>> getHerbListbyID(String id) async {
    var herbMapList = await getHerbMapListbyID(id);
    int count = herbMapList.length;
    List<Herb> herbList = List<Herb>();
    for (int i = 0; i < count; i++) {
      herbList.add(Herb.fromMapObject((herbMapList[i])));
    }
    return herbList;
  }

  //Fetch all formula----------------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> getFormulaMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $formulaeTable");
    return result;
  }
  Future<List<Map<String, dynamic>>> getFormulaMapListbyValue(String value) async {
    Database db = await this.database;
    String input = "%" + value + "%";
    var result = await db.rawQuery(
        "SELECT * FROM $formulaeTable WHERE $formula_chinese_name LIKE '$input' OR $formula_english_name LIKE '$input' ");
    return result;
  }
  Future<List<Map<String, dynamic>>> getFormulaMapListbyID(String id) async {
    Database db = await this.database;
    String input = id;
    var result = await db
        .rawQuery("SELECT * FROM $formulaeTable WHERE $formula_id = '$input'");
    return result;
  }
  Future<List<Formula>> getFormulaList() async {
    var formulaMapList = await getFormulaMapList();
    int count = formulaMapList.length;
    List<Formula> formulaList = List<Formula>();
    for (int i = 0; i < count; i++) {
      formulaList.add(Formula.fromMapObject((formulaMapList[i])));
    }
    return formulaList;
  }
  Future<List<Formula>> getFormulaListbyValue(String value) async {
    var formulaMapList = await getFormulaMapListbyValue(value);
    int count = formulaMapList.length;
    List<Formula> formulaList = List<Formula>();
    for (int i = 0; i < count; i++) {
      formulaList.add(Formula.fromMapObject((formulaMapList[i])));
    }
    return formulaList;
  }
  Future<List<Formula>> getFormulaListbyID(String id) async {
    var formulaMapList = await getFormulaMapListbyID(id);
    int count = formulaMapList.length;
    List<Formula> formulaList = List<Formula>();
    for (int i = 0; i < count; i++) {
      formulaList.add(Formula.fromMapObject((formulaMapList[i])));
    }
    return formulaList;
  }


  //Fetch all formula_herb----------------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> getHerbMapListbyFormula(String id) async {
    Database db = await this.database;
    String input = id;
    var result = await db
        .rawQuery("SELECT * FROM $herbTable WHERE $colHerbID IN (SELECT $formulaHerb_herb_id FROM $formulaHerbTable WHERE $formulaHerb_formula_id = '$input') AND $colHaveIcon = '1'");
    return result;
  }
  Future<List<Map<String, dynamic>>> getFormulaMapListbyHerb(String id) async {
    Database db = await this.database;
    String input = id;
    var result = await db
        .rawQuery("SELECT * FROM $formulaeTable WHERE $formula_id IN (SELECT * FROM $formulaHerbTable WHERE $formulaHerb_herb_id = '$input')");
    return result;
  }
  Future<List<Herb>> getHerbListbyFormula(String id) async {
    var herbMapList = await getHerbMapListbyFormula(id);
    int count = herbMapList.length;
    List<Herb> herbList = List<Herb>();
    for (int i = 0; i < count; i++) {
      herbList.add(Herb.fromMapObject((herbMapList[i])));
    }
    return herbList;
  }
  Future<List<Formula>> getFormulaListbyHerb(String id) async {
    var formulaMapList = await getFormulaMapListbyHerb(id);
    int count = formulaMapList.length;
    List<Formula> formulaList = List<Formula>();
    for (int i = 0; i < count; i++) {
      formulaList.add(Formula.fromMapObject((formulaMapList[i])));
    }
    return formulaList;
  }
}
