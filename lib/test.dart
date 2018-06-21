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
        expect(stringlong.val, equals([true, [123456789123, 456789987654321], [123456987654321, 123456789998765, 432100000000000]]));
    });
    test("number", () {
      var doublelong = new Longnum.number(132654789.924785);
      var intlong = new Longnum.number(-927618345926405);
      expect(doublelong.val, equals([false, [132654789], [924785000000000]]));
      expect(intlong.val, equals([true, [927618345926405], [0]]));
    });
  });

  group("Comparison operations:", () {
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
      expect(stringlong <= intlong, equals(false));
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
  
  group("Arithmetic operations:", () {
    var A = new Longnum.string('12');
    var B = new Longnum.string('183492765672943811834927667381943');
    var C = new Longnum.string('18349276.34178895');
    var D = new Longnum.string('0.555555555963489284464');
    var E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
    var F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
    group("Addition:", () {
      test("A + B", () {

      });

    });
  });


}

void main() {
  newtest();
}
