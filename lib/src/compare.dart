/*
 * comparison functions:
 * compare_list()
 * min()
 * max()
 */

import 'format.dart';

num compare_list(List a, List b) {
  a = leadingzeroslist(a);
  b = leadingzeroslist(b);
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

List maximum(List a, List b) {
  if (a.length > b.length) return a;
  else if (a.length < b.length) return b;
  else {
    for (var i = 0; i < a.length; i++) {
      if (a[i] > b[i]) return a;
      if (a[i] < b[i]) return b;
    }
    return a;
  }
}

List minimum(List a, List b) {
  if (a.length > b.length) return b;
  else if (a.length < b.length) return a;
  else {
    for (var i = 0; i < a.length; i++) {
      if (a[i] > b[i]) return b;
      if (a[i] < b[i]) return a;
    }
    return a;
  }
}
