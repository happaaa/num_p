import 'package:longnum/longnum.dart';

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

  var A = new Longnum.string('12');
  var B = new Longnum.string('183492765672943811834927667381943');
  var C = new Longnum.string('18349276.34178895');
  var D = new Longnum.string('0.555555555963489284464');
  var E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
  var F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
  var G = new Longnum.string('0');
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
      });
      test("B^2", () {
        expect(B.power(2).val, equals([false, [33669, 595054305866899, 314576412748598, 776584439769398, 444979842455249], [0]]));
      });
      test("C^2", () {
        expect(C.power(2).val, equals([false, [336695942267335], [671420086342102, 500000000000000]]));
      });
      test("D^2", () {
        expect(D.power(2).val, equals([false, [0], [308641975761901, 674262212396316, 950711767296000]]));
      });
      test("E^2", () {
        expect(E.power(2).val, equals([false, [15241578994, 55784231214753, 778082609462011, 626245874865449, 437710393224037],
          [496220853985681, 892475337462594, 277784492386870, 336000000000000]]));
      });
      test("F^2", () {
        expect(F.power(2).val, equals([false, [15241578, 780673678759487, 883249809528782, 045058338362698],
          [387593621124867, 618960577926474, 591952781554793, 476620059442157, 899710410000000]]));
      });
      test("G^2", () {
        expect(G.power(2).val, equals([false, [0], [0]]));
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
  var A = new Longnum.string('123456789456123456789456123456789456123456789456123456789456123456789123456789456123456789451234567843186845137');
  var B = new Longnum.string('9423874815368484510004894514848.4048484648004864964531287979421201234897100048879878945642123123878945181897897978');
  var C = new Longnum.string('18349276.34178895');
  var D = new Longnum.string('0.555555555963489284464');
  var E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
  var F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
  var watch = new Stopwatch();
  print('Addition');
  watch.start();
  for (var i = 0; i < 1000; i++) {
    A + B + A + B;
    B + A;
  }
  watch.stop();
  print(watch.elapsedMicroseconds / 1000);
  print('Subtraction');
  watch.reset();
  watch.start();
  for (var i = 0; i < 1000; i++) {
    A - B - A - B;
    B - A;
  }
  watch.stop();
  print(watch.elapsedMicroseconds / 1000);
  print('Multi');
  watch.reset();
  watch.start();
  for (var i = 0; i < 1000; i++) {
    A * B * A * B;
    B * A;
  }
  watch.stop();
  print(watch.elapsedMicroseconds / 1000);
  print('Div');
  watch.reset();
  watch.start();
  for (var i = 0; i < 1000; i++) {
    A / B / A / B;
    B / A;
  }
  watch.stop();
  print(watch.elapsedMicroseconds / 1000);
}

void main() {
  //newtest();
  timetest();
}
