import 'package:longnum/longnum.dart';

final A = new Longnum.string('12');
final B = new Longnum.string('183492765672943811834927667381943');
final C = new Longnum.string('18349276.34178895');
final D = new Longnum.string('0.555555555963489284464');
final E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
final F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
final G = new Longnum.string('0');

void newtest() {

  group("Initialization:", () {
    test("default empty", () {
      var newlong = new Longnum();
      expect(newlong.val, equals([false, [0], [0]]));
    });
    test("string", () {
        var stringlong = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
        var newlong = new Longnum();
        newlong.value = '-123456789123456789987654321.1234569876543211234567899987654321';
        expect(newlong == stringlong, equals(true));
        expect(stringlong.val, equals([true, [123456789123, 456789987654321],
          [123456987654321, 123456789998765, 432100000000000]]));
    });
    test("number", () {
      var doublelong = new Longnum.number(132654789.924785);
      var intlong = new Longnum.number(-927618345926405);
      expect(doublelong.val, equals([false, [132654789], [924785000000000]]));
      expect(intlong.val, equals([true, [927618345926405], [0]]));
    });
  });

  group("Comparison:", () {
    var stringlong = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
    var newlong = new Longnum();
    newlong.value = '-123456789123456789987654321.1234569876543211234567899987654321';
    var doublelong = new Longnum.number(132654789.924785);
    var doublong = new Longnum.number(132654789.924784);
    var intlong = new Longnum.number(-927618345926405);
    test("==", () {
        expect(newlong == stringlong, equals(true));
        expect(stringlong == intlong, equals(false));
        expect(doublelong == doublong, equals(false));
    });
    test("<", () {
      expect(intlong < doublelong, equals(true));
      expect(intlong < stringlong, equals(false));
      expect(stringlong < doublelong, equals(true));
    });
    test("<=", () {
      expect(newlong <= stringlong, equals(true));
      expect(intlong <= doublelong, equals(true));
      expect(stringlong <= doublelong, equals(true));
      expect(stringlong <= intlong, equals(true));
      expect(doublelong <= doublong, equals(false));
    });
    test(">", () {
      expect(doublelong > intlong, equals(true));
      expect(doublelong > doublong, equals(true));
      expect(newlong > stringlong, equals(false));
      expect(stringlong > newlong, equals(false));
    });
    test(">=", () {
      expect(newlong >= stringlong, equals(true));
      expect(intlong >= doublelong, equals(false));
      expect(doublelong >= doublong, equals(true));
    });
  });

  group("Arithmetic:", () {
    group("Addition:", () {
      test("A + B", () {
        expect((A + B).val, equals([false, [183, 492765672943811, 834927667381955], [0]]));
        expect(B + A, equals(A + B));
      });
      test("B + C", () {
        expect((B + C).val, equals([false, [183, 492765672943811, 834927685731219], [341788950000000]]));
        expect(C + B, equals(B + C));
      });
      test("C + D", () {
        expect((C + D).val, equals([false, [18349276], [897344505963489, 284464000000000]]));
        expect(D + C, equals(C + D));
      });
      test("D + E", () {
        expect((D + E).val, equals([false, [123456, 789987654321123, 456789987654321],
          [739048321636433, 173459656000000]]));
        expect(E + D, equals(D + E));
      });
      test("E + F", () {
        expect((E + F).val, equals([false, [123456, 789864197532000, 000000000000000],
          [60035778018622, 765538866001234, 567900000000000]]));
        expect(F + E, equals(E + F));
      });
      test("F + G", () {
        expect((F + G).val, allOf([
          equals([true, [123456789123, 456789987654321], [123456987654321, 123456789998765, 432100000000000]]),
          equals(F.val)
        ]));
        expect(G + F, equals(F));
      });
      test("G + G", () {
        expect((G + G).val, equals([false, [0], [0]]));
      });
    });
    group("Subtraction:", () {
      test("A - B", () {
        expect((A - B).val, equals([true, [183, 492765672943811, 834927667381931], [0]]));
      });
      test("B - A", () {
        expect((B - A).val, allOf([
          equals([false, [183, 492765672943811, 834927667381931], [0]]),
          equals((A - B).abs().val)
        ]));
      });
      test("B - C", () {
        expect((B - C).val, allOf([
          equals([false, [183, 492765672943811, 834927649032666], [658211050000000]]),
          equals((C - B).abs().val)
        ]));
      });
      test("C - B", () {
        expect((C - B).val, equals([true, [183, 492765672943811, 834927649032666], [658211050000000]]));
      });
      test("C - D", () {
        expect((C - D).val, allOf([
          equals([false, [18349275], [786233394036510, 715536000000000]]),
          equals((D - C).abs().val)
        ]));      });
      test("D - C", () {
        expect((D - C).val, equals([true, [18349275], [786233394036510, 715536000000000]]));
      });
      test("D - E", () {
        expect((D - E).val, equals([true, [123456, 789987654321123, 456789987654320],
          [627937209709454, 604531656000000]]));
      });
      test("E - D", () {
        expect((E - D).val, allOf([
          equals([false, [123456, 789987654321123, 456789987654320], [627937209709454, 604531656000000]]),
          equals((D - E).abs().val)
        ]));
      });
      test("E - F", () {
        expect((E - F).val, allOf([
          equals([false, [123456, 790111111110246, 913579975308642],
            [306949753327265, 012452445998765, 432100000000000]]),
          equals((F - E).abs().val)
        ]));
      });
      test("F - E", () {
        expect((F - E).val, equals([true, [123456, 790111111110246, 913579975308642],
          [306949753327265, 012452445998765, 432100000000000]]));
      });
      test("F - G", () {
        expect((F - G).val, allOf([
          equals([true, [123456789123, 456789987654321], [123456987654321, 123456789998765, 432100000000000]]),
          equals(F.val)
        ]));
      });
      test("G - F", () {
        expect((G - F).val, equals(F.abs().val));
      });
    });
    group("Multiplication:", () {
      test("A * B", () {
        expect((A * B).val, equals([false, [2201, 913188075325742, 019132008583316], [0]]));
        expect(B * A, equals(A * B));
      });
      test("B * C", () {
        expect((B * C).val, equals([false, [3366959464, 051971447802663, 064884970283691], [546929850000000]]));
        expect(C * B, equals(B * C));
      });
      test("C * D", () {
        expect((C * D).val, equals([false, [10194042], [419590260943099, 688937201872800]]));
        expect(D * C, equals(C * D));
      });
      test("D * E", () {
        expect((D * E).val, equals([false, [68587, 105599059033767, 317641733126802],
          [744670961582778, 373181385190721, 926043044288384]]));
        expect(E * D, equals(D * E));
      });
      test("E * F", () {
        expect((E * F).val, equals([true, [15, 241578887364731, 121932632103337, 930316663477084, 619489134400930],
          [858009457967701, 281500146881214, 410836713975280, 384799862957600]]));
        expect(F * E, equals(E * F));
      });
      test("F * G", () {
        expect((F * G).val, equals([false, [0], [0]]));
        expect(G * F, equals(F * G));
      });
    });
    group("Division:", () {
      test("A / B", () {
        expect((A / B).val, equals([false, [0], [0]]));
      });
      test("B / A", () {
        expect((B / A).val, equals([false, [15, 291063806078650, 986243972281828], [583333333333333, 333333333333333]]));
      });
      test("B / C", () {
        expect((B / C).val, equals([false, [10000000122, 896089732935631], [817631005357666, 819734941216915]]));
      });
      test("C / B", () {
        expect((C / B).val, equals([false, [0], [0, 99999]]));
      });
      test("C / D", () {
        expect((C / D).val, equals([false, [33028697], [390967774562165, 29977275907862, 196293499299995]]));
      });
      test("D / C", () {
        expect((D / C).val, equals([false, [0], [30276701, 141519010986614, 176485583222132]]));
      });
      test("D / E", () {
        expect((D / E).val, equals([false, [0], [0, 0, 4500000008, 254263208288089]]));
      });
      test("E / D", () {
        expect((E / D).val, equals([false, [222222, 221814604286758, 150432090876836],
          [157603391043587, 773370333107370, 402876620252402, 648994730906152]]));
      });
      test("E / F", () {
        expect((E / F).val, equals([true, [1000000007],
          [58900000, 482590002367655, 298746017666487, 178908288343501, 972379620735363]]));
      });
      test("F / E", () {
        expect((F / E).val, equals([true, [0],
          [999999, 992999999990099, 999999010001600, 514711459918374, 162750420530618]]));
      });
      /*test("F / G", () {
        expect(F / G, throwsA(Exception));
      });*/
      test("G / F", () {
        expect((G / F).val, equals([false, [0], [0]]));
      });
    });
  });

  group("Exponential:", () {
    group("Power:", () {
      test("A^2", () {
        expect(A.power(2).val, equals([false, [144], [0]]));
        expect(A.power(2), equals(A * A));
      });
      test("B^2", () {
        expect(B.power(2).val, equals([false, [33669, 595054305866899, 314576412748598, 776584439769398, 444979842455249], [0]]));
        expect(B.power(2), equals(B * B));
      });
      test("C^2", () {
        expect(C.power(2).val, equals([false, [336695942267335], [671420086342102, 500000000000000]]));
        expect(C.power(2), equals(C * C));
      });
      test("D^2", () {
        expect(D.power(2).val, equals([false, [0], [308641975761901, 674262212396316, 950711767296000]]));
        expect(D.power(2), equals(D * D));
      });
      test("E^2", () {
        expect(E.power(2).val, equals([false, [15241578994, 55784231214753, 778082609462011, 626245874865449, 437710393224037],
          [496220853985681, 892475337462594, 277784492386870, 336000000000000]]));
        expect(E.power(2), equals(E * E));
      });
      test("F^2", () {
        expect(F.power(2).val, equals([false, [15241578, 780673678759487, 883249809528782, 045058338362698],
          [387593621124867, 618960577926474, 591952781554793, 476620059442157, 899710410000000]]));
        expect(F.power(2), equals(F * F));
      });
      test("G^2", () {
        expect(G.power(2).val, equals([false, [0], [0]]));
        expect(G.power(2), equals(G * G));
      });
      test("A^3", () {
        expect(A.power(3), equals(A * A * A));
      });
      test("B^3", () {
        expect(B.power(3), equals(B * B * B));
      });
      test("C^3", () {
        expect(C.power(3), equals(C * C * C));
      });
      test("D^3", () {
        expect(D.power(3), equals(D * D * D));
      });
      test("E^3", () {
        expect(E.power(3), equals(E * E * E));
      });
      test("F^3", () {
        expect(F.power(3), equals(F * F * F));
      });
      test("G^3", () {
        expect(G.power(3), equals(G * G * G));
      });
    });
    /*group("EXP:", () {
      test("e^2", () {
        expect(exponential(2).val, equals([false, [7], [389056098930650, 227230427460575, 7813180315570, 551847324087127,
           822522573796079, 057763384312485, 079121794773753, 161265478866123]]));
      });
    });*/
    /*group("Square root:", () {
      var precision = new Longnum.string('0.00000001');
      test("sqrt(A)", () {
        expect(A.squareroot(precision).val, equals([false, [3], [464101615137754, 587054892683011]]));
      });
      test("sqrt(B)", () {
        expect(B.squareroot(precision).val, equals([false, [13, 545950157628065], [473012990695280, 614867858464199]]));
      });
      test("sqrt(C)", () {
        expect(C.squareroot(precision).val, equals([false, [4283], [605530600238404, 730011852595489]]));
      });
    });*/
  });


}

