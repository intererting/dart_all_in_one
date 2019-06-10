import 'dart:async';

main() async {
  var completer = Completer();

  var future = completer.future;

  future.then((value) {
    print(value);
  });

  future.whenComplete(() {
    print('futureComplete');
  });

  completer.complete("xxxx");
}
