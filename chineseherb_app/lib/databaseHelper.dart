import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:chineseherb_app/models/herb.dart';

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
        '$colEngName TEXT, $colEffect TEXT, $colTaste TEXT, $colQulity TEXT, $colShape TEXT)');
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0001','馬勃','Puffball','局部止血藥，清肺，利咽，解熱等','辛，平','以個大、皮薄、飽滿、鬆泡有彈性者為佳','紫色馬勃：呈陀螺形，或已壓扁呈扁圓形，直徑5~12cm，不孕基部發達；包被薄，2層，紫褐色，粗皺，有圓形凹陷，外翻，上部常裂成小塊或已部分脫落；孢體紫色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0002','人參','Ginseng Root','大補元氣，複脈固脫，補脾益肺，生津止渴，安神益智。用於體虛欲脫，肢冷脈微，脾虛食少，肺虛喘咳，津傷口渴，內熱消渴，久病虛贏，驚悸失眠，陽痿宮冷；心力衰竭，心原性休克','平、味甘、微苦，微溫','以條粗、質硬、皮細、無破痕者為佳','生曬參片：為圓形或類圓形薄片，表面灰白色，顯菊花紋，粉性，體輕，質脆。有特異香氣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0003','天麻','Tall Gastrodiae','息風止痙，平肝潛陽，祛風通絡','氣微，性平，味甘，微辛','藥材以質地堅實，體重，有鸚哥嘴，無空心者為佳。飲片以體實澤亮半透明者為佳','塊莖呈橢圓形或長條形，略扁，皺縮而稍彎曲。長3~15cm，寬1.5~6cm，厚0.5~2cm。表面黃白色至淡黃棕色，略透明，多不規則縱皺紋，有縱皺紋及由潛伏芽排列成的多輪橫環紋，有時可見棕褐色菌索，具點狀痕點或膜質鱗葉有時可見棕黑色菌索。冬至以後莖枯時採挖者稱“冬麻”，頂端為紅棕色至深棕色頂芽；立夏以前植株出芽時採挖者稱“春麻”，頂端有殘留莖基。末端均有自母體麻脫落後的圓臍狀疤痕。質堅實，不易折斷，斷面較平坦，角質樣，黃白色或淡棕色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0004','北沙參','Coastal Glehnia Root','養陰清肺，益胃生津。用於肺熱燥咳、勞嗽痰血、熱病津傷口渴','甘，微苦，微寒','以枝條細長、圓柱形、均勻、質堅、外皮色白者為佳','長圓柱形，偶有分枝。表面淡黃白色，偶有外皮殘存，全體有細縱皺紋及縱溝，並有棕黃色點狀細根痕。頂端常留有棕黃色根莖殘基，上端稍細，中部略粗，下部漸細。質脆，易折斷，斷面皮部淺黃白色，木部黃色。氣特異，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0005','大黃','Tangute Rhubarb','攻積滯；清濕熱；瀉火；涼血；祛瘀；解毒。主治實熱便秘；熱結胸痞；濕熱瀉痢；黃疸；淋病；水腫腹滿；小便不利；目赤；咽喉腫痛；口舌生瘡；胃熱嘔吐；吐血；咯血；衄血；便血；尿血；蓄血；經閉；產後瘀滯腹痛；症瘕積聚；跌打損傷；熱毒癰瘍；丹毒；燙傷','味苦，性寒','以堅實、氣清香味苦而微澀者為佳','本品呈類圓柱形、圓錐形、卵圓形或不規則塊狀，長3~17cm，直徑3~10cm。除盡外皮者表面黃棕色至紅棕色，有的可見類白色網狀紋理及星點 (異型維管束) 散在，殘留的外皮棕褐色，多具繩孔及粗皺紋。質堅實，有的中心稍鬆軟，斷面淡紅棕色或黃棕色，顯顆粒性；根莖髓部寬廣，有星點環列或散在；根木部發達，具放射狀紋理，成層環明顯，無星點。氣清香，味苦而微澀，嚼之粘牙，有砂粒感')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0006','山藥','Common Yan Rhizome','補脾養胃，生津益肺，補腎澀精。用於脾虛食少，久瀉不止，肺虛喘咳，腎虛遺精，帶下，尿頻，虛熱消渴','甘、平','以身長、條粗、質堅實、粉性足、色潔白者為佳','略呈圓柱形，彎曲而稍扁，長15~30cm，直徑1. 5~6cm。表面黃白色或淡黃色，有縱溝、縱皺紋及鬚根痕，偶有淺棕色外皮殘留。體重，質堅實，不易折斷，斷面白色，粉性。無臭，味淡、微酸，嚼之發粘。光山藥呈圓柱形，兩端平齊，長9~18cm，直徑1. 5~3cm。表面光滑，白色或黃白色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0007','生薑','Fresh Ginger','發汗解表，溫中止嘔，溫肺止咳，解魚蟹毒，解藥毒','辛，微溫','以個大，肉質厚，新鮮者為佳','生薑呈不規則的塊狀，略扁，肉質肥厚。表面黃褐色或灰棕色，質脆，易折斷，斷面黃色，內皮層有明顯環紋。氣香特異，味辛辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0008','乾薑','Dried Ginger','溫中散寒，回陽通脈，燥濕消痰，溫肺化飲。主治脘腹冷痛；嘔吐；泄瀉，亡陽厥逆；寒飲喘咳；寒濕痹痛','味辛，性熱','以質堅實、斷面色黃白、粉性足、氣味濃者為佳','根莖呈不規則塊狀，略扁，具指狀分枝，長3~7cm，厚1~2cm。表面灰棕色或淺黃棕色，粗糙，具縱皺紋及明顯的環節。分枝處常有鱗葉殘存，分枝頂端有莖痕或芽。質堅實，斷面黃白色或灰白色，粉性和顆粒性，有一明顯圓環 (內皮層)，筋脈點 (維管束) 及黃色油點散在。氣香，特異，味辛辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0009','牛膝','Common Achyranthes','補肝腎；強筋骨；活血通經；引火 (血) 下行；利尿通淋。主治腰膝酸痛；下肢痿軟；血滯經閉；痛經；產後血瘀腹痛；症瘕；胞衣不下；熱淋；血淋；跌打損傷；癰腫惡瘡；咽喉腫痛','味苦；酸；性平','以條長、皮細肉肥、色黃白者為佳','根呈細長圓柱形，有的稍彎曲，上端稍粗，下端較細，長15~50cm，直徑0.4~1cm。表面及黃色或淡棕色，具細微縱皺紋，有細小橫長皮孔及稀疏的細根痕。質硬而脆，易折斷，斷面平坦，黃棕色，微呈角質樣，中心維管束木部較大，黃白色，其週邊散有多數點狀維管束，排列成2~4輪。氣微，味微甜、澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0010','苦參','Lightyellow Sophra Root','清熱燥濕；祛風殺蟲。主濕熱瀉痢；腸風便血；黃疸；小便不利；水腫；帶下；陰癢；疥癬；麻風；皮膚瘙癢；濕毒瘡瘍 ','苦，寒','以條勻、斷面黃白、味極苦者為佳','根長圓柱形，下部常分枝，長10~30cm，直徑l~2.5cm。表面棕黃色至灰棕色，具縱皺紋及橫生皮孔。栓皮薄，常破裂反卷，易剝落，露出黃色內皮。質硬，不易折斷，折斷面纖維性。切片厚3~6mm，切面黃白色，具放射狀紋理。氣微，味苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0011','丹參','Dan - shen Root','活血調經，祛瘀止痛，涼血消癰，清心除煩，養血安神。主治月經不調，經閉痛經，症瘕積聚，胸腹刺痛，熱痹疼痛，瘡瘍腫痛，心煩不眠；肝脾腫大，心絞痛','苦，微寒','以條粗壯、色紫紅者為佳','藥材多為帶根莖的根，根莖粗短，有莖基殘餘，下著生多數細長的根。根呈圓柱形，稍彎曲，表面呈磚紅色，粗糙，具多數縱溝或皺紋，有鬚根痕，外部栓皮常鱗片狀剝落，皮層有時開裂，長8~22cm，直徑5~12mm，質堅脆，易折斷，斷面不平，疏鬆有裂隙，皮部棕渴色或磚紅色，韌皮部狹。形成層明顯，淡棕色，木質部導管束灰黃色或黃白色，放射狀排列。氣微，味微苦、澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0012','百部','Japanese Stemona Root','潤肺下氣止咳，殺蟲。用於新久咳嗽，肺癆咳嗽，百日咳；外用於頭蝨，體虱，蟯蟲病，陰部騷癢','甘、苦，微溫','以粗壯、肥潤、堅實、色白者為佳','對葉百部：呈長紡錘形或長條形，長8~24cm，直徑0.8~2cm。表面淺黃棕色至灰棕色，具淺縱皺紋或不規則縱槽。質堅實，斷面黃白色至暗棕色，柱較大，髓部類白色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0013','白附子','Giant Typhonium Tuber','燥濕化痰，祛風止痙，解毒散結止痛','味辛、甘，性溫，有毒','以個大、質堅實，色白、粉性足者為佳','白附子塊莖呈橢圓形或卵圓形，長2~5cm，直徑1~3cm。表面白色或黃白色，有環紋及鬚根痕，頂端具莖痕或芽痕。質堅硬，斷面類白色，富粉性。無臭，味淡，嚼之麻辣刺舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0014','白茅根','Lalang Grass Rhizome','涼血，止血，清熱，利尿。治熱病煩渴，吐血，衄血，肺熱喘急，胃熱噦逆，淋病，小便不利，水腫，黃疸','甘、寒','以條粗、色白、味甜者為佳','根莖長圓柱形，有時分枝，長短不一，長30~60cm，直徑2~4mm。表面黃白色或淡黃色，有光澤，具縱皺紋，環節明顯，節上殘留灰棕色鱗葉及細根，節間長1~3cm。體輕，質韌，折斷面纖維性，黃白色，多具放射狀裂隙，有時中心可見一小孔。氣微，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0015','白前','Willowleaf Swallowwort Rhizome and Root','降氣化痰，止咳。用於咳嗽痰多，氣喘。該品性微溫而不燥烈，長於祛痰，降肺氣以平咳喘，無論屬寒屬熱，外感內傷，新嗽久咳均可用之','辛、苦，微溫','以根莖粗、鬚根長、斷面粉白色、粉性足者為佳','根纖細彎曲扭轉而成團狀，長約1~10cm，多數呈毛須狀，表面棕色或紫棕色，有細繳皺，並具多數小鬚根。根莖呈管狀，細長有節，略彎曲，長約4~15cm，直徑1.5~5mm，表面淺黃色至黃棕色，有細縱皺紋，節部膨大，常有分歧，並密生鬚根，頂端常殘留灰綠色或紫棕色的地上莖；質堅脆，易折斷，斷面類圓形，中空或有膜質的髓。質堅脆，易折斷，斷面類白色，氣微弱，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0016','白芍','White Peony Root','養血柔肝，緩中止痛，斂陰收汗。治胸腹脅肋疼痛，瀉痢腹痛，自汗盜汗，陰虛發熱，月經不調，崩漏，帶下','苦酸，微寒','以根粗長、勻直、質堅實、粉性足、表面潔淨者為佳','乾燥根呈圓柱形，粗細均勻而平直，長10~20cm，直徑1~1.8cm。表面淡紅棕色或粉白色，平坦，或有明顯的縱皺及鬚根痕，栓皮未除盡處有棕褐色斑痕，偶見橫向皮孔。質堅實而重，不易折斷。斷面灰白色或微帶棕色，木部放射線呈菊花心狀，形成層環明顯。氣微，味微苦而酸')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0017','白頭翁','Chinese Pulsatilla Root','清熱解毒，涼血止痢，燥濕殺蟲。主治熱毒痢疾，鼻衄，血痔，帶下，陰癢，癰瘡，瘰鬁','味苦，性寒','以條粗長，質堅實者為佳','根長圓柱形或圓錐形，稍彎曲，有時扭曲而稍扁，長5~20cm，直徑0.5~2cm。表面黃棕色或棕褐色，有不規則的縱皺紋或縱溝，中部有時分出2~3支根，皮部易脫落而露出黃色木部，且常朽蝕成凹洞，可見縱向突起的網狀花紋；根頭部稍膨大，有時分叉，頂端殘留數層鞘狀葉柄基及幼葉，密生白色長絨毛。質硬脆，折斷面稍平坦，皮部黃白色，木部淡黃色，皮部與木部間有時出現空隙。氣微，味微苦澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0018','白薇','Blackend Swallowwort Root and Rhizome','清熱涼血，利尿通淋，解毒療瘡。用於溫邪傷營發熱，陰虛發熱，骨蒸勞熱，產後血虛發熱，熱淋，血淋，癰疽腫毒','味苦、鹹，寒','以根細長，棕黃色者為佳','根莖粗短，有結節，多彎曲。上面有圓形的莖痕，下面及兩側簇生多數細長的根，根長10~25cm，直徑0.1~0.2cm。表面棕黃色。質脆，易折斷，斷面皮部黃白色，木部黃色。氣微，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0019','白芷','Taiwan Angelica Root','祛風濕，活血排膿，生肌止痛。用於頭痛、牙痛、鼻淵、腸風痔漏、赤白帶下、癰疽瘡瘍、皮膚瘙癢','辛，溫','以條粗壯，質堅硬、體重、色白、粉性足、香氣濃者為佳','根呈圓錐形，長10~20cm，直徑2~2.5cm。表面灰棕色，有橫向突起的皮孔，頂端有凹陷的莖痕。質硬，斷面白色，粉性足，皮部密佈棕色油點。氣芳香，味辛、微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0020','白朮','Largehead Atractylodes Rhizome','健脾益氣、燥濕利水、止汗、安胎。用於脾虛食少、腹脹泄瀉、痰飲眩悸、水腫、自汗、胎動不安','苦、甘，溫','以個大、堅實、斷面黃白色、香氣濃郁者為佳','根莖呈拳形團塊，長3~13cm，直徑1.5~7cm。表面灰黃色或灰棕色，有瘤狀突起及斷續的縱皺紋和鬚根痕，頂端有殘留莖基和芽痕。質堅硬，不易折斷，斷面不平坦，黃白色至淡棕色，有棕黃色的點狀油室散在。氣清香，味甘、微辛，嚼之略帶粘性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0021','巴戟天','Medicinal Morinda Root','補腎助陽；強筋壯骨；祛風除濕。用於腎虛陽痿；遺精早洩；少腹冷痛；小便不禁；宮冷不孕；風寒濕痹；腰膝酸軟；風濕肢氣','辛、甘，溫','以條肥壯、連珠狀、肉厚、色紫者為佳','根扁圓柱形式圓柱形，略彎曲，長度不等，直徑1~2cm，表面灰黃色或灰黃棕色，有的微帶紫色，具縱皺及深陷的橫紋，有的呈縊縮狀或皮部橫向斷離而露出木部，形如雞腸。質堅韌，折斷面不平，皮部厚5~7mm，淡紫色，木部直徑2~4mm。氣微，味苦，略澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0022','板藍根','Indigowoad Root','清熱，解毒，涼血，利咽。用於溫毒發斑；高熱頭痛；大頭瘟疫；舌絳紫暗，爛喉丹痧；丹毒；痄腮；喉痹；瘡腫、癰腫；水痘；麻疹；肝炎；流行性感冒，流腦，乙腦，肺炎，神昏吐衄，咽腫，火眼，瘡疹','苦，寒','以根平直粗壯、堅實、粉性大者為佳','呈細長圓柱形，長約10~20~30cm，直徑3~8mm。表面淺灰黃色，粗糙，有縱皺紋及橫斑痕，並有支根痕，根頭部略膨大，頂端有一凹窩，周邊有暗綠色的葉柄殘基，較粗的根並現密集的疣狀突起及輪狀排列的灰棕色的葉柄痕。質堅實而脆，斷面皮部黃白色至淺棕色，木質部黃色。氣微弱，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0023','草烏','Kusnezoff Monkshood Mother Root','祛風除濕，溫經止痛。用於風寒濕痹，關節疼痛，心腹冷痛，寒疝作痛，麻醉止痛','辛、苦，熱，有大毒','以個大、肥壯、質堅實、粉性足、殘莖及鬚根少者為佳','草烏呈圓錐形而稍彎曲，形如烏鴉頭，長2~7cm，直徑1~3cm，頂端常有長1cm左右的殘莖或莖痕，表面暗棕色或灰褐色，外皮皺縮。有的具突起的支根。質堅，難折斷，斷面白色或灰白色，形成層環紋多角形或類圓形。無臭，味辛辣，麻舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0024','柴胡','Chinese Thorawax Root','和解少陽，疏肝解鬱。透表泄熱，升舉陽氣。用於感冒發熱、寒熱往來、瘧疾，肝鬱氣滯，胸肋脹痛，脫肛，子宮脫落，月經不調','苦，微寒','以條粗，無殘留鬚根者為佳','呈圓柱形或長圓錐形，長6~15cm，直徑0.3~0.8cm。根頭膨大，頂端殘留3~15個莖基或短纖維狀葉基，下部分枝。表面黑褐色或淺棕色，具縱皺紋、支根痕及皮孔。質硬而韌，不易折斷，斷面顯片狀纖維性，皮部淺棕色，木部黃白色。氣微香，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0025','蒼朮','Swordlike Atracylodes Rhizome','燥濕健脾，祛風散寒，明目。用於脘腹脹滿，泄瀉水腫，腳氣痿躄，風濕痹痛，風寒感冒，夜盲','苦、辛，溫','以個大、質堅實、斷面朱砂點多、香氣濃者為佳','呈不規則連珠狀或結節狀圓柱形，略彎曲，偶有分枝，長3~10cm，直徑1~2cm。表面灰棕色，有皺紋、橫曲紋及殘留鬚根，頂端具莖痕或殘留莖基。質堅實，斷面黃白色或灰白色，散有多數橙黃色或棕紅色油室，暴露稍久，可析出白色細針狀結晶。氣香特異，味微甘、辛、苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0026','赤芍','Red Paeoniae Trichocarpae','清熱涼血、散瘀止痛的功能。生赤芍以清熱涼血力勝。多用於溫病熱入血分的身熱出血，目赤腫痛，癰腫瘡毒','苦，微寒','以根條粗壯、粉性足、斷面粉白色者為佳','該品呈圓柱形，稍彎曲，長5~40cm，直徑0.5~3cm。表面棕褐色，粗糙，有縱溝及皺紋，並有鬚根痕及橫向凸起的皮孔，有的外皮易脫落。質硬而脆，易折斷，斷面粉白色或粉紅色，皮部窄，木部放射狀紋理明顯，有的有裂隙。氣微香，味微苦、酸澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0027','川牛膝','Medicinal Cyathula officinalis Root','逐瘀通經，通利關節，利尿通淋。用於經閉症瘕，胞衣不下，關節痹痛，足痿筋攣，尿血血淋，跌撲損傷','甘、微苦，平','以分枝少、根粗壯、斷面淺黃色者為佳','本品呈近圓柱形，微扭曲，向下略細或有少數分枝，長30~60cm，直徑0.5~3cm。表面黃棕色或灰褐色，有微扭曲的縱皺紋、側根痕和多數橫長的散在皮孔樣突起。質韌，不易折斷，斷面淺黃色或棕黃色，維管束點狀，排列成數輪同心環。氣微，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0028','川烏','Common Monkshood Mother Root','祛風除濕；溫經；散寒止痛。主風寒濕痹；關節疼痛；肢體麻木；半身不遂；頭風頭痛；心腹冷痛；寒疝作痛；跌打瘀痛；陰疽腫毒；並可用於麻醉止痛 ','辛、苦，熱，有大毒','以飽滿、質堅實、斷面色白者為佳','為不規則圓錐形，稍彎曲，頂端常有殘莖，中部多向一側膨大，長2~7.5cm，直徑1.2~2.5cm。表面棕褐色或灰棕色，皺縮，有小瘤狀側根及子根痕。質堅實，斷面類白色或淺灰黃色，形成層環多角形。氣微，味辛辣、麻舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0029','川芎','Szechwan Lovage Rhizome','活血祛瘀；行氣開鬱；祛風止痛 。用於胸痹心痛，胸脅刺痛，跌撲腫痛，月經不調，經閉痛經，癮瘕腹痛，頭痛，風濕痹痛','辛，溫','以個大飽滿、質堅實、油性大、香氣濃、斷面黃白者為佳','為不規則結節狀拳形團塊，直徑2~7cm。表面黃褐色，粗糙皺縮，有多數平行隆起的輪節，頂端有凹陷的類圓形莖痕，下側及輪節上有多數小瘤狀根痕。質堅實，不易折斷，斷面黃白色或灰黃色，散有黃棕色的油室，形成層呈波狀環紋。氣濃香，味苦、辛。稍有麻舌感，微回甜。飲片邊緣不整齊，呈不規則的類蝴蝶形薄片')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0030','當歸','Chinese Angelica','補血活血，調經止痛，潤腸通便。用於血虛萎黃、眩暈心悸、月經不調、經閉痛經、虛寒腹痛、腸燥便秘、風濕痹痛、跌撲損傷、癰疽瘡瘍','甘、辛，溫','以主根粗長、油潤、外皮黃棕色、肉質飽滿、香氣濃者為佳','全歸長略呈圓柱形，下部有支根3~5條或更多，長15~25cm。外皮細密，表面黃棕色至棕褐色，具縱皺紋及橫長皮孔。根頭 (歸頭) 直徑1.5~4cm，具環紋，上端圓鈍，有紫色或黃綠的葉鞘的殘基；主根 (歸身) 表面凹凸不平；支根 (歸尾) 直徑0.3~1cm，上粗下細，多扭，有少數鬚根痕。質柔韌，斷面黃白色或淡黃棕色，皮部厚，有裂隙及多數棕色點狀分泌腔，木部色較淡，形成層環黃棕色。木質部色較淡；根莖部分斷面中心通常有髓和空腔')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0031','生地黃','Dried Rehmannia Root','生地黃清熱涼血，養陰生津；','生地黃甘，寒；','生地黃以塊大、體重、斷面烏黑油潤，味甘者為佳；','生地黃呈不規則的圓形或長圓形塊狀，長6~12cm，直徑3~6cm；表面灰棕色或灰黑色，全體皺縮不平，具不規則的橫曲紋；細小的多為長條狀，稍扁而扭曲；質柔軟，乾後則堅實，體重，不易折斷，斷面平坦，紫黑色或烏黑色而光亮，顯油潤，具粘性；氣微香，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0032','獨活','Doubleteeth Angelicae Root','祛風勝濕；散寒止痛。用於風寒濕痹；腰膝疼痛；少陰伏風頭痛，頭痛齒痛','辛、苦，微溫','以條粗壯、油潤、香氣濃者為佳','根頭及主根粗短，略呈圓柱形，長1.5~4cm，直徑1.5~3.5cm，下部有數條彎曲的支根，長12~30cm，直徑0.5~1.5cm。表面粗糙，灰棕色，具不規則縱皺紋及橫裂紋，並有多數橫長皮孔及細根痕；根頭部有環紋，具多殖環狀葉柄痕，中內為凹陷的莖痕。質堅硬，斷面灰黃白色，形成層環棕色，皮部有棕色油點 (油管)，木部黃棕色；根頭橫斷面有大形賄部，亦有油點。香氣特異，味苦辛，微麻舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0033','防風','Divaricate Saposhnikovia','治外感風寒，頭痛，目眩，項強、風寒濕痹，骨節酸痛，四肢攣急，破傷風','辛、甘，微溫','以條粗壯、皮細而緊、無毛頭、斷面有棕色環、中心色淡黃者為佳','乾燥的根呈圓錐形或紡錘形，稍彎曲，長20~30cm，根頭部直徑約1cm，中部直徑1~1.5cm。表面灰黃色或灰棕色。根頭部有密集的細環節，節上有棕色粗毛，頂端有莖的殘痕；根部外皮皺縮而粗糙，有不整齊的縱皺及細橫紋，除散生汙黃色的橫長皮孔外，點狀突起的鬚根痕也隨處可見。質松而軟，易折斷，斷而不平坦，木部淡黃色，皮部黃棕色有裂隙，射線呈放射狀。氣微香，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0034','防己','Fourstamen Stephania Root','利水消腫，祛風止痛。主治水腫腳氣，小便不利，濕疹瘡毒，風濕痹痛，高血壓症。一般認為，漢防己利水消腫作用較強，木防己祛風止痛作用較好','苦，寒','以質堅實、斷面白色、粉性足者為佳','根不規則圓柱形，形如“豬大腸”，剖切成半圓柱形或塊狀，常彎曲，彎曲處有深陷橫溝而呈結節狀，長5~15cm，直徑1~5cm。表面灰黃色，有細皺紋及橫向突起的皮孔。質堅重，斷面平坦，灰白色，有“蜘蛛網紋”，具粉性。氣微，味苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0035','附子','Prepared Common Monkshood Daughter Root','回陽救逆，補火助陽，散寒止痛。“為回陽救逆第一品藥”。用於陰盛格陽，大汗亡陽，吐瀉厥逆，肢冷脈微，心腹冷痛，冷痢，腳氣水腫，風寒濕痹，陽痿，宮冷，虛寒吐瀉，陰寒水腫，陽虛外感，陰疽瘡瘍以及一切沉寒痼冷之疾','甘、辛，大熱，有毒','白附片以片大、色白、半透明者為佳','淡附片：為縱切薄片，表面灰白色，質硬脆。氣微、味淡，無麻舌感')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0036','甘遂','Kansui Root','瀉水逐飲，消腫散結。用於水腫脹滿，胸腹積水，痰飲積聚，氣逆喘咳，二便不利，消腫散結：外用可治癰腫瘡瘍','苦，寒，有毒','以色白、肥大、粉性足者為佳','本品呈橢圓形、長圓柱形或連珠形，長1~5cm，直徑0.5~2.5cm。表面類白色或黃白色，凹陷處有棕色外皮殘留。質脆，易折斷，斷麵粉性，白色，木部微顯放射狀紋理；長圓柱狀者纖維性較強。氣微，味微甘而辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0037','高良薑','Lesser Galangal Rhizome','溫胃散寒，消食止痛。用於脘腹冷痛，胃寒嘔吐，噯氣吞酸','辛，熱','以氣香味辣、分枝少、紅棕色者為佳','該品呈圓柱形，多彎曲，有分枝，長5~9cm，直徑1~1.5cm。表面棕紅色至暗褐色，有細密的縱皺紋及灰棕色的波狀環節，節間長0.2~1cm，一面有圓形的根痕。質堅韌，不易折斷，斷面灰棕色或紅棕色，纖維性，中柱約占1/3。氣香，味辛辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0038','葛根','Lobed Kudzuvine Root','解表退熱，生津，透疹，升陽止瀉。用於外感發熱頭痛、高血壓頸項強痛、口渴、消渴、麻疹不透、熱痢、泄瀉','甘、辛，涼','以白色、塊大、質堅實、粉性足、纖維少者為佳','本品呈縱切的長方形厚片或小方塊，長5~35cm，厚0.5~1cm。外皮淡棕色，有縱皺紋，粗糙。切面黃白色，紋理不明顯。質韌，纖維性強。氣微，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0039','黃連','Chinese Goldthread Rhizome','清熱燥濕，瀉火解毒。用於濕熱痞滿，嘔吐吞酸，瀉痢，黃疸，高熱神昏，心火亢盛，心煩不寐，血熱吐衄，目赤，牙痛，消渴，癰腫疔瘡；外治濕疹，濕瘡，耳道流膿','苦，寒','均以條粗壯、質堅實、無殘莖毛須者為佳','雲連：藥材彎曲呈鉤狀，形如“蠍尾”，多為單枝，較細小。以乾燥、條細、節多、鬚根少，色黃者為佳品')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0040','黃芪','Membranous Milkvetch Root','補氣固表，利尿托毒，排膿，斂瘡生肌的功效。用於氣虛乏力，食少便溏，中氣下陷，久瀉脫肛，便血崩漏，表虛自汗，癰疽難潰，久潰不斂，血虛萎黃，內熱消渴','甘，溫','以根條粗長、菊花心鮮明、空洞小、破皮少者為佳；紅芪以皮色紅潤、根條均勻、堅實、粉性足者為佳','直根圓柱形、有的有分枝，上端較粗，長30~90釐米，直徑1~3.5釐米，表面縱皺色淡棕黃色或淡棕褐色，有不整齊的縱皺紋或縱溝質，硬而韌有粉性，皮部黃白較疏鬆；木部菊花紋理狀，氣似豆腥味微甜。老根中心偶有枯朽狀，黑褐色或呈空洞。氣微，味微甜，嚼之微有豆腥味')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0041','黃芩','Baikal Skullcap Root','清熱燥濕，瀉火解毒，止血，安胎，降血壓。用於濕溫、暑溫胸悶嘔惡，濕熱痞滿，瀉痢，黃疸，肺熱咳嗽，高熱煩渴，血熱吐衄，癰腫瘡毒，胎動不安','苦，寒','以根長、質堅實、色黃者為佳','該品呈圓錐形，扭曲，長8~25cm，直徑1~3cm。表面棕黃色或深黃色，有稀疏的疣狀細根痕，上部較粗糙，有扭曲的縱皺或不規則的網紋，下部有順紋和細皺。質硬而脆，易折斷，斷面黃色，中間紅棕色，通稱子芩，以清火養陰為主；老根中間呈暗棕色或棕黑色，枯朽狀或已成空洞，稱枯芩，以清火敗毒為主。氣微，味苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0042','胡黃連','Figwortflower Picrorhiza Rhizome','清熱，涼血，燥濕。 陰虛骨蒸；潮熱盜汗；小兒疳疾；濕熱瀉痢；黃疸；吐血；衄血；目赤腫痛；癰腫瘡瘍；痔瘡腫毒','苦，寒','以條粗、折斷時有粉塵、斷面灰黑色、味苦者為佳','根莖圓柱形，平直或彎曲，多不分枝，市售品多為小段，長2~9cm，直徑3~8mm。表面灰黃色至黃棕色，有光澤，粗糙，具縱皺及橫環紋，栓皮脫落處呈褐色；上端有殘留的葉跡，密集呈鱗片狀，暗紅棕色，或脫落後呈半圓狀的節痕。根痕圓點狀，近節處較多。質硬而脆，易折斷，折斷時有粉塵；斷面可見維管束小點4~7個，排列成環。氣微，味極苦而持久')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0043','桔梗','Balloonflower Root','宣肺、祛痰、利咽、排膿、利五臟、補氣血、補五勞、養氣。主治咳嗽痰多、咽喉腫痛、肺癰吐膿、胸滿脅痛、痢疾腹痛、口舌生瘡、目赤腫痛、小便癃閉','苦、辛，平','以條肥大、體堅實、色白者為佳','根長圓形或長紡錘形，稍扭曲，下部偶有分支，長6~20cm，直徑1~2cm。表面淡黃白色或淡黃棕色 (未去栓皮者)，皺縮，有扭轉的縱溝及橫長的皮孔斑痕，上部有橫紋；頂端蘆頭 (根莖) 長0.5~4cm，有半月形凹陷的莖痕，呈盤節狀。質堅實，橫斷面淡黃色，角質樣，形成層環棕色，皮部有稀少放射狀裂隙，木部較緊密。氣微，味微甜後苦。飲片性狀：桔梗為不規則圓形厚片，表面白色或淡黃白色，有一淺棕色環，周邊呈淡黃白色，有皺紋。無臭，味微甜後苦。蜜桔梗，形如桔梗生片，表面淡黃色至淡棕黃色，滋潤，微具蜜糖香氣。味甜而後苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0044','蘆根','Reed Rhizome','清熱生津，除煩，止嘔，利尿。用於熱病煩渴、胃熱嘔吐、肺熱咳嗽、肺癰吐膿、熱淋澀痛','甘，寒','以條粗壯、黃白色、有光澤、無鬚根、質嫩者為佳','乾蘆根呈壓扁的長圓柱形。表面有光澤，黃白色，節部較硬，顯紅黃色，節間有縱皺紋。質輕而柔韌，不易折斷，氣無，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0045','麥冬','Dwarf Lilyturf Root Tuber','滋陰生津、潤肺止咳、清心除煩。主治熱病傷津、心煩、口渴、咽乾肺熱、咳嗽、肺結核','甘、微苦，涼','以飽滿、皮細、糖性足、木心細、內外淡黃白色不泛油者為佳','川麥冬塊根較短小，表面乳白色。質較堅硬，香氣小，味淡，少粘性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0046','木香','Costusroot','行氣止痛；調中導滯，溫中消食','辛、苦，溫','以條勻、質堅實、沒性足、香氣濃郁者為佳','根圓柱形、平圓柱形，長5~15cm，直徑0.5~5.5cm。表面黃棕色、灰褐色或棕褐色，栓皮大多已除去，有明縱溝及側根痕，有時可見網狀紋理。質堅硬，難折斷，斷面稍平坦，灰黃色、灰褐色或棕褐色，散有深褐色油室小點，形成層環棕色，有放射狀紋理，老根中央多枯朽。氣芳香濃烈而特異，味先甜後苦，稍刺舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0047','茜草','Indian Madder Root','涼血，止血，祛瘀，通經，鎮咳，祛痰。用於吐血，衄血，崩漏，外傷出血，經閉瘀阻，關節痹痛，跌撲腫痛。現代醫學臨床研究：可以治療出血性疾患，慢性氣管炎，慢性腹瀉，風濕性關節炎，治療軟組織損傷，治療白細胞減少症','苦，寒','以條粗、外皮紅棕色、斷面黃棕色者為佳','該品根莖呈結節狀，叢生粗細不等的根。根呈圓柱形，略彎曲，長10~25cm，直徑0.2~1cm；表面紅棕色或暗棕色，具細縱皺紋及少數細根痕；皮部脫落處呈黃紅色。質脆，易折斷，斷面平坦皮部狹，紫紅色，木部寬廣，淺黃紅色，導管孔多數。無臭，味微苦，久嚼刺舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0048','羌活','Incised Notopterygium Rhizome and Root','散表寒；祛風濕；利關節；止痛。主治外感風寒、頭痛無汗、風寒濕痹、風水浮腫、瘡瘍腫毒','辛、苦，溫','均以條粗壯、有隆起曲折環紋、斷面質緊密、朱砂點多、香氣濃郁者為佳','條羌：為乾燥的根及支根。呈圓柱形或分枝，長3~17cm，直徑約0.7~1.7cm，頂端偶可見有根莖，表面棕褐色，有縱紋及疣狀突起的鬚根痕，上端較粗大，有稀疏隆起的環節，質疏鬆而脆、易折斷，斷面不平坦，皮部淺棕色，木部黃白色，有菊花紋，朱砂點不明顯，中央無髓。氣味較淡薄')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0049','前胡','Common Hogfennel Root','宣散風熱，降氣化痰。用於治療風熱感冒、咳嗽痰多、咯痰黃稠等症','辛、苦，微寒','均以條粗壯、質柔軟、香氣濃者為佳','紫花前胡：根頭部較粗短，根少有纖維狀葉鞘殘基。折斷面皮部易與木部分離。氣芳香，味微苦、辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0050','秦艽','Largeleaf Gentian Root','袪風濕，舒筋絡，清虛熱。用於風濕痹痛，筋脈拘攣，骨節酸痛，日晡潮熱，小兒疳積發熱','辛、苦，微寒','以質堅實、棕黃色、氣味濃者為佳','小秦艽：呈類圓錐形或類圓柱形，長8~15cm，直徑0.2~1cm。表面棕黃色。主根通常1 個，殘存的莖基有纖維狀葉鞘，下部多分枝。斷面黃白色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0051','射干','Blackberrglily Rhizome','清熱解毒，利咽喉，消痰涎。主治喉痹咽痛，咳逆上氣，痰涎壅盛，瘰鬁結核，瘧母，婦女經閉，癰腫瘡毒','苦，寒','以肥壯、肉色黃、無毛須者為佳','乾燥根莖呈不規則的結節狀，長約3~10cm，直徑1~1.5cm。表面灰褐色或有黑褐色斑，皺縮有斜向或扭曲的環狀皺紋，排列甚密，上面有圓盤狀凹陷莖痕，下面有殘留的細根及根痕。質堅硬，斷面黃色，顆粒狀。氣微，味苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0052','升麻','Skunk Bugbane Rhizome','發表透疹，清熱解毒，升舉陽氣。用於風熱頭痛，齒痛，口瘡，咽喉腫痛，麻疹不透，陽毒發斑；脫肛，子宮脫垂','辛、微辛，微寒','以體輕泡、質堅、表變黑褐色且個大者為佳','呈不規則的長形塊狀，多分枝，呈結節狀，長10~20cm，直徑2~4cm。表面黑褐色或棕褐色，粗糙不平，有堅硬的細鬚根殘留，上面有數個圓形空洞的莖基痕，洞內壁顯放射狀網紋；下面凹凸不平，具鬚根痕。體輕，質堅硬，不易折斷，斷面不平坦，有裂隙，纖維性，黃綠色或淡黃白色。氣微，味微苦而澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0053','石菖蒲','Tatarinow Sweerflag Rhizome','化濕開胃，開竅豁痰，醒神益智。用於脘痞不饑，噤口下痢，神昏癲癇，健忘耳聾','辛、苦，溫','以條粗、斷面色類白、香氣濃者為佳','根莖呈扁圓柱形，稍彎曲，常有分枝，長3~20cm，直徑0.3~1cm。表面棕褐色、棕紅色或灰黃色，粗糙，多環節，節間長2~8mm；上側有略呈扁三角形的葉痕，左右交互排列，下側有圓點狀根痕，節部有時殘留有毛鱗狀葉基。質硬脆，折斷面纖維性，類白色或微紅色；橫切面內皮層環明顯，可見多數“筋脈點”及棕色油點。氣芳香，味苦、微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0054','天冬','Cochinchinese Asparagus Root Tuber','養陰清熱，潤燥生津。主治肺結核，支氣管炎，白喉，百日咳，口燥咽乾，熱病口渴，糖尿病，大便燥結；外用治瘡瘍腫毒，蛇咬傷','甘、苦，寒','以肥滿、緻密、黃白色、半透明者為佳','乾燥的塊根呈長圓紡錘形，中部肥滿，兩端漸細而鈍，長6~20cm，中部直徑0.5~2cm。表面黃白色或淺黃棕色，呈油潤半透明狀，有時有細縱紋或縱溝，偶有未除淨的黃棕色外皮。乾透者質堅硬而脆，未乾透者質柔軟，有粘性，斷面蠟質樣，黃白色，半透明，中間有不透明的細木心。臭微，味甘微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0055','天花粉','Snakegourd Root','清熱瀉火，生津止渴，排膿消腫。治熱病口渴、消渴、黃疸、肺燥咳血、癰腫、痔痿。對於治療糖尿病，常用它與滋陰藥配合使用，以達到標本兼治的作用','甘、微苦，微寒','以根肥大、白色、堅實、粉性足且橫斷面筋脈點少者為佳','該品呈不規則圓柱形、紡錘形或瓣塊狀，長8~16cm，直徑1.5~5.5cm。表面黃白色或淡棕黃色，有縱皺紋，細根痕及略凹陷的橫長皮孔，有的有黃棕色外皮殘留。質堅實，斷面白色或淡黃色，富粉性，橫切面可見黃色木質部，“筋脈點”略呈放射狀排列，縱剖面可見黃色縱條紋狀木質部。無臭，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0056','天南星','Reddish Jackinthepulpit Tuber','燥濕化痰，祛風定驚，消腫散結。主治中風半身不遂、癲癇、驚風、破傷風、跌打損傷、或蟲蟻咬傷等病症','苦、辛，溫，有毒','以個大，粉性足、色白者為佳','本品呈扁球形，高 1~2cm，直徑1.5~6.5cm 。表面類白色或淡棕色，較光滑，頂端有凹陷的莖痕，周圍有麻點狀根痕，有的塊莖周邊有小扁球狀側芽。質堅硬，不易破碎，斷面不平坦，白色，粉性。氣微辛，味麻辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0057','烏藥','Combined Spicebush Root','行氣止痛，溫腎散寒','辛，溫','以淺棕色、個大、肥壯、質嫩、香氣濃者為佳','多呈紡錘狀，略彎曲，有的中部收縮成連珠狀，長6~15cm，直徑1~3cm。表面黃棕色或黃褐色，有縱皺紋及稀疏的細根痕。質堅硬。切片厚0.2~2mm，切面黃白色或淡黃棕色，射線放射狀，可見年輪環紋，中心顏色較深。氣香，味微苦、辛，有清涼感')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0058','香附','Nutgrass Galingale Rhizome','理氣解鬱，調經止痛。用於肝鬱氣滯，胸、脅、脘腹脹痛，消化不良，月經不調，經閉痛經，寒疝腹痛，乳房脹痛','辛、微苦、微甘，平','以個大、堅實、氣香、毛須去淨者為佳','根莖多呈紡錘形，或略彎曲，長2~3.5cm，直徑0.5~1cm。表面棕褐色或黑褐色，有不規則縱皺紋，並有明顯而略隆重起的環節 6~10個，節間長2~6mm，節上有眾多朝向一方的棕色毛須，並殘留根痕；去淨毛須的較光滑，有細密的縱脊紋。質堅硬，蒸煮者斷面角質樣，棕黃色或棕紅色，生曬者斷麵粉性，類白色；內皮層環明顯，中柱色較深，維管束點清晰可見。氣芳香特異，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0059','薤白','Longstamen Onion Bulb','胸痹心痛徹背；胸脘痞悶；咳喘痰多；脘腹疼痛；泄痢後重；白帶；瘡癤癰腫；通陽散結，行氣導滯','辛、苦，溫','均以個大、飽滿、質堅、黃白色、半透明者為佳','天藍小根蒜：鱗莖近球形，直徑1~2cm')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0060','細辛','Manchurian Wildginger Herb','解表散寒；祛風止痛；溫肺化飲；通竅。主治風寒表證；頭痛，牙痛；風濕痹痛；痰飲咳喘；鼻塞；鼻淵；口瘡','辛，溫','均以根灰黃、葉綠、乾燥、味辛辣而麻舌者為佳','漢城細辛：根莖長1~10cm，直徑0.1~0.5cm，節間長約0.1~1cm，氣味同北細辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0061','西洋參','American Ginseng','補氣養陰，清熱生津。用於氣虛陰虧，內熱，咳喘痰血，虛熱煩倦，消渴，口燥咽乾。西洋參有抗疲勞、抗氧化、抗應激、抑制血小板聚集、降低血液凝固性的作用，另外，對糖尿病患者還有調節血糖的作用','甘、微苦，微寒','以條均勻、質硬、表面橫紋緊密、氣濃清香者為佳','本品呈紡錘形、圓柱形或圓錐形，長3~12cm，直徑0.8~2cm。表面淺黃褐色或黃白色，可見橫向環紋及線狀皮孔，並有細密淺縱皺紋及鬚根痕。主根中下部有一至數條側根；多已折斷。有的上端有根莖 (蘆頭)，環節明顯，莖痕 (蘆碗) 圓形或半圓形具不定根疔或已折斷。體重，質堅實，不易折斷，斷面平坦，淺黃白色，略顯粉性，皮部可見黃棕色點狀樹脂道，形成層環紋棕黃色，本部略呈放射狀紋理。氣微而特異，味微苦、甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0062','玄參','Figwort Root','清熱涼血，瀉火解毒，滋陰。用於溫邪入營，內陷心包，溫毒發斑，熱病傷陰、舌絳煩渴、津傷便秘、骨蒸勞嗽、目赤、咽痛、瘰鬁、白喉、癰腫瘡毒','甘、苦、鹹，微寒','以條粗壯、堅實、斷面烏黑者為佳','根類圓柱形，中間略粗或上粗下細，有的微彎曲，長6~20cm，直徑1~3cm。表面灰黃色或灰褐色，有不規則的縱溝、橫向皮孔及稀疏的橫裂紋和鬚根痕。質堅實，不易折斷，斷面黑色，微有光澤。氣特異似焦糖，味甘、微苦、鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0063','延胡索','Yanhusuo Tuber','活血散瘀，行氣止痛。主治胸痹心痛，脅肋、脘腹諸痛，頭痛、腰痛、疝氣痛、筋骨痛、痛經、經閉，產後瘀腹痛，跌打損傷','辛、苦，溫','以個大、飽滿、質堅、色黃、內色黃亮者為佳','乾燥塊莖，呈不規則扁球形，直徑1~2cm，表面黃色或褐黃色，頂端中間有略凹陷的莖痕，底部或有疙瘩狀凸起。質堅硬而脆，斷面黃色，角質，有蠟樣光澤。無臭，味苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0064','銀柴胡','Lanceolate Dichotomous Starwort Root','清熱涼血。治虛勞骨蒸，陰虛久瘧，小兒瘠熱羸瘦','甘，微寒','以根長均勻、頂端具“珍珠盤”、外皮淡黃色、斷面黃白色者為佳','呈類圓柱形，偶有分枝，長15~40cm，直徑0.5~2.5cm。表面淺棕黃色至淺棕色，有扭曲的縱皺紋及支根痕，多具孔穴狀或盤狀凹陷，從砂眼處折斷可見棕色裂隙中有細砂散出，根頭部略膨大，有密集的呈疣狀突起的芽苞、莖或根莖的殘基。質硬而脆，易折斷，斷面不平坦，較疏鬆，有裂隙，皮部甚薄，木部有黃、白色相間的放射狀紋理。氣微，味甘。栽培品有分枝，下部多扭曲，直徑0.3~1.2cm。表面淺棕黃色或淺黃棕色，縱皺紋細膩明顯，細支根痕多呈點狀凹陷。根頭部有多數疣狀突起。幾無砂眼。折斷面質地較緊密，幾無裂隙，略顯粉性，木部放射狀紋理不甚明顯。味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0065','遠志','Thinleaf Milkwort Willd.','安神益智，祛痰，消腫。用於心腎不交引起的失眠多夢，健忘驚悸，神志恍惚，咳痰不爽，瘡瘍腫毒，乳房腫痛','苦、辛，微溫','以皮厚、條粗者為佳','該品呈圓柱形，略彎曲，長3~15cm，直徑0.3~0.8cm。表面灰黃色至灰棕色，有較密並深陷的橫皺紋、縱皺紋及裂紋，老根的橫皺紋較密更深陷，略呈結節狀。質硬而脆，易折斷，斷面皮部棕黃色，木部黃白色，皮部易與木部剝離。氣微，味苦、微辛，嚼之有刺喉感')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0066','玉竹','Fragrant Solomonseal Rhizome','滋陰潤肺；養胃生津。燥咳；勞嗽；熱病陰液耗傷之咽乾口渴；內熱消渴；陰虛外感；頭昏眩暈；筋脈攣痛','甘，平','以肥壯、條長、色黃白光潤、半透明、味甜者為佳','該品呈長圓柱形，略扁，少有分枝，長4~18cm，直徑0.3~1.6cm。表面黃白色或淡黃棕色，半透明，具縱皺紋及微隆起的環節，有白色圓點狀的鬚根痕和圓盤狀莖痕。質硬而脆或稍軟，易折斷，斷面角質樣或顯顆粒性。氣微，味甘，嚼之發黏')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0067','澤瀉','Oriental Waterplantain Tuber','利水滲濕；泄熱通淋。主小便不利；熱淋澀痛；水腫脹滿；泄瀉；痰飲眩暈；遺精','甘、淡，寒','以塊大、黃白色、光滑、質充實、粉性足者為佳','塊莖類球形、橢圓形或卵圓形、長2~7cm，直徑2~6cm。表面黃白色或淡黃棕色，有不規則的橫向環狀淺溝紋及多數細小突起的鬚根痕，底部有的有瘤狀芽痕。質堅實，斷面黃白色，粉性，有多數細孔。氣微，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0068','知母','Common Anemarrhena','清熱瀉火，生津潤燥。用治外感熱病，高熱煩渴，內治肺熱咳嗽，胃熱消渴，肺燥咳嗽；腸燥便秘；骨蒸潮熱','苦、甘，寒','均以質硬、條肥大、斷面黃白色者為佳','該品呈長條狀，微彎曲，略扁，偶有分枝，長3~15cm，直徑0.8~1.5cm，一端有淺黃色的莖葉殘痕。表面黃棕色至棕色，上面有一凹溝，具緊密排列的環狀節，節上密生黃棕色的殘存葉基，由兩側向根莖上方生長；下面隆起而略皺縮，並有凹陷或突起的點狀根痕。質硬，易折斷，斷面黃白色。氣微，味微甜、略苦，嚼之帶粘性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0069','紫菀','Tatarian Aster Root and Rhizome','潤肺下氣，消痰止咳。用於痰多喘咳、新久咳嗽、勞嗽咳血','辛、苦，溫','以根長、紫紅色、無雜質、質柔韌者為佳','根莖不規則塊狀，大小不一，頂端有莖、葉的殘基，下端偶有末除盡的母根，質梢硬。根莖簇生多數細根，長3~15cm，直徑0.1~0.3cm，多編成辮狀；表面紫紅色或灰紅色，有縱皺紋；質較柔韌。氣微香，味甜、微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0070','甘草','Liquorice Root','益氣補中，清熱解毒，祛痰止咳，緩急止痛，調和藥性','甘，平','以皮細緊、色紅棕、質堅實、斷面色黃白、粉性足者為佳','圓柱形，外皮鬆緊不一。表面紅棕色或灰棕色，具顯著的縱皺紋、溝紋、皮孔及稀疏的細根痕。質堅實，斷面略顯纖維性，黃白色，粉性。根莖表面有芽痕，斷面中部有髓。氣微，味甜而特殊。飲片為斜切片')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0071','半夏','Ternate Pinellia','燥濕化痰，降逆止嘔，消痞散結。用於濕痰寒痰，咳喘痰多，痰飲 眩悸，風痰眩暈，痰厥頭痛.嘔吐反胃.胸院痞悶，梅核氣；外治痛腫痰核','辛、溫，有毒','以個大、皮淨、色白、質堅實、粉性足者為佳','本品呈類球形，有的稍偏斜，表面白色或淺黃色，頂端有凹陷的莖痕，周圍密佈麻點狀根痕；下面鈍圓，較光滑。質堅實、斷面潔白，富粉性。氣微，味辛辣、麻舌而刺喉')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0072','鉤藤','Sharpleaf Uncaria Stem with Hools','清熱平肝；熄風止痙。小兒驚風；夜啼；熱盛動風；子癇；肝陽眩暈；肝火頭脹痛','甘，涼','以莖細、帶雙鉤、鉤結實、光滑、紫紅色者為佳','莖枝圓柱形或類方柱形，直徑2~6mm。表面紅棕色至紫棕色或棕褐色，上有細縱紋，無毛。莖上具略突起的環節，對生兩個向下彎曲的鉤或僅一側有鉤，鉤長1~2cm，形如船鋪，先端漸尖，基部稍圓。鉤基部的枝上可見葉柄脫落後凹點及環狀的托葉痕。體輕，質硬。橫截面外層棕紅色，髓部淡棕色或淡黃色。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0073','桂枝','Cassiabarktree Twig','發汗解肌，溫通經脈，助陽化氣，平沖降氣。用於風寒感冒，脘腹冷痛，血寒經閉，關節痹痛，痰飲，水腫，心悸，奔豚','辛、甘，溫','以枝條細嫩均勻、棕黃色、氣香濃者為佳','呈長圓柱形，多分枝，長30~75cm，粗端直徑0.3~1cm。表面紅棕色至棕色，有縱棱線、細皺紋及小疙瘩狀的葉痕、枝痕、芽痕，皮孔點狀。質硬而脆，易折斷。切片厚2~4mm，斷面皮部紅棕色，木部黃白色至淺黃棕色，髓部略呈方形。有特異香氣，味甜、微辛，皮部味較濃')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0074','木通','Akabia Stem','清熱利尿；活血通脈。主小便赤赤；淋濁；水腫；胸中煩熱；喉喉疼痛；口舌生瘡；風濕痹痛；乳汁不通；經閉；痛經','苦，微寒','以條粗、均勻者為佳','白木通藤莖直徑5~8mm。表面黃棕色或暗棕色，有不規則縱溝紋；有枝痕。質堅韌，難折斷，斷面木部淡黃色，導管細密，排列不規則，射線約13條，淺黃色放射狀，髓類圓形。氣微，味徽苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0075','桑寄生','Chinese Taxillus Herb','祛風濕，益肝腎，強筋骨，安胎','苦、甘，平','以紅褐色、枝細嫩、葉多者為佳','莖枝呈圓柱形，長3~4cm，直徑0.2~1cm；表面紅褐色或灰色，具細縱紋，並有眾多細小皮孔，小枝有棕紅色細毛。有時逞葉，多捲縮，完整者呈卵圓形，全緣，棕色，革質，幼葉亦被棕紅色細毛。莖堅硬，斷面不整齊，皮部紅棕色，木櫚色較淺。無臭，味澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0076','通草','Rice Paper Plant Pith','清熱利濕；通乳，用於淋症澀痛；小便不利；水腫；黃疸；濕溫病；小便短赤；產後乳少；經閉；帶下','甘、淡，微寒','以條粗壯、色潔白、有彈性、空心有隔膜者為佳','莖賄呈圓柱形，長20~40cm，直徑1~2.5cm。表面白色或淡黃色，有淺縱溝紋。體輕，質鬆軟，稍有彈性，易折斷，斷面平坦，顯銀白色光澤，中內有直徑0.3~1.5cm的空心或半透明的薄膜，縱剖面呈梯狀排列，實心者 (僅在細小莖賄中的某小段) 少見。無臭，無味')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0077','竹茹','Bamboo Shavings','清熱化痰，除煩止嘔。用於痰熱咳嗽、膽火挾痰、煩熱嘔吐、驚悸失眠、中風痰迷、舌強不語、胃熱嘔吐、妊娠惡阻、胎動不安','甘，微寒','以身乾、黃綠色、細絲均勻、質柔軟者為佳','本品呈不規則的絲狀或薄帶狀，常捲曲扭縮而纏結成團或作創花狀，長短不一，寬0.5~0.7cm，厚0.3~0.5cm。全體淡黃白色、淺綠色、青黃色、灰黃色、灰黃綠色、黃而韌，有彈性。氣稍清香，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0078','皂角刺','Chinese Honeylocust Spine','消腫托毒，排膿，殺蟲。用於痛疽初起或膿成不潰；外治疥癬麻風','辛，溫','以片薄、純淨、無核梗、色棕紫、切片中間棕紅色、慷心者為佳','本品為主刺及1~2次分枝的棘刺。主刺長3~15cm或更長，直徑0.3~1cm；分枝刺長1~6cm，刺端銳尖。表面紫棕色或棕褐色。體輕，質堅硬，不易折斷。切片厚0.1~0.3cm，常帶有尖細的刺端；木部黃白色，髓部疏鬆，淡紅棕色；質脆，易折斷。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0079','白扁豆','White Hyacinth Bean','補脾和中，化濕消暑。用於脾胃虛弱、食欲不振、大便溏瀉、白帶過多、暑濕吐瀉、胸悶腹脹','甘，微溫','以粒大、飽滿、色白者為佳','種子扁橢圓形或扁卵圓形，長0.8~1.3cm，寬6~9mm，厚約7mm。表面淡黃白色或淡黃色，平滑，稍有光澤，有的可見棕褐色斑點，一側邊緣有隆起的白色半月形種阜。長7~10mm，剝去後可見凹陷的種臍，緊接種阜的一端有珠孔，另端有種脊。質堅硬，種皮薄而脆，子葉2片，肥厚，黃白色。氣微，味淡，嚼之有豆腥氣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0080','白果','Ginkgo Seed','斂肺定喘；止帶縮尿。哮喘痰嗽；白帶；白濁；遺精；尿頻；無名腫毒； 皶鼻','甘、苦、澀，平，有小毒','以殼色黃白、種仁飽滿，斷面色淡黃者為佳','除去外種皮的種子卵形或橢圓形，長1.5~3cm，寬1~2.2cm。外殼 (中種皮) 骨質，光滑，表面黃白色或淡棕黃色，基部有一圓點狀突起，邊緣各有1條棱線，偶見3條棱線。內種皮膜質，紅褐色或淡黃棕色。種仁扁球形，淡黃色，胚乳肥厚，粉質，中間有空隙；胚極小。氣無，味微甘、苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0081','柏子仁','Chinese Arborvilae Seed','養心安神，潤腸通便。用於虛煩不眠，心悸怔忡，腸燥便秘等症','甘，平','以粒大，飽滿、油性大而不泛油、無皮殼雜質、黃白色者為佳','長卵形或長橢圓形，長0.3~0.7cm，直徑0.1~0.3cm。新貨黃白色或淡黃色，久置陳貨則呈黃棕色，並有油點滲出。種仁外面常包有薄膜質的種皮，頂端略尖，圓三棱形，基部鈍圓。質軟油潤，斷面黃白色，胚乳較多，子葉2枚，均含豐富的油質。氣微香，味淡而有油膩感')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0082','蓽茇','Long Pepper Fruit','溫中散寒，下氣止痛。用於脘腹冷痛、嘔吐、泄瀉、偏頭痛、鼻淵、外治牙痛、冠心病、心絞痛。治心腹冷痛，嘔吐吞酸，腸鳴泄瀉，冷痢，陰疝，頭痛，鼻淵，齒痛','辛，熱','以飽滿肥大、堅實、黑褐色、斷面稍紅、氣味濃者為佳','呈圓柱形，稍彎曲，由多數小漿果集合而成，長1.5~3.5cm，直徑0.3~0.5cm。表面黑褐色或棕色，有斜向排列整齊的小突起，基部有果穗梗殘存或脫落。質硬而脆，易折斷，斷面不整齊，顆粒狀。小漿果球形，直徑約0.1cm，斷面顆粒狀。有特異香氣，味辛辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0083','檳榔','Betelnutpalm Seed','驅蟲；消積；下氣；行水；截瘧。蟲積；食滯；脘腹脹痛；瀉痢後重；腳氣；水腫；瘧疾','苦、辛，溫','以果大體重、堅實、不破裂者為佳','乾燥種子呈圓錐形或扁圓球形，高1.5~3cm，基部直徑2~3cm，表面淡黃棕色或黃棕色，粗糙，有顏色較淺的網形凹紋，並偶有銀色斑片狀的內果皮附著。基部中央有圓形凹陷的珠孔，其旁有淡色的疤痕狀的種臍。質堅實，縱剖面可見外緣的棕色種皮向內褶入，與乳白色的胚乳交錯，形成大理石樣花紋。基部珠孔內側有小形的胚，常呈棕色，乾枯皺縮不顯。氣無，味澀而微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0084','補骨脂','Malaytea Scurfpea Fruit','補腎助陽；納氣平喘；溫脾止瀉。主腎陽不足；下元虛冷；腰膝冷痛；陽痿遺精；尿頻；遺尿；腎不納氣；虛喘不止；脾腎兩虛；大便久瀉；白癜風；斑禿；銀屑病','辛、苦，溫','以粒大、飽滿、黑色者為佳','果實扁圓狀腎形，一端略尖，少有宿萼。懷補骨脂長4~5.5mm，寬約2~4mm，厚約1mm；川補骨脂較小。表面黑棕色或棕褐色，具微細網紋，在放大鏡下可見點狀凹。質較硬脆，剖開後可見果皮與外種皮緊密貼生，種子凹側的上端略下處可見點狀種臍，另一端有合點，種脊不明顯。外種皮較硬，內種皮膜質，灰白色；子葉2枚，肥厚，淡黃色至淡黃棕色，陳舊者色深，其內外表面常可見白色物質，於放大鏡下觀察為細小針晶；胚很小。宿萼基部連合，上端5裂，灰黃色，具毛茸，並密佈褐色腺點。氣芳香特異、味苦微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0085','草豆蔻','Katsumada Galangal Seed','化濕消痞，行氣溫中，開胃消食。用於濕濁中阻，不思飲食，濕溫初起胸悶不饑，寒濕嘔逆，胸腹脹痛，食積不消','辛，溫','以種子飽滿、堅實、類球形、氣濃者為佳','該品為類球形的種子團，直徑1.5~2.7cm。表面灰褐色，中間有黃白色的隔膜，將種子團分成3 瓣，每瓣有種子多數，粘連緊密，種子團略光滑。種子為卵圓狀多面體，長3~5mm，直徑約3mm，外被淡棕色膜質假種皮，種脊為一條縱溝，一端有種臍；質硬，將種子沿種脊縱剖兩瓣，縱斷面觀呈斜心形，種皮沿種脊向內伸入部分約占整個表面積的1/2 ；胚乳灰白色。氣香，味辛，微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0086','草果','Tsaoko Amomum Fruit','燥濕除寒，祛痰截瘧，消食化食。主治瘧疾，痰飲痞滿，脘腹冷痛，反胃，嘔吐，瀉痢，食積','辛，溫','以個大、飽滿、色紅棕、氣味濃行為佳','果實橢圓形，長2~4.5cm，直徑1~2.5cm，表面棕色或紅棕色，具3鈍棱及明顯的縱溝及棱線，先端有圓形突起的柱基，基部有果柄或果柄痕，果皮堅韌，內分3室，每室含種子7~24粒，種子集結成團。種子多面形，直徑5~7mm，黃棕色或紅棕色，具灰白色膜質假種皮，中央有凹陷合點，較狹端腹面有圓窩狀種臍，種脊凹陷成1縱溝。氣芳香，味辛、辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0087','陳皮','Tangerine Peel','理氣健脾，燥濕化痰。用於胸脘脹滿，食少吐瀉，咳嗽痰多','苦、辛，溫','以皮張大、完整、色鮮豔油潤、香氣濃者佳','常剝成數瓣，基部相連，有的呈不規則的片狀，厚1~4mm。外表面橙紅色或紅棕色，有細皺紋及凹下的點狀油室；內表面淺黃白色，粗糙，附黃白色或黃棕色筋絡狀維管束。質稍硬而脆。氣香，味辛、苦。廣陳皮：常3瓣相連，形狀整齊，厚度均勻，約1mm。點狀油室較大，對光照視，透明清晰。質較柔軟')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0088','車前子','Asiatic Plantain Seed','清熱利尿；滲濕止瀉；明目；祛痰。主小便不利；淋濁帶下；水腫脹滿；暑濕瀉痢；目赤障翳；痰熱咳喘','甘、淡，微寒','以粒大、均勻飽滿、色棕紅者為佳','種子略呈橢圓形或不規則長圓形，稍扁，長約2mm，寬約1mm。表面淡棕色或棕色，略粗糙不平。於擴大鏡下可見微細縱紋，于稍平一面的中部有淡黃色凹點狀種臍。質硬，切段面灰白色。種子放入水中，外皮有粘液釋出。氣微，嚼之帶粘液性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0089','赤小豆','Rice Bean','利水除濕，和血排膿，消腫解毒。治水腫，腳氣，黃疸，瀉痢，便血，癰腫','甘、酸，平','以身乾，顆粒飽滿，色赤紅發暗者為佳','乾燥種子略呈圓柱形而稍扁，長5~7mm，直徑約3mm，種皮赤褐色或紫褐色，平滑，微有光澤，種臍線形，白色，約為全長的2/3，中間凹陷成一縱溝，偏向一端，背面有一條不明顯的棱脊。質堅硬，不易破碎，除去種皮，可見兩瓣乳白色於仁。氣微，嚼之有豆腥味')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0090','大腹皮','Areca Peel','下氣寬中，行水消腫之功效。現代研究，該品有興奮胃腸道平滑肌、促胃腸動力作用，並有促進纖維蛋白溶解等作用','辛，微溫','以色黃白、質柔韌、無雜質者為佳','略呈橢圓形或長卵形瓢狀，長4~7cm，寬2~3.5cm，厚0.2~0.5cm。 外果皮深棕色至近黑色，具不規則的縱皺紋及隆起的橫紋，頂端有花柱殘痕，基部有果梗及殘存萼片。內果皮凹陷，褐色或深棕色、光滑呈硬殼狀。體輕，質硬，縱向撕裂後可見中果皮纖維。氣微，味微澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0091','淡豆豉','Fermented Soybean','解肌發表；宣鬱除煩。主治外感表證；寒熱頭痛；心煩；胸悶；虛煩不眠','辛、甘、微苦，寒','以柔軟、無糟粒、香氣濃郁者為佳','該品呈橢圓形，略扁，長0.6~1cm，直徑0.5~0.7cm。表面黑色，皺縮不平。質柔軟，斷面棕黑色。具有膜狀種皮，氣香，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0092','大棗','Common Jujube','補中益氣，養血安神。用於脾虛食少，乏力便溏，婦人臟躁','甘，溫','以個大、色紅、肉質油潤者為佳','本品呈橢圓形或球形，長2~3.5cm，直徑1.5~2.5cm。表面暗紅色，略帶光澤，有不規則皺紋。基部凹陷，有短果梗。外果皮薄，中果皮棕黃色或淡褐色，肉質，柔軟，富糖性而油潤。果核紡錘形，兩端銳尖，質堅硬。氣微香，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0093','瓜蔞','Mongolian Snakegourd Fruit','潤肺，化痰，散結，潤腸。治痰熱咳嗽，胸痹，結胸，肺痿咳血，消渴，黃疸，便秘，癰腫初起','甘、苦，寒','以顆粒飽滿、淡黃白色、整齊不碎、不出油、無核殼者為佳','果實呈卵狀扁平橢圓形，長11~16mm，寬6~12mm，厚2~3.5mm。表面淺棕色至棕褐色，平滑，邊緣有一圈溝紋，頂端尖有種臍，基部鈍圓或較狹。種皮堅硬，剖開後可見內種皮膜質，色灰白至灰綠色，含兩片黃白色子葉，富油性。瓜蔞子內種皮白色，外種皮棕褐色，子夜2')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0094','訶子','Medicine Terminalia','斂肺；澀腸；下氣；利咽，清涼解毒。主治久瀉；久痢；脫肛；喘咳痰嗽；久咳失音','苦、酸、澀，平','以棕黃色、個大、微皺而有光澤者為佳','果實呈卵形或橢圓形，長2.4cm，直徑2~2.5cm。表面棕褐色，略具光澤，有5~6條縱菱形及不規則的皺紋，在縱棱線之間有1~2條明顯或不明顯的縱凸起，可見細密橫向紋理，基部有圓形果柄痕。質堅實，剖開後，果肉厚2~4mm，黃棕色或黃褐色。果核長l.5~2.5cm，淺黃色，粗糙，堅硬、種子一粒，狹長紡錘形，長約1cm，直徑2~4mm，膜質種皮黃棕色，子葉2，白色，相互重疊卷旋。無臭，味酸澀而後甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0095','萊菔子','Garden Radish Seed','消食除脹，降氣化痰。用於飲食停滯、脘腹脹痛、大便秘結、積滯瀉痢、痰壅喘咳。','辛、甘，平','以飽滿粒大、堅實、紅棕色者為佳','種子類卵圓形或橢圓形，稍扁，長2.5~4mm，寬2~3mm。表面黃棕色、紅棕色或灰棕色，一端有深棕色圓形種臍，一側有數條縱溝。種皮薄而脆，子葉2，黃白色，有油性。味淡、微苦、辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0096','連翹','Weeping Forsythia Fruit','清熱解毒，消腫散結，疏散風熱，有“瘡家聖藥”之稱。治溫熱，丹毒，斑疹，癰瘍腫毒，瘰鬁，小便淋閉，清心火','苦、微寒','青翹以色綠、不開裂者為佳','青翹：呈狹卵形至卵形，兩端狹尖，多不開裂。表面青綠色，綠褐色，有兩條縱溝和凸起小斑點，內有縱隔。質堅硬。氣芳香，味苦。間有殘留果柄')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0097','龍眼肉','Dried Longan Pulp','補益心脾，養血安神。用於氣血不足、心悸怔忡、健忘失眠、血虛萎黃','甘，溫','以片大、肉厚、質細軟、棕黃色者為佳','為縱向破裂的不規則薄片，常數片粘結。長約1.5cm，寬2~4cm，厚約0.1cm。棕褐色，半透明，外表面皺縮不平，內面光亮而有細縱皺紋。質柔潤。氣微香，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0098','麥芽','Barley Sprout','行氣消食，健脾開胃，退乳消脹。用於食積不消，脘腹脹痛，脾虛食少，乳汗鬱積，乳房脹痛，婦女斷乳，生麥芽健脾和胃通乳。用於脾虛食少，乳汗鬱積','甘，平','以淡黃色、胚芽完整者為佳','本品呈梭形，長8~12mm，直徑3~4mm。表面淡黃色，背面為外稃包圍，具5脈，先端長芒已斷落；腹面為內稃包圍。除去內外稃後，腹面有1條縱溝；基部胚根處生出幼芽及鬚根，幼芽長披針狀條形，長約0.5cm。鬚根數條，纖細而彎曲。質硬，斷面白色，粉性。無臭，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0099','蔓荊子','Sinplelaef Shrub Chastetree Fruit','疏散風熱，清利頭目。用於風熱感冒頭痛，齒齦腫痛，目赤多淚，目暗不明，頭暈目眩','辛、苦，微寒','以粒大飽滿、氣味濃者為佳','本品呈球形，直徑4~6mm。表面灰黑色或黑褐色，被灰白色粉霜狀茸毛，有縱向淺溝4條，頂端微凹，基部有灰白色宿萼及短果梗。萼長為果實的1/3~2/3，5齒裂，其中 2裂較深，密被茸毛。體輕，質堅韌，不易破碎。橫切面可見4室，每室有種子1枚。氣特異而芳香，味淡、微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0100','木瓜','Common Floweringquine Fruit','平肝舒筋，和胃化濕。用於濕痹拘攣，腰膝關節酸重疼痛，吐瀉轉筋，腳氣水腫','酸，溫','以外皮皺縮、肉厚、堅實、內外紫紅色味酸者為佳','本品為為長圓形，多縱剖為兩半。外表面紫紅色或者紅褐色，有不規則的深皺紋。剖面邊緣向內捲曲，果肉紅棕色，中心部分向下凹陷，為棕黃色。種子為扁長的三角形。飲片為條狀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0101','青皮','Immature Tangerine Fruit','疏肝破氣、消積化滯。用於胸肋脘脹痛，乳癰、疝痛，食積氣滯','苦、辛，溫','個青皮以個勻、外皮黑綠色、質硬、體重、肉厚、瓤小、香氣濃者為佳','個青皮：呈類球形，直徑0.5~2cm。表面灰綠色或黑綠色，微粗糙，有細密凹下的油室，頂端有稍突起的柱基，基部有圓形果梗痕。質硬，斷面果皮黃白色或淡黃棕色，厚0.1~0.2cm，外緣有油室1~2列。瓤囊8~10 瓣，淡棕色。氣清香，味酸、苦、辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0102','肉豆蔻','Nutmeg','溫中澀腸；行氣消食。用於虛瀉；冷痢；脘腹脹痛；食少嘔吐；宿食不消','辛、苦，溫','以個大、表面具紫褐色光澤、仁飽滿、色白者為佳','該品呈卵圓形或橢圓形，長2~3cm，直徑1.5~2.5cm。表面灰棕色或灰黃色，有時外被白粉 (石灰粉末) 。全體有淺色縱行溝紋及不規則網狀溝紋。種臍位於寬端，呈淺色圓形突起，合點呈暗凹陷。種脊呈縱溝狀，連接兩端。質堅，斷面顯棕黃色相雜的大理石花紋，寬端可見乾燥皺縮的胚，富油性。氣香濃烈，味辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0103','山楂','Chinese Hawthorn Fruit','開胃消食、化滯消積、活血散瘀、化痰行氣。用於肉食滯積、症瘕積聚、腹脹痞滿、瘀阻腹痛、痰飲、泄瀉、腸風下血等','甘、酸，微溫','以果大、肉厚、核少、皮紅者為佳','果實較小，類球形，直徑0.8~1.4cm，有的壓成餅狀。表面棕色至棕紅色，並有細密皺紋，頂端凹陷，有花萼殘跡，基部有果梗或已脫落')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0104','絲瓜絡','Loofah, Towel Gourd Vegetable Sponge','通絡，活血，祛風。用於痹痛拘攣、胸脅脹痛、乳汁不通','甘，平','以個大長條、去除外皮、網狀維管束黃白色者為佳','藥材為絲狀維管束交織而成，多呈長棱形或長圓筒形，略彎曲，長30~70cm，直徑7~10cm。表面淡黃白色。體輕，質韌，有彈性，不能折斷。橫切面可見子房3室，呈空洞狀。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0105','桃仁','Peach Seed','活血祛瘀，潤腸通便，止咳平喘。用於經閉，痛經，癓瘕痞塊，跌撲損傷，腸燥便秘','苦、甘，平','以顆粒均勻、紅棕色、飽滿者為佳','種子扁卵形或橢圓形，一端尖，另端鈍圓而偏斜，邊緣較薄，長1.2~2cm，寬1~1.2cm，厚3~5mm。表面黃棕色或紅棕色，有縱脈紋及密佈細粒狀突起，近尖端側邊有長4~6mm的線形種臍。種皮薄，子葉兩片肥大，黃白色，富油質。味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0106','葶藶子','Pepperweed Seed','瀉肺降氣；祛痰平喘；利水消腫；泄逐邪。主治痰涎壅肺之喘咳痰多；肺癰；水腫；胸腹積水；小便不利；慢性肺源性心臟病；心力衰竭之喘腫；瘰鬁結核','辛、苦，大寒','以子粒充實、均勻、紅棕色者為佳','北葶藶子：種子扁卵形，長1~1.5-mm，寬0.5~1mm。表面黃棕色或紅棕色，微有光澤，具多數細微顆粒狀突起，並可見2條縱列的淺槽，其中一條較明顯，一端鈍圓，另端漸尖而微凹，種臍位於凹下處，但不明顯。無臭，味微苦辛，粘性較強')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0107','菟絲子','Chinese Dodder Seed','補腎益精、養肝明目、固胎止泄','甘，溫','以粒飽滿者為佳','菟絲子種子類圓形，腹棱線明顯，兩側常凹陷，長徑1.4~1.6mm，短徑0.9~1.1mm。表面灰棕色或黃棕色，因具有細密突起的小點兒微粗糙，種皮堅硬，不易破碎，除去種皮可中央為卷旋3周的胚，胚乳膜質套狀，位於胚周圍，氣微，味微苦、澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0108','五味子','Chinese Magnoliavine Fruit','收斂固澀，益氣生津，補腎寧心。用於久嗽虛喘，夢遺滑精，遺尿尿頻，久瀉不止，自汗，盜汗，津傷口渴，短氣脈虛，內熱消渴，心悸失眠','酸、甘，溫','以紫紅色、粒大、肉厚、有油性及光澤者為佳','乾燥果實略呈球形或扁球形，直徑5~8mm。外皮鮮紅色，紫紅色或暗紅色。顯油潤，有不整齊的皺縮。果肉柔軟，常數個粘連一起；內含種子1~2枚，腎形，棕黃色，有光澤，堅硬，種仁白色。果肉氣微弱而特殊，味酸。種子破碎後有香氣，味辛而苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0109','吳茱萸','Medicinal Evodia Immature Fruit','散寒止痛、降逆止嘔。用於治療肝胃虛寒、陰濁上逆所致的頭痛或胃脘疼痛等症','辛、苦，熱，有小毒','以綠色、粒小、飽滿堅實、香氣濃者為佳','果實呈五角狀扁球形，直徑2~5mm。表面暗黃綠色至褐色，粗糙，有點狀突起或凹下的油點。頂端有五角星狀的裂隙，基部殘留被有黃色茸毛的果梗。質硬而脆。氣芳香濃郁，味辛辣而苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0110','小茴香','Fennel Fruit','開胃進食，理氣散寒，有助陽道。主治：中焦有寒，食欲減退，噁心嘔吐，腹部冷痛；疝氣疼痛，睾丸腫痛；脾胃氣滯，脘腹脹滿作痛','辛，溫','以粒大飽滿、黃綠色、香氣濃者為佳','果實為雙懸果，呈圓柱形，有的稍彎曲，兩端略尖，長4~8mm，直徑1.5~2.5mm。表面黃綠或淡黃色，頂端殘留有黃棕色突起的柱基，基部有時有細小的果梗。分果呈長橢圓形，背面有縱棱5條，接合面平坦而較寬。橫切面略呈5邊形，背面的4邊約等長。有特異茴香氣，味微甜、辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0111','罌粟殼','Opium Poppy Peel','斂肺、澀腸、止痛。用於久咳、久瀉，脫肛，脘腹疼痛','酸、澀，平，有毒','以完整、豐滿者為佳','呈橢圓形或瓶狀卵形，多已破碎成片狀，直徑1.5~5cm，長3~7cm外表面黃白色、淺棕色至淡紫色，平滑，略有光澤，有縱向或橫向的割痕。頂端有 6~14條放射狀排列呈圓盤狀的殘留柱頭；基部有短柄。體輕，質脆。內表面淡黃色，微有光澤。有縱向排列的假隔膜，棕黃色，上面密佈略突起的棕褐色小點。氣微清香，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0112','薏苡仁','Ma - yuen Jobstears Seed','健脾滲濕，除痹止瀉。薏米可用於治療水腫、腳氣、小便不利、濕痹拘攣、脾虛泄瀉','甘、淡，微寒','以粒大充實、色白、無皮碎者為佳','種仁寬卵形或長橢圓形，長4~8mm，寬3~6mm。表面乳白色，光滑，偶有殘存的黃褐色種皮。一端鈍圓，另端較寬而微凹，有1淡棕色點狀種臍。背面圓凸，腹面有1條羅寬而深的縱溝。質堅實，斷面白色粉性。氣微，味微甜。以粒大充實、色白、無皮碎者為佳')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0113','枳殼','Submature Bitter Orange','理氣寬中，行滯消脹','辛、苦、酸，溫','以外果皮色綠褐、果肉厚、質堅硬、香氣濃者為佳','果實呈半球形，直徑3~5.5cm。外皮綠褐色或棕褐色，略粗糙，散有眾多小油點，中央有明顯的花柱基痕或圓形果柄痕。切面中果皮厚0.6~1.2cm，黃白色較光滑，略向外翻，有維管束散佈，邊緣有棕黃色油點l~2列。質堅硬，不易折斷，瓤囊7~12瓣，少數至15瓣，囊內汁胞幹縮，棕黃色或暗棕色，質軟，內藏種子。中軸堅實，寬5~9mm，黃白色，有一圈斷續環列的維管束點。氣香，味苦、微酸')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0114','枳實','Immature Bitter Orange','破氣消積，化痰散痞。用於積滯內停；痞滿脹痛；大便秘結；瀉痢後重；結胸；胃下垂；子宮脫垂；脫肛','苦、辛、酸，溫','以皮青黑、果肉厚色白、囊小、堅實者為佳','該品呈半球形，少數為球形，直徑0.5~2.5cm。外果皮黑綠色或暗棕綠色，具顆粒狀突起和皺紋，有明顯的花柱殘跡或果梗痕。切面中果皮略隆起，黃白色或黃褐色，厚0.3~1.2cm，邊緣有1~2列油室，瓤囊棕褐色。質堅硬。氣清香，味苦、微酸')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0115','梔子','Common Gardenia Fruit','瀉火除煩；清熱利濕；涼血解毒主治熱病心煩；肝火目赤；頭痛；濕熱黃疸；淋證；血痢尿血；口舌生瘡；瘡瘍腫毒；扭傷腫痛','苦，寒','以皮薄、飽滿、色紅黃者為佳','果實倒卵形、橢圓形或長橢圓形，長1.4~3.5cm，直徑0.8~1.8cm。表面紅棕色或紅黃色，微有光澤，有翅狀縱棱6~8條，每二翅棱間有縱脈1條，先端有暗黃綠色殘存宿萼，先端有6~8條長形裂片，裂片長1~2.5cm，寬2~3mm，多碎斷，果實基部收縮成果柄狀，末端有圓形果柄痕。果皮薄而脆，內表面鮮黃色或紅黃色。有光澤，具隆起的假隔膜2~3條。折斷面鮮黃色，種子多數，扁橢圓形或扁矩圓形，聚成球狀團塊，棕紅色，表面有細而密的凹入小點；胚乳角質；胚長形，具心形子葉2片。氣微，味微酸苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0116','紫蘇子','Cultivated Puple Perilla Fruit','降氣消痰，平喘，潤腸。用於痰壅氣逆，咳嗽氣喘，腸燥便秘。解表散寒，行氣和胃。用於風寒感冒，咳嗽氣喘，妊娠嘔吐，胎動不安。又可解魚蟹中毒','辛，溫','以均勻飽滿、色灰褐、油性足者為佳','該品呈卵圓形或類球形，直徑約1.5mm。表面灰棕色或灰褐色，有微隆起的暗紫色網紋，基部稍尖，有灰白色點狀果梗痕。果皮薄而脆，易壓碎。種子黃白色，種皮膜質，子葉2，類白色，有油性。壓碎有香氣，味微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0117','枸杞子','Babury Wolfberry Fruit','滋補肝腎，益精明目','甘，平','以粒大，色澤鮮亮者為佳','呈類紡錘形或橢圓形，表面紅色或暗紅色，項端有小突起狀的花柱痕，基部有白色的果梗痕。果皮柔韌，皺縮；果肉肉質，柔潤。種子20~50粒，類腎形。扁而翹，表面淺黃色或棕黃色。氣微，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0118','芡實','Gordon Euryale Seed','益腎固精，補脾止渭，除濕止帶。用於遺精滑精，遺尿尿頻，脾虛久瀉，自濁，帶下','甘、澀。平','以顆粒飽滿均勻、粉性足、無碎末及皮殼者為佳','類球形，多為破粒。表面有棕紅色內種皮，一端黃自色，約占全體1/3、有凹點狀的種臍痕，除去內種皮顯白色。質較硬，斷面白色，粉性。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0119','山茱萸','Common Macrocarpium Fruit','補益肝腎，澀精固脫。用於眩暈耳鳴，腰膝酸痛，陽痿遺精，遺尿尿頻，崩漏帶下，大汗虛脫，內熱消渴','酸、澀，微溫','以皮肉厚，色鮮豔，味酸濃者佳','本品呈不規則的片狀或囊狀。表面紫紅色至紫黑色，皺縮，有光澤。頂端有的有圓形宿萼痕，基部有果梗痕。質柔軟。氣微，味酸、澀、微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0120','酸棗仁','Spine Date Seed','養心補肝，寧心安神，斂汗，生津。用於慮煩不眠，驚悸多夢，體虛多汗，津傷口渴','甘，酸，平','以粒大飽滿、外皮紫紅色、無核殼者為佳','乾燥成熟的種子呈扁圓形或橢圓形，表面紫紅色或紫褐色，平滑有光澤，有的有裂紋。有的兩面均承圓隆狀突起，有的一面較平州。中間或有1條隆起的縱線紋；另一面稍突起。一端凹陷，可見線形種臍，另端有細小突起的合點。種皮較脆，乳白色。子葉2，淺黃色，富油性。 氣微弱，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0121','烏梅','Smoked Plum','斂肺，澀腸，生津，安蛔。用於肺虛久咳，久痢滑腸，虛熱消渴，蛔厥嘔吐腹痛，膽道蛔蟲症','酸、澀，平','以個大、肉厚、柔潤、味極酸者為佳','本品呈類環形或扁球形，直徑1.5~3cm。表面烏黑色或棕黑色，皺縮不平，基部有圓形果梗痕。果核堅硬，橢圓形，棕黃色，表面有凹點；種子扁卵形，淡黃色。氣微，味極酸')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0122','川楝子','Szechwan Chinaberry Fruit','舒肝行氣止痛，驅蟲。用於胸脅、脘腹脹痛，疝痛，蟲積腹痛','苦，寒，有小毒','以個大、飽滿、外皮金黃色、果肉黃白色者為佳','果實類球形，直徑2~3cm。表面金黃色至棕黃色，微有光澤，具深棕色小點。頂端有花柱殘基，基部凹陷有果梗痕。外果皮革質，與果肉間常成空隙，果肉鬆軟，淡黃色，遇水潤濕顯粘性。果核球形或卵圓形，質堅硬，兩端平截，有6~8條縱棱，內分6~8室，每室含黑棕色長圓形的種子1粒。氣特異，味酸、苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0123','牛蒡子','Great Burdock Fruit','疏散風熱，宣肺透疹，解毒利咽。用於風熱感冒，咳嗽痰多，麻疹，風疹，咽喉腫痛，痄腮丹毒，癰腫瘡毒','辛、苦，寒','以粒大、飽滿、色灰褐者為佳','本品呈長倒卵形，略扁，微彎曲，長5~7mm，寬2~3mm。表面灰褐色，帶紫黑色斑點，有數條縱棱，通常中間1~2條較明顯。頂端鈍圓，稍寬，頂面有圓環，中間具點狀花柱殘跡；基部略窄，著生面色較淡。果皮較硬，子葉2，淡黃白色，富油性。無臭，味苦後微辛而稍麻舌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0124','砂仁','Villous Amomum Fruit','化濕開胃，溫脾止瀉，理氣安胎。用於濕濁中阻，脘痞不饑，脾胃虛寒，嘔吐泄瀉，妊娠惡阻，胎動不安','辛，溫','以個大、堅實、仁飽滿、氣香濃者為佳','海南砂：呈長橢圓形或卵圓形，有明顯的三棱，長1.5~2cm，直徑0.8~1.2cm。表面被片狀、分枝的軟刺，基部具果梗痕。果皮厚而硬。種子團較小，每瓣有種子3~24粒；種子直徑1.5~2mm。氣味稍淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0125','薄荷','Wild Mint Herb','疏散風熱，清利頭目，透疹。具有疏散風熱、清利頭目、利咽、透疹、疏肝解鬱之功效。現代醫學常將其用於治療風熱感冒、頭痛、咽喉痛、口舌生瘡、風疹、麻疹、胸腹脹悶和抗早孕等。另外，薄荷還具有消炎止痛作用','辛，涼','以色深綠、葉多、氣濃者為佳','本品莖呈方柱形，有對生分枝，長15~40cm，直徑0.2~0.4cm；表面紫棕色或淡綠色，棱角處具茸毛，節間長2~5cm；質脆，斷面白色，髓部中空。葉對生，有短柄；葉片皺縮捲曲，完整者展平後呈寬披針形、長橢圓形或卵形，長2~7cm，寬1~3cm；上表面深綠色，下表面灰綠色，稀被茸毛，有凹點狀腺鱗。輪傘花序腋生，花萼鐘狀，先端5齒裂，花冠淡紫色。揉搓後有特殊清涼香氣，味辛涼')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0126','大薊','Japanese Thistle','止血涼血、祛瘀消腫。主治吐血，衄血，尿血，血淋，血崩，帶下，腸風，腸癰，癰瘍腫毒，疔瘡','甘、苦，涼','根以條粗、乾燥者為佳','大薊根：呈長紡錘形，常簇生而扭曲，長5~15cm，直徑0.2~0.6cm。表面暗褐色，有不規則的縱皺紋。質硬而脆，易折斷，斷面粗糙，灰白色。氣微，味甘、微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0127','小薊','Field Thistle','涼血止血，祛瘀消腫。用於衄血，吐血，尿血，便血，崩漏下血，外傷出血，癰腫瘡毒','甘、苦，涼','以灰綠色、葉多者為佳','本品莖呈圓柱形，有的上部分枝，長5~30cm，直徑0.2~0.5cm；表面灰綠色或帶紫色，具縱棱及白色柔毛；質脆，易折斷，斷面中空。葉互生，無柄或有短柄；葉片皺縮或破碎，完整者展平後呈長橢圓形或長圓狀披針形，長3~12cm，寬0.5~3cm；全緣或微齒裂至羽狀深裂，齒尖具針刺；上表面綠褐色，下表面灰綠色，兩面均具白色柔毛。頭狀花序單個或數個頂生；總苞鐘狀，苞片5~8層，黃綠色；花紫紅色。氣微，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0128','荊芥','Fineleaf Schizonepeta Herb','解表散風，透疹，消瘡，止血。用於感冒，麻疹透發不暢，便血、崩漏、鼻衄','辛，微溫','以色淡黃綠、香氣濃、穗長而密者為佳','本品莖呈方柱形，上部有分枝，長50~80cm，直徑0.2~0.4cm；表面淡黃綠色或淡紫紅色，被短柔毛；體輕，質脆，斷面類白色。葉對生，多已脫落，葉片3~5羽狀分裂，裂片細長。穗狀輪傘花序頂生，長2~9cm，直徑約7mm。花冠多脫落，宿萼鐘狀，先端5齒裂，淡棕色或黃綠色，被短柔毛；小堅果棕黑色。氣芳香，味微澀而辛涼')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0129','麻黃','Chinese Ephedrs Herb','發汗散寒，宣肺平喘，利水消腫','辛、微苦，溫','均以淡綠色或黃綠色，內心紅棕色、味苦澀、手拉不脫節者為佳','中麻黃：多分枝，直徑1.5~3cm，有粗糙感。節間長2~6cm，膜質鱗葉長2~3mm，裂片3 (稀2)，先端銳尖。斷面髓部呈三角狀圓形')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0130','青蒿','Sweet Wormwood Herb','清透虛熱，涼血除蒸，除蒸，截瘧。用於暑邪發熱，陰虛發熱，夜熱早涼，骨蒸勞熱，瘧疾寒熱，濕熱黃疸','苦、辛，寒','以色綠、葉多、香氣濃者為佳','莖圓柱形，上部多分枝，長30~80cm，直徑0.2~0.6cm，表面黃綠色或棕黃色，具縱棱線；質略硬，易折斷，斷面中部有髓。葉互生，暗綠色或棕綠色，捲縮，碎，完整者展平後為三回羽狀深裂，裂片及小裂片矩圓形或長橢圓形，兩面被短毛。氣香特異，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0131','瞿麥','Fringed Pink Herb','利尿通淋，破血通經。用於熱淋、血淋、石淋、小便不通、淋瀝澀痛','苦，寒','以色青綠，花未開放者為佳','瞿麥：莖圓柱形，長30~60cm，節部膨大；表面淡綠色或黃綠色，略有光澤，無毛。葉多皺縮，對生，黃綠色，展平後葉片長條披針形，長2~7cm，寬1~4mm；葉尖稍反卷，基部短鞘狀抱莖。花棕紫色或棕黃色，長3~4cm，單生或數朵簇生；具宿萼，萼筒長2.5~3.5cm，約為全花的3/4；萼下有小苞片，長約為萼筒的1/4，先端急尖或漸尖，外表有規則的縱紋；花瓣先端深裂呈流蘇狀。莖質硬脆，折斷面中空。氣無，味甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0132','肉蓯蓉','Desertliving Cistanche Herb','具有補腎陽，益精血，潤腸通便的功效。主治腎陽虛衰，精血虧損，陽痿，遺精，腰膝冷痛，耳鳴目花，帶濁，尿頻，月經愆期，崩漏，不孕不育，腸燥便秘','甘、咸，溫','以條粗壯、密生鱗葉、質柔潤者為佳','管花肉蓯蓉：呈扁圓柱形、扁紡錘形、扁卵圓形、扁圓形等不規則形，長6~8cm，直徑4~6.5cm，表面紅棕色、灰黃棕色或棕褐色，多扭曲。密被略呈覆瓦狀排列的肉質鱗片，上部密下部疏、鱗片先端多已斷落，殘基部寬多在l釐米以上，整個鱗片略呈長三角形，高約1cm。體重、質堅硬，無韌性，難折斷，斷面顆粒性，多呈灰棕色，有的外圈呈黑色硬膠質樣。黑褐色點狀維管束眾多，不規則散在，有的有小裂隙。氣微，味甜、微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0133','石斛','Noble Dendrobium Stem Herb','養陰清熱，益胃生津。用於熱傷津液，低熱煩渴，舌紅少苔；胃陰不足，口渴咽乾，嘔逆少食，胃脘隱痛，舌光少苔；腎陰不足，視物昏花','甘，微寒','以金黃色、有光澤、質柔韌者為佳','馬鞭石斛：莖細長圓錐形，上部有少數分枝，長30~150cm，直徑2~8mm，節間長2~4.5cm。表面棕黃色，有8~9條縱溝。質疏鬆，斷面纖維性。氣微，味微苦。商品常切成1.5~3cm長段，切面灰白色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0134','香薷','Chinese Mosla Herb','發汗解暑，行水散濕，溫胃調中。主治：夏月感寒飲冷，頭痛發熱，惡寒無汗，胸痞腹痛，嘔吐腹瀉，水腫，腳氣','辛、甘，溫','以枝嫩、穗多、香氣濃者為佳','全體長14~30cm，被白以短茸毛。莖多分枝，四方柱形，近基部圓形，直徑0.5~5mm；表面黃棕以，近基部常呈棕紅色，節明顯，節間長2~5cm；質脆，易折斷，斷面淡黃色，葉對生，多脫落，皺縮或破碎，完整者展平後呈狹長披針形，長0.7~2.5cm，寬約4mm，邊緣有疏鋸齒，黃綠色或暗綠以；質脆，易碎。花輪密集成頭狀；苞片被白色柔毛；花萼鐘狀，先端5裂；花冠皺縮或脫落。小是對果4，包於宿萼內，香氣濃，味辛涼。栽培品全體長35~60cm，疏被較長的茸毛；莖較粗，節間長4~7cm')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0135','益母草','Common Motherwort Herb','活血、祛淤、調經、消水。治療婦女月經不調，胎漏難產，胞衣不下，產後血暈，瘀血腹痛，崩中漏下，尿血、瀉血，癰腫瘡瘍','辛、苦，涼','以枝嫩、黃綠色、帶葉花者為佳','乾益母草：莖表面灰綠色或黃綠色；體輕，質韌，斷面中部有髓。葉片灰綠色，多皺縮、破碎，易脫落。輪傘花序腋生，小花淡紫色，花萼筒狀，花冠二唇形。切段者長約2cm')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0136','茵陳','Capillary Wormwood Herb','清熱利濕；退黃。主治：黃疸、小便不利、濕瘡瘙癢、傳染性黃疸型肝炎','苦、辛，微寒','以質嫩、綿軟、色灰白、香氣濃者為佳','茵陳蒿：莖呈圓柱形，多分枝，長30~100cm，直徑2~8mm；表面淡紫色或紫色，有縱條紋，被短柔毛；體輕，質脆，斷面類白色。葉密集，或多脫落；下部葉二至三回羽狀深裂，裂片條形或細條形，兩面密被白色柔毛；莖生葉一至二回羽狀全裂，基部抱莖，裂片細絲狀；頭狀花序卵形，多數集成圓錐狀，長1.2~1.5mm，直徑1~1.2mm，有短梗；總苞片3~4層，卵形，苞片3裂；外層雌花6~10個，可多達15個，內層兩性花2~10個。瘦果長圓形，黃棕色。氣芳香，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0137','丁香','Clove','暖胃，溫腎。治胃寒痛脹、呃逆、吐瀉、痹痛、疝痛、口臭、牙痛','甘，溫','以個大、粗壯、鮮紫棕色、香氣強烈、油多者為佳','乾燥的花蕾略呈短棒狀，長1.5~2cm，紅棕色至暗棕色；下部為圓柱狀略扁的萼管，長1~1.3cm，寬約5mm，厚約3mm，基部漸狹小，表面粗糙，刻之有油滲出，萼管上端有4片三角形肥厚的萼；上部近圓球形，徑約6mm，具花瓣4片，互相抱合。將花蕾剖開，可見多數雄蕊，花絲向中心彎曲，中央有一粗壯直立的花柱，質堅實而重，入水即沉；斷面有油性，用指甲劃之可見油質滲出；氣強烈芳香，味辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0138','槐花','Black Locust Flower','涼血止血，清肝瀉火。主治腸風便血，痔血，血痢，尿血，血淋，崩漏，吐血，衄血，肝火頭痛，目赤腫痛，喉痹，失音，癰疽瘡瘍','苦，微寒','以黃綠色、粒大、緊實者為佳','皺縮而捲曲，花瓣多散落，完整者花萼鐘狀，黃綠色，花瓣黃色或黃白色。體輕。味微苦。花蕾 (槐米) 卵形或橢圓形。花萼黃綠色，上方為未開放的黃白色花瓣，內呈黃褐色。質輕。味微苦澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0139','金銀花','Japanese Honysuckle Flower Bud','宣散風熱，清熱解毒。用於各種熱性病，如身熱、發疹、發斑、熱毒瘡癰、咽喉腫痛等證','甘，寒','以花蕾多、色淡、柔軟氣清香者為佳','本品呈棒狀，上粗下細，略彎曲，長2~3cm，上部直徑3mm，下部直徑1.5mm，表面黃白色或綠白色，密被短柔毛。偶見葉狀苞片，花萼綠色、先端5裂，裂片有毛，長約2mm，開放者花冠筒狀，先端二唇形，雄蕊5附於筒壁，黃色；雌蕊1個，子房無毛，氣清香，味淡微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0140','菊花','Florists Dendranthema','清熱解毒，平肝明目；疏風散熱','苦，微寒','以花朵完整、顏色鮮豔、清香者為佳','滁菊：呈不規則球形或扁球形，直徑1.5~2.5cm，舌狀花類白色，不規則扭曲，內卷，邊緣皺縮，有時可見淡褐色的腺點，管狀花大多隱藏。是菊花中花瓣最為緊密的一種')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0141','款冬花','Common Coltsfoot Flower','化痰止咳，鎮咳下氣，潤肺祛痰，降逆止嘔。主治咳嗽，氣喘，肺痿，咳吐痰血等症','辛、微苦，溫','以2~3朵並連、蕾大、身乾、色紫紅、梗極短、無開放花朵者為佳','款冬花花蕾呈捧狀或長橢圓形，單一或2~3並生，有時可達5朵，俗稱“連三朵”。一般長約1~3cm，直徑約0.5~0.8cm。花蕾及花柄上包有粉紫 色或淡棕褐色鱗狀苞片數層。鱗狀苞片包裹著黃棕色未成形的細小舌狀及管狀花如蜘蛛絲樣的紫狀物。氣清香，味微苦辛，嚼之如絮')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0142','蒲黃','Cattail Pollen','止血，化瘀，通淋。用於吐血、衄血、咯血、崩漏、外傷出血、經閉、痛經、脘腹刺痛、跌打腫痛、血淋濕痛','甘、平','以粉細、純淨、體輕、色鮮黃、滑膩感強者為佳','花粉為黃色粉末。體輕，放水中則飄浮水面。手撚有骨膩感，易附著手指上，氣微，味淡。花粉粒類圓形或橢圓形，直徑17~29μm，表面有網狀雕紋，周邊輪廓線光滑，呈凸波狀或齒輪狀，具單孔，不甚明顯')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0143','芫花','Lilac Daphe Flower Bud','瀉水逐飲，解毒殺蟲。用於水腫脹滿，胸腹積水，痰飲積聚，氣逆喘咳，二便不利；外治疥癬禿瘡，凍瘡。根皮：消腫解毒，活血止痛。用於急性乳腺炎，癰癤腫毒，淋巴結結核，腹水，風濕痛，牙痛，跌打損傷','甘、苦，溫，有毒','以花蕾多而整齊、淡紫色、無破碎者為佳','該品常3~7朵簇生於短花軸上，基部有苞片1~2片，多脫落為單朵。單朵呈棒槌狀，多彎曲，長1~1.7cm，直徑約1.5mm；花被筒表面淡紫色或灰綠色，密被短柔毛，先端4裂，裂片淡紫色或黃棕色。質軟')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0144','紅花','Safflower','活血通經，散瘀止痛，用於閉經，痛經，惡露不行，症瘕痞塊，胸痹心痛，癡滯腹痛，胸脅刺痛，跌撲損傷，瘡瘍腫痛','辛，溫','以花色紅黃、鮮豔、乾燥、質柔軟者為佳','本品為不帶子房的管狀花，表面紅黃色或紅色，花冠筒細長，先端5裂，裂片呈狹條形，雄蕊5，花藥聚合成筒狀，黃白色；柱頭長圓柱形，頂端微分叉。質柔軟。氣微香，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0145','旋覆花','Japanese Inula Flower','降氣，消痰，行水，止嘔。用於風寒咳嗽，痰飲蓄結，胸膈痞滿，喘咳痰多，嘔吐噫氣，心下痞硬','苦，辛、咸，微溫','以朵大、金黃色、有白絨毛、無枝梗者為佳','本品呈扁球形或類球形，直徑1~2cm。總苞由多數苞片組成，呈覆瓦狀排列，苞片披針形或條形，灰黃色，長4~11mm；總苞基部有時殘留花梗，苞片及花梗表面被白色茸毛，舌狀花1列，黃色，長約1cm，多捲曲，常脫落，先端3齒裂；管狀花多數，棕黃色，長約5mm，先端5齒裂；子房頂端有多數白色冠毛，長5~6mm。有的可見橢圓形小瘦果。體輕，易散碎。氣微，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0146','側柏葉','Chinese Arborviae Twig and Leaf','涼血，止血，祛風濕，散腫毒。治吐血、衄血、尿血、血痢、腸風、崩漏，風濕痹痛，細菌性痢疾，高血壓，咳嗽，丹毒，痄腮，燙傷','苦、澀，寒','以葉嫩、青綠色，無碎末者為佳','多有分支，小且長短不一，為鱗片狀。顏色為紅褐色。表面可見葉相互對生，斷面黃白色。質地鬆脆、易被折斷。莖枝類圓柱形，紅棕色；小枝扁平，直徑1~2mm。葉細小鱗片狀，交互對生，貼伏於枝上，深綠色或黃綠色。質脆。氣清香，味苦澀、微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0147','荷葉','Hindu Lotus Leaf','清熱解暑，升發清陽，涼血止血。用於暑熱煩渴，暑濕泄瀉，脾虛泄瀉，血熱吐衄，便血崩漏','苦，平','以葉大、整潔、色綠者為佳','荷葉葉多折成半圓形或扇形，展開後呈類圓形，直徑20~50cm，全緣或稍波狀。上表面深綠色或黃綠較粗糙；下表面淡灰棕色，較光滑，有粗脈21~22條，處中心向四周射出，中心有突起的葉西峽錢基。質脆，易破碎。微有清香氣，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0148','枇杷葉','Loquat Leaf','清肺止咳，降逆止嘔。　肺熱咳嗽，氣逆喘急，胃熱嘔吐，噦逆','苦，微寒','以完整、葉厚、色綠者佳','葉片長橢圓形，長12~30cm，寬4~9cm。上表面淡棕綠色、黃綠色或紅棕色，有光澤。下表面灰綠色或棕黃色，密佈灰棕色絨毛。葉脈呈羽毛狀兩側斜生，中間主脈呈棕黃或棕紅色，顯著突起。葉先端漸尖，周邊有疏鋸齒。葉柄極短，被黃棕色或棕黑色絨毛。葉厚革質，質脆易碎。微有清香氣，味微苦')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0149','桑葉','Mulberry Leaf','疏散風熱，清肺潤燥，平抑肝陽，清肝明目，涼血止血','甘、苦，寒','以色黃綠且葉大者為佳','多皺縮，破碎。完整者有柄，葉片上面黃綠色或淺黃棕色，有的有小疣狀突起；下表面色較淺，葉脈突起，小脈網狀，脈上被疏毛，脈基具簇毛。質脆。氣微，味淡、微苦、澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0150','石韋','Japanese Felt Fern','利尿通淋，清熱止血。用於熱淋，血淋，石淋，小便不通，淋瀝澀痛，吐血，衄血，尿血，崩漏，肺熱喘咳','甘、苦，微寒','以葉片完整、葉厚而大、背面色發紅且有小點者為佳','有柄石韋：葉片多捲曲呈筒狀，展平後呈長圓形或卵狀長圓形，長3~8cm，寬1~2.5cm。基部楔形，對稱。下表面側脈不明顯，佈滿孢子囊群。葉柄長3~12cm，直徑約1mm')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0151','紫蘇葉','Cultibated Purple Perilla Leaf','發表，散寒，理氣，和營。治感冒風寒，惡寒發熱，咳嗽，頭痛無汗，氣喘，胸腹脹滿，嘔惡腹瀉，咽中梗阻，妊娠惡阻，胎動不安。並能解魚蟹毒','辛，微溫','以葉大、色紫、不碎、香氣濃、無枝梗者為佳','乾燥完整的葉呈卵形或圓卵形，多數皺縮捲曲，或已破碎，兩面均棕紫色，或上面灰綠色，下面棕紫色，兩面均有稀毛；先端尖，邊緣有鋸齒，基部近圓形，有柄，質薄而脆。切碎品多混有細小莖枝。莖四方形，有槽，外皮黃紫色，有時剝落，木質部黃白色，中央有白色疏鬆的髓。氣芳香，味微辛')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0152','百合','Liy Bulb','養陰潤肺，清心安神。用於陰虛久咳，痰中帶血，虛煩驚悸，失眠多夢，精神恍惚','甘，寒','以瓣勻肉厚、色黃白、質堅、筋少者為佳','細葉百合：鱗葉長約5.5cm，寬約2.5cm，厚至3.5mm，色較暗，脈紋不太明顯')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0153','地骨皮','Chinese Wolfberry Root - bark','涼血除蒸，清肺降火。用於陰虛潮熱、骨蒸盜汗、肺熱咳嗽、咯血、衄血','甘，寒','以塊大、肉厚、無木心與雜質者為佳','乾燥根皮為短小的筒狀或槽狀卷片，大小不一，一般長3~10cm，寬0.6~1.5cm，厚約3mm。外表面灰黃色或棕黃色，粗糙，有錯雜的縱裂紋，易剝落。內表面黃白色，較平坦，有細縱紋。質輕脆，易折斷，斷面不平坦，外層棕黃色，內層灰白色。臭微。味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0154','杜仲','Eucommia Bark','補肝腎，強筋骨，安胎。治腰脊酸疼，足膝痿弱，小便余瀝，陰下濕癢，胎漏欲墮，胎動不安，高血壓','甘，溫','以皮厚而大，糙皮刮淨，外面黃棕色，內面黑褐色而光，折斷時白絲多者為佳','乾燥樹皮，為平坦的板片狀或卷片狀，大小厚薄不一，一般厚約3~10mm，長約40~100cm。外表面灰棕色，粗糙，有不規則縱裂槽紋及斜方形橫裂皮孔，有時可見淡灰色地衣斑。但商品多已削去部分糙皮，故外表面淡棕色，較平滑。內表面光滑，暗紫色。質脆易折斷，斷面有銀白色絲狀物相連，細密，略有伸縮性。氣微，味稍苦，嚼之有膠狀殘餘物')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0155','黃柏','Amur Corktree Bark','清熱燥濕，瀉火除蒸，解毒療瘡。用於濕熱瀉痢，黃疸，帶下，熱淋，腳氣，骨蒸勞熱，盜汗，遺精，瘡瘍腫毒，濕疹瘙癢','苦，寒','以皮厚斷面黃色者為佳','呈板片狀或淺槽狀，長寬不一，厚3~6mm。外表面黃褐色或黃棕色，平坦或具縱溝紋，有的可見皮孔痕及殘存的灰褐色粗皮。內表面暗黃色或淡棕色，具細密的縱棱紋。體輕，質硬，斷面纖維性，呈裂片狀分層，深黃色。氣微，味甚苦，嚼之有粘性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0156','厚樸','Officinal Magnolia Bark','行氣消積；燥濕除滿；降逆平喘。主治食積氣滯；腹脹便秘；濕阻中焦，脘痞吐瀉；痰壅氣逆；胸滿喘咳','苦、辛，溫','均以皮厚、肉細、油性大，斷面紫棕色、有小亮星、氣味濃厚者為佳','枝皮 (枝樸) ：呈單筒狀，長10~20cm，厚1~2mm。外表面灰褐色，內表面黃棕色。質脆，易折斷，斷面纖維性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0157','牡丹皮','Tree Peony Root - bark','清熱涼血；活血散瘀。溫熱病熱入血分；發斑；吐衄；熱病後期熱伏陰分發熱；陰虛骨蒸潮熱；血滯經閉；痛經；癰腫瘡毒；跌撲傷痛；風濕熱痹','苦、辛，微寒','以條粗長、皮厚、無木心、斷面粉白色、具粉性、“亮銀星”多、香氣濃者為佳','呈筒狀或半筒狀，有縱剖開的縫，略向內捲曲或張開，長5~20cm，直徑0.5~1.2cm，厚0.1~0.4cm。原丹皮外表面灰褐色或黃褐色，有多數橫長皮孔及細根痕，栓皮脫落處粉紅色；刮丹皮粉紅色或淡紅色。內表面淡灰黃色或淺棕色，有明顯的細縱紋，常見發亮的結晶 (系針、柱狀牡丹酚結晶) 。質硬而脆，易折斷。斷面較平坦，淡粉紅色，粉性，紋理不明顯。氣芳香，味微苦而澀，有麻舌感 ')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0158','秦皮','Ash Bark','清熱燥濕，清肝明目，收澀止痢，止帶。用於熱毒瀉痢，帶下陰癢，肝熱目赤腫痛，目生翳障','苦，寒','以條長、外皮薄而光滑者為佳','幹皮：為長條狀塊片，厚3~6mm。外表面灰棕色，有紅棕色圓形或橫長的皮孔及龜裂狀溝紋。質堅硬，斷面纖維性較強')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0159','肉桂','Cassia Bark','補火助陽，引火歸源，散寒止痛，活血通經。暖脾胃，除積冷，通血脈。治命門火衰，肢冷脈微，亡陽虛脫，腹痛泄瀉，寒疝奔豚，腰膝冷痛，經閉症瘕，陰疽，流注，及虛陽浮越，上熱下寒','辛、甘，大熱','以完整不碎、皮厚體重、外表面具細皺紋，油性大、香氣濃者為佳','桂碎：大小不規則片塊狀或短捲筒狀，外皮灰棕色，斷面和內皮呈棕色或棕褐色，氣香，味甜辣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0160','桑白皮','White Mulberry Root - bark','瀉肺平喘，利水消腫。用於肺熱咳喘，面目浮腫，小便不利等症','甘，寒','以色白、皮厚、粉性足者為佳','長片狀槽狀形，左右兩邊向內捲曲，卷邊呈半筒形，槽的中呈長而扭曲的板片狀，筒狀或兩邊向內卷成槽狀，長短寬窄不一，厚0.1~0.5cm。外表面淡黃白色，有少數棕黃色或紅棕色斑點 (殘留栓皮)，內表面黃白色或灰黃色，平滑，有細縱紋，有的縱向裂開，露出纖維。體輕質韌，難折斷，易縱向撕裂，撕裂時有白色粉塵飛出，氣微，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0161','茯苓','Tuckahoe','滲濕利水，健脾和胃，寧心安神。小便不利；水腫脹滿；痰飲咳逆；嘔吐；脾虛食少；泄瀉；心悸不安；失眠健忘；遺精白濁','甘、淡，平','以體重堅實、外皮棕褐色、皮紋細、無裂隙、斷面白色細膩、粘牙力強者為佳','常見者為其菌核體。多為不規則的塊狀，球形、扁形、長圓形或長橢圓形等，大小不一，小者如拳，大者直徑達20~30cm，或更大。表皮淡灰棕色或黑褐色，呈瘤狀皺縮，內部白色稍帶粉紅，由無數菌絲組成。子實體傘形，直徑0.5~2mm，口緣稍有齒；有性世代不易見到，蜂窩狀，通常附菌核的外皮而生，初白色，後逐漸轉變為淡棕色，孔作多角形，擔子棒狀，擔孢子橢圓形至圓柱形，稍屈曲，一端尖，平滑，無色。有特殊臭氣')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0162','豬苓','Agaric','利水滲濕。用於小便不利，水腫，泄瀉，淋濁，帶下','甘、淡，平','以個大、體結、質重、皮黑光亮、肉白、粉性足者為佳','豬苓呈條形、類圓形或扁塊狀，有的有分枝，長5~25cm，直徑2~6cm。體輕，質硬，略呈顆粒狀。表面黑色、灰黑色或棕黑色，皺縮或有瘤狀突起，斷面類白色或黃白色。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0163','沒藥','Myrrh','散血去瘀，消腫定痛','辛、苦，平','以塊大、色紅棕、半透明、香氣濃而持久、雜質少者為佳','膠質沒藥：成不規則塊狀，多黏結成大小不等的團塊。表面深棕色或黃棕色，不透明；質堅實或疏鬆。味苦而有黏性')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0164','乳香','Frankincense','調氣活血，定痛，追毒。治氣血凝滯、心腹疼痛，癰瘡腫毒，跌打損傷，痛經，產後瘀血刺痛','辛、苦，溫','以淡黃色、顆粒狀、半透明、無砂石樹皮雜質、粉末粘手、氣芳香者為佳','多呈小形乳頭狀、淚滴狀顆粒或不規則的小塊，長0.5~3cm，有時粘連成團塊。淡黃色，常帶輕微的綠色、藍色或棕紅色。半透明。表面有一層類白色粉塵，除去粉塵後，表面仍無光澤。質堅脆，斷面蠟樣，無光澤，亦有少數呈玻璃樣光澤。氣微芳香，味微苦。嚼之，初破碎成小塊，迅即軟化成膠塊，粘附牙齒，唾液成為乳狀，並微有香辣感。遇熱則變軟，燒之微有香氣 (但不應有松香氣)，冒黑煙，並遺留黑色殘渣。與少量水共研，能形成白色乳狀液')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0165','鱉甲','Turtle Carapace','滋腎潛陽，軟堅散結。主治骨蒸勞熱、瘧母、脅下堅硬、腰痛，經閉症瘕等症','鹹，寒','以身乾、個大、無殘肉、潔淨者為佳','為卵圓形或橢圓形的骨片，背部微隆起，前後端微向內捲曲。長約10~23cm，寬8~17cm，厚約5mm。背甲中央有不顯明的骨節隆起，兩側各有八條左右對稱的橫凹紋。背面為灰褐色並有皺褶及突起狀斑點。甲的邊緣呈齒狀，類白色。腹面灰白色，有骨隆起明顯，兩側對稱的肋各8條。質堅硬。臭微腥，味鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0166','蟬蛻','Cicada Slough','散風除熱，利咽，透疹，退翳，解痙。用於風熱感冒，咽痛，音啞，麻疹不透，風疹瘙癢，目赤翳障，驚風抽搐，破傷風','甘，寒','以體形完整、亮黃色者為佳','全形似蟬而中空，稍彎曲。長約4cm，寬約2cm。表面黃棕色，半透明，有光澤。頭部有絲狀觸角1對，多已斷落，複眼突出，頸部先端突出，口吻發達，上唇寬短，下唇伸長成管狀。胸部背面呈十字形裂片，裂口向內捲曲，脊背兩旁具有小翅2對；腹面有足3對，被黃棕色細毛。腹部鈍圓，共9節。體輕，中空，易碎。無臭，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0167','地龍','Earthworm','清熱定驚，通絡，平喘，利尿。用於高熱神昏，驚癇抽搐，關節痹痛，肢體麻木，半身不遂，肺熱喘咳，尿少水腫，高血壓','鹹，寒','以條大、肉厚者為佳','滬地龍：長8~15cm，寬0.5~1.5cm。全體具環節，背部棕褐色至黃褐色，腹部淺黃棕色；受精囊孔3對，在6/7至8/9環節間。第14~16環節為生殖帶，較光亮。第18環節有一對雄生殖孔。通俗環毛蚓的雄交配腔能全部翻出，呈花菜狀或陰莖狀；威廉環毛蚓的雄交配腔孔呈縱向裂縫狀；櫛盲環毛蚓的雄生殖孔內側有1或多個小乳突')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0168','阿膠','Ass-hide Gelatin','補血，止血，滋陰潤燥','甘，平','以色勻、質脆、半透明、斷面光亮者為佳','正品阿膠為長方形或方形塊，質硬而脆，無油孔、氣孔及明顯刀紋。表面平滑有光澤，斷面對光照視呈棕色半透明狀，膠塊表面當以黃透如琥珀色，光黑如漆。氣微，味微甘')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0169','龜甲','Tortoses Carapae and Plastron','滋陰潛陽，益腎強骨，養血補心。用於陰虛潮熱，骨蒸盜汗，頭暈目眩虛風內動，筋骨痿軟，心虛健忘','咸、甘，微寒','以塊大、無殘肉、板有血跡者為佳','該品背甲及腹甲由甲橋相連，背甲稍長於腹甲，與腹甲常分離。背甲呈長橢圓形拱狀，長7.5~22cm，寬6~18cm；外表面棕褐色或黑褐色，脊棱3條；頸盾1 塊，前窄後寬；椎盾5 塊，第1椎盾長大於寬或近相等，第2~4椎盾寬大於長；肋盾兩側對稱，各4塊，緣盾每側11塊，臀盾2塊。腹甲呈板片狀，近長方橢圓形，長6.4~21cm，寬5.5~17cm；外表面淡黃棕色至棕黑色，盾片12塊，每塊常具紫褐色放射狀紋理，腹盾、胸盾和股盾中縫均長，喉盾、肛盾次之，肱盾中縫最短；內表面黃白色至灰白色，有的略帶血跡或殘肉，除淨後可見骨板9 塊，呈鋸齒狀嵌接；前端鈍圓或平截，後端具三角形缺刻，兩側殘存呈翼狀向斜上方彎曲的甲橋。質堅硬。氣微腥，味微鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0170','海螵蛸','Sepium','收斂止血，澀精止帶，制酸，斂瘡。用於胃痛吞酸，吐血衄血，崩漏便血，遺精滑精，赤白帶下；潰瘍病。外治損傷出血，瘡多膿汁','咸、澀，溫','以潔淨色白者為佳','金烏賊：長13~23cm，寬約至6.5cm。背面疣點明顯，略呈層狀排列；腹面的細密波狀橫層紋占全體大部分，中間有縱向淺槽；尾部角質緣漸寬，向腹面翹起，末端有1骨針，多已斷落')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0171','僵蠶','Stiff Silkworm','祛風定驚，化痰散結。用於驚風抽搐，咽喉腫痛，頜下淋巴結炎，面神經麻痹，皮膚瘙癢','咸、辛，平','以質硬、色白、條粗者為佳','本品略呈圓柱形，多彎曲皺縮。長2~5cm，直徑0.5~0.7cm。表面灰黃色，被有白色粉霜狀的氣生菌絲和分生孢子。頭部較圓，足8對，體節明顯，尾部略呈二分歧狀。質硬而脆，易折斷，斷面平坦，外層白色，中間有亮棕色或亮黑色的絲腺環4個。氣微腥。味微鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0172','羚羊角','Antelope Hom','平肝息風，清肝明目，散血解毒。用於高熱驚癇，神昏痙厥，子癇抽搐，癲癇發狂，頭痛眩暈，目赤翳障，溫毒發斑，癰腫瘡毒','鹹，寒','以質嫩、色白、光潤、內涵紅色斑紋且無裂紋者佳','羚羊角縱片：為縱向條狀薄片，類白色或黃白色，表面光滑，半透明，有光澤。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0173','牡蠣','Common Oyster Shell','重鎮安神，潛陽補陰，軟堅散結。用於驚悸失眠，眩暈耳鳴，瘰鬁痰核，症瘕痞塊。煆牡蠣收斂固澀。用於自汗盜汗，遺精崩帶，胃痛吞酸','鹹，微寒','以質堅、內面光潔、色白者為佳','近江牡蠣：呈圓形、卵圓形或三角形等。右殼外面稍不平，有灰、紫、棕、黃等色，環生同心鱗片，幼體者鱗片薄而脆，多年生長後鱗片層層相疊，內面白色，邊緣有的淡紫色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0174','牛黃','Bezoar','清心，豁痰，開竅，涼肝，息風，解毒。用於熱病神昏，中風痰迷，驚癇抽搐，癲癇發狂，咽喉腫痛，口舌生瘡，癰腫疔瘡','甘，涼','以完整鬆脆、棕黃色、斷面層紋清晰細膩者為佳','該品多呈卵形、類球形、三角形或四方形等，大小不一，直徑0.6~3(4.5)cm，少數呈管狀或碎片。表面黃紅色至棕黃色，有的表面掛有一層黑色光亮的薄膜，有的粗糙，具疣狀突起，有的具龜裂紋。體輕，質酥脆，易分層剝落，斷面金黃色，可見細密的同心層紋，有的夾有白心。氣清香，味苦而後甘，有清涼感，嚼之易碎，不粘牙')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0175','全蠍','Scorpion','息風鎮痙，攻毒散結，通絡止痛。用於小兒驚風，抽搐痙攣，中風口歪，半身不遂，破傷風，風濕頑痹，偏正頭痛，瘡瘍，瘰鬁','辛，平，有毒','以體大、肥壯、尾全、不破碎、腹中雜物少者為佳','該品頭胸部與前腹部呈扁平長橢圓形，後腹部呈尾狀，皺縮彎曲，完整者體長約6cm。頭胸部呈綠褐色，前面有1對短小的螯肢及1對較長大的鉗狀腳須，形似蟹螯，背面覆有梯形背甲，腹面有足4對，均為7節，末端各具2爪鉤；前腹部由 7節組成，第七節色深，背甲上有5 條隆脊線。背面綠褐色，後腹部棕黃色，6節，節上均有縱溝，末節有銳鉤狀毒刺，毒刺下方無距。氣微腥，味鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0176','桑螵蛸','Mantis Egg-case','益腎固精，縮尿，止濁。用於遺精滑精，遺尿尿頻，小便白濁','甘、咸，平','以完整、色黃、體輕帶韌性、卵未孵出者為佳','黑螵蛸：略呈平行四邊形，長2~4cm，寬1.5~2cm。表面灰褐色，上面帶狀隆起明顯，兩側有斜向紋理，近尾端微向上翹。質硬而韌')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0177','麝香','Abelmosk','開竅醒神，活血通經，消腫止痛。用於熱病神昏，中風痰厥，氣鬱暴厥中惡昏迷，經閉，癓瘕，難產死胎，心腹暴痛，癰腫瘰鬁，咽喉腫痛，跌撲傷痛，痹痛麻木','辛，溫','以飽滿、皮薄、有彈性、香氣濃者為佳','麝香仁：野生者質軟，油潤，疏鬆；其中顆粒狀者習稱“當門子”，呈不規則圓球形或顆粒狀，表面多呈紫黑色，油潤光亮，微有麻紋，斷面深棕色或黃棕色；粉末狀者多呈棕褐色或黃棕色，並有少量脫落的內層皮膜和細毛。飼養者呈顆粒狀、短條形或不規則的團塊；表面不平，紫黑色或深棕色，顯油性，微有光澤，並有少量毛和脫落的內層皮膜。氣香濃烈而特異，味微辣、微苦帶鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0178','石決明','Sea-ear Shell','平肝潛陽，清肝明目。用於頭痛眩暈，目赤翳障，視物昏花，青盲雀目','鹹，寒','以個大整齊、無破碎、殼厚、內面光彩鮮豔者為佳','白鮑：呈卵圓形，長11~14cm，寬8.5~11cm，高3~6.5cm。表面磚紅色，光滑，殼頂高於殼面，生長線頗為明顯，螺旋部約為殼面的1/3，疣狀突起30餘個，末端9個開孔，孔口與殼平')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0179','水牛角','Buffalo Horn','清熱，涼血，定驚，解毒。治傷寒溫疫熱入血分，驚狂，煩躁，譫妄，斑疹，發黃，吐血，衄血，下血，癰疽腫毒','苦、鹹，寒','以紋理緻密者為佳','形狀彎曲呈弧形，根部方形或略呈三角形，中空，一側表面有多數平行的凹紋，角端尖銳。色黑褐，質堅硬，剖面紋細而不顯，氣腥。一般多用其角尖部')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0180','磁石','Magnetite','平肝潛陽；安神鎮驚；聰耳明目；納氣平喘。主眩暈；目花；耳聾；耳鳴；驚悸；失眠，腎虛喘逆','鹹，寒','以斷面緻密有光澤、灰黑色、能吸鐵者為佳','晶體呈八面體、十二面體。晶面有條紋。多為粒塊狀集合體。鐵黑色，或具暗藍靛色。條痕黑，半金屬光澤。不透明。無解理。斷口不平坦。硬度5.5~6.5。密度5.16~5.18g/cm3。具強磁性。性脆。無臭，無味')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0181','滑石','Talc','利尿通淋，清熱解暑，祛濕斂瘡。用於熱淋，石淋，尿熱澀痛，暑濕煩渴，濕熱水瀉；外治濕疹，濕瘡，痱子','甘、淡，寒','以滑潤、色白者為佳','本品多為塊狀集合體。呈不規則的塊狀。白色、黃白色或淡藍灰色，有蠟樣光澤。質軟細膩，手摸有滑潤感，無吸濕性，置水中不崩散。無臭，無味')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0182','芒硝','Glauber’s Salt','破痞，溫中，消食，逐水，緩瀉。用於胃脘痞，食痞，消化不良，浮腫水腫，乳腫，閉經，便秘','鹹、苦，寒','以條塊狀結晶、無色透明者為佳','單斜晶系，晶體呈短柱狀或針狀；通常成緻密塊狀、纖維狀集合體。無色或白色，玻璃光澤，具完全的板面解理，莫氏硬度1.5~2，比重1.48。味清涼略苦咸，極易潮解，在乾燥的空氣中逐漸失去水分而轉變為白色粉末狀的無水芒硝。本品為棱柱狀、長方形或不規則塊狀及粒狀。無色透明或類白色半透明。質脆，易碎，斷面呈下班樣光澤。無臭，味鹹')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0183','雄黃','Red Orpiment','解毒殺蟲，燥濕祛痰，截瘧。用於癰腫疔瘡，蛇蟲咬傷，蟲積腹痛，驚癇，瘧疾','辛，溫，有毒','以塊大、紅色、質鬆脆為佳',') 和砷華，不溶于水和鹽酸，可溶於硝酸，溶液呈黃色')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0184','朱砂','Cinnabar','清心鎮驚，安神解毒，用於心悸易驚，失眠多夢，癲癇發狂，小兒驚風視物昏花，口瘡，喉痹，瘡瘍腫毒','甘，微寒，有小毒','以色鮮紅、有光澤、體重、質脆者為佳','三方晶系。為粒狀或塊狀集合體，呈顆粒狀或塊片狀。鮮紅色或暗紅色條痕紅色至褐紅色，具光澤。有平行的完全解理。斷口呈半貝殼狀或參差狀。硬度2~2.5。比重8.09~8.2。體重，質脆，片狀者易破碎，粉末狀者有閃爍的光澤，無味。金剛、半金屬、暗淡光澤。其中呈細小顆粒或粉末狀，色紅明亮，觸之不染手者，習稱“朱寶砂”；呈不規則板片狀、斜方形或長條形，大小厚薄不一，邊緣不整齊，色紅而鮮豔，光亮如鏡面而為透明，質較鬆脆者，習稱“鏡面砂”；方塊較大，方圓形或多角形，色發暗或呈灰褐色，質重而堅，不易碎者習稱“豆瓣砂”')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0185','石膏','Gypsum','清熱瀉火，除煩止渴。用於外感熱病，高熱煩渴。肺熱喘咳，胃火亢盛，頭痛，牙痛','甘、辛，大寒','以色白，體重，質軟。縱斷面具絹絲樣光澤者為佳','本品為纖維狀的集合體，呈長塊狀、板塊狀或不規則塊狀。白色、灰白色或淡黃色，有的半透明。體重，質軟。縱斷面具絹絲樣光澤。氣微，味淡')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0186','青黛','Natural Indigo','清熱，涼血消斑，解毒，清肝瀉火，定驚。主治溫病熱盛，斑疹，吐血咯血，小兒驚癇，瘡腫，丹毒，蛇蟲咬傷','鹹，寒','以藍色均勻、能浮於水面、火燒產生紫紅色煙霧時間較長者為佳','本品為極細的粉末，灰藍色或深藍色，質輕，易飛揚，可粘手粘紙。具草腥氣，味微酸')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0187','冰片','Synthetic Borneol','開竅醒神，清熱止痛。用於熱病神昏、痙厥，中風痰厥，氣鬱暴厥，中惡昏迷，目赤，口瘡，咽喉腫痛，耳道流膿','辛、苦，微寒','以片大、色潔白、質鬆脆、氣清香者為佳','梅花冰片：為半透明似梅花瓣塊狀、片狀的結晶體，故稱“梅片”；直徑0.1~0.7cm，厚約0.1cm類白色至淡灰棕色，氣清香，味清涼，嚼之慢慢溶化。燃燒時無黑煙或微有黑煙')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0188','五倍子','Chinese Nut-gall','斂肺；止汗；澀腸；固精；止血；解毒。主治肺虛久咳；自汗盜汗；久痢久瀉；脫肛；遺精；白濁；各種出血；癰腫瘡癤','酸、澀，寒','以個大、完整、壁厚、灰褐色者為佳','肚倍：呈長圓形或紡錘形囊狀，長2.5~9cm，直徑1.5~4cm。表面灰褐色或灰棕色，微有柔毛。質硬而脆，易破碎，斷面角質樣，有光澤，壁厚0.2~0.3cm，內壁平滑，有黑褐色死蚜蟲及灰色粉狀排泄物。氣物異，味澀')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0189','沉香','Tambac','行氣止痛，溫中止嘔，納氣平喘。用於胸腹脹悶疼痛，胃寒嘔吐呃逆，腎虛氣逆喘急','辛、苦，微溫','以體重、色棕黑油潤，燃之有油滲出、香氣濃烈者為佳','該品為不規則的塊狀、片狀或盔帽狀，有的為小碎塊。質較堅實。氣芳香，苦味。燃燒時有濃烈的香氣，並有黑色油狀物滲出')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0190','南棗','South Jujube','滋腎養肝、健腦安神、補脾養胃、活血強心、養顏烏髮、改善微循環和抗癌保健、潤心肺、止咳嗽、補五脈、治虛損之效','甘，温','皮色烏亮透紅，花紋細緻，肉質金黃，個大均勻，為棗中之珍品','果實橢圓形或球形，長2~3.5cm，直徑1.5~2.5cm。表面暗紅色，略帶光澤，有不規則皺紋。基部凹陷，有短果柄。外果皮薄，中果皮棕黃色或淡褐色，肉質，柔軟，富糖性而油潤。果核紡錘形，兩端銳尖，質堅硬。氣微香，味甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0191','黑杞子','Black Wolfberry Fruit','補腎益精、護肝明目、增進視力、美容養顏、改善皮膚','甘，平','青海出產的九葉藍野生黑枸杞為最佳','紫黑色，球狀，有時頂端稍凹陷，直徑4-9毫米')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0192','黨參','Pilose Asiabell Root','補中益氣，健脾益肺。用於脾肺虛弱，氣短心悸，食少便溏，虛喘咳嗽，內熱消渴','甘、微酸，性平','以條粗長、質柔潤、氣味濃，“化渣”者為佳','呈長圓柱形，稍彎曲，長10~35cm，直徑0.4~2cm。根上端1~3cm部分有環紋，質稍軟，斷面裂隙少。味微酸。根頭部有多數疣狀突起的莖痕的頂端呈凹下的圓點狀；根頭下有緻密的環狀橫紋，向下漸稀疏，有的達全長的一半，栽培品環紋少或無；全體有縱皺紋及散在的橫長皮孔，支根斷落處常有黑褐色膠狀物。質稍硬或略帶韌性，斷面稍平坦，有裂隙或放射狀紋理，皮部淡黃白色至淡棕色，木部淡黃色。有特殊香氣，味微甜')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0193','夜交藤','Tuber Fleeceflower Stem','養心安神，祛風，通絡。 用於失眠，多夢，血虛身痛，肌膚麻木，風濕痺痛，風疹瘙癢。 ','味甘、微苦，性平。 ','枝條粗壯，均勻，外皮棕紅色者為佳','藤莖長圓柱形，稍扭曲，長短不一，直徑3-7mm。表面棕紅色或棕褐色，粗糙，有明顯扭曲的縱皺紋及細小圓形皮孔。節部略膨大，有分枝痕。外皮菲薄，可剝離。質脆，易折斷，斷面皮部棕紅色，木部淡黃色，導管孔明顯，中央為白色疏鬆的髓部。氣無，味微苦、澀。以枝條粗壯，均勻，外皮棕紅色者為佳')");
    await db.execute(
        "INSERT INTO $herbTable($colHerbID, $colChName, $colEngName, $colEffect, $colTaste, $colQulity, $colShape) VALUES('0194','熟地黃','Processed Rehmannia Root','熟地黃滋陰補血，益精填髓。可用于陰虛發熱，消渴，吐血，衄血，血崩，月經不調，胎動不安，陰傷便秘等症','熟地黃甘，微溫','熟地黃以軟塊大、內外烏黑有光澤者為佳','熟地黃：為不規則的塊片、碎塊，大小、厚薄不一。表面烏黑色，有光澤，粘性大。質柔軟而帶韌性，不易折斷，端面烏黑色，有光澤。味甜')");
  }

  //Fetch all herb

  Future<List<Map<String, dynamic>>> getHerbMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $herbTable');
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
}