void timetest() {
  var pi = new Longnum.string(
  '54159265358979323846264338327950288419716939937510'
  '58209749445923078164062862089986280348253421170679'
  '82148086513282306647093844609550582231725359408128'
  '48111745028410270193852110555964462294895493038196'
  '44288109756659334461284756482337867831652712019091'
  '45648566923460348610454326648213393607260249141273'
  '72458700660631558817488152092096282925409171536436'
  '78925903600113305305488204665213841469519415116094'
  '33057270365759591953092186117381932611793105118548'
  '07446237996274956735188575272489122793818301194912'
  '98336733624406566430860213949463952247371907021798'
  '60943702770539217176293176752384674818467669405132'
  '00056812714526356082778577134275778960917363717872'
  '14684409012249534301465495853710507922796892589235'
  '42019956112129021960864034418159813629774771309960'
  '51870721134999999837297804995105973173281609631859'
  '50244594553469083026425223082533446850352619311881'
  '71010003137838752886587533208381420617177669147303'
  '59825349042875546873115956286388235378759375195778'
  '18577805321712268066130019278766111959092164201989');
  var ee = new Longnum.string(
  '0.718281828459045235360287471352662497757247093699959574966967627724076630353'
  '547594571382178525166427427466391932003059921817413596629043572900334295260'
  '595630738132328627943490763233829880753195251019011573834187930702154089149'
  '934884167509244761460668082264800168477411853742345442437107539077744992069'
  '551702761838606261331384583000752044933826560297606737113200709328709127443'
  '747047230696977209310141692836819025515108657463772111252389784425056953696'
  '770785449969967946864454905987931636889230098793127736178215424999229576351'
  '482208269895193668033182528869398496465105820939239829488793320362509443117'
  '301238197068416140397019837679320683282376464804295311802328782509819455815'
  '301756717361332069811250996181881593041690351598888519345807273866738589422'
  '879228499892086805825749279610484198444363463244968487560233624827041978623'
  '209002160990235304369941849146314093431738143640546253152096183690888707016'
  '768396424378140592714563549061303107208510383750510115747704171898610687396'
  '965521267154688957035035402123407849819334321068170121005627880235193033224');
  var count = 200;
  var tester = new Longnum();
  var testerdeci = new Longnum();
  var time = new Stopwatch();
  print('ADD');
  for (var i = 1; i <= 0; i++) {
    tester.integer = pi.integer.sublist(0, i);
    testerdeci.decimal = ee.decimal.sublist(0, i);
    time.start();
    for (var i = 0; i < count; i++) {
      tester + testerdeci;
    }
    time.stop();
    print('${time.elapsedMicroseconds / count}');
    time.reset();
  }
  print('SUBTRACT');
  for (var i = 1; i <= 0; i++) {
    tester.integer = pi.integer.sublist(0, i);
    testerdeci.decimal = ee.decimal.sublist(0, i);
    time.start();
    for (var i = 0; i < count; i++) {
      tester - testerdeci;
    }
    time.stop();
    print('${time.elapsedMicroseconds / count}');
    time.reset();
  }
  print('MULTIPLY');
  for (var i = 1; i <= 0; i++) {
    tester.integer = pi.integer.sublist(0, i);
    testerdeci.decimal = ee.decimal.sublist(0, i);
    time.start();
    for (var i = 0; i < count; i++) {
      tester * testerdeci;
    }
    time.stop();
    print('${time.elapsedMicroseconds / count}');
    time.reset();
  }
  print('DIVIDE');
  for (var i = 1; i <= 0; i++) {
    tester.integer = pi.integer.sublist(0, i);
    testerdeci.decimal = ee.decimal.sublist(0, i);
    time.start();
    for (var i = 0; i < count; i++) {
      tester / testerdeci;
    }
    time.stop();
    print('${time.elapsedMicroseconds / count}');
    time.reset();
  }
  print('SQUAREROOT');
  for (var i = 1; i <= 10; i++) {
    tester.integer = pi.integer.sublist(0, i);
    //testerdeci.decimal = ee.decimal.sublist(0, i);
    time.start();
    for (var i = 0; i < 1; i++) {
      tester.squareroot();
    }
    time.stop();
    print('${time.elapsedMicroseconds / 1}');
    time.reset();
  }
}



void main() {
  //newtest();
  timetest();
}
