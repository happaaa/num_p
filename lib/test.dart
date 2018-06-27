import 'longnum.dart';

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
    var A = new Longnum.string('12');
    var B = new Longnum.string('183492765672943811834927667381943');
    var C = new Longnum.string('18349276.34178895');
    var D = new Longnum.string('0.555555555963489284464');
    var E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
    var F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
    var G = new Longnum.string('0');
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
        ]));
      });
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



}

void main() {
  newtest();
}
