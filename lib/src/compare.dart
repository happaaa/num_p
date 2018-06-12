import 'class/num_p.dart';


num compare_list(List a, List b) {
  if (a.length > b.length) return 1;
  else if (a.length < b.length) return 0;
  else {
    for (var i = 0; i < a.length; i++) {
      if (a[i] > b[i]) return 1;
      if (a[i] < b[i]) return 0;
    }
    return 2;
  }
}
