import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

main() {
//  testZoneError();
//  testStreamTransform();
//  testPassParamInZone();
//  zoneExceptionTest();
  testTask();
}

/**
 * zone只能捕获zone里面声明的异常，1 处不能捕获，2 可以捕获
 */
void testZoneError() {
//  var f = Future.error(499); //1
//  f = f.whenComplete(() {
//    print('Outside runZoned');
//  });
//  f.catchError((e) => print(e));
  runZoned(() {
    var f = new Future.error(499); //2
    f = f.whenComplete(() {
      print('Inside error zone (not called)');
    });
  }, onError: printError);
}

void printError(dynamic error) {
  print('catch error');
}

/**
 * 测试自定义Transform
 */
void testStreamTransform() {
  // Use as follows:
  Stream.fromIterable(List.generate(3, (it) => it))
      .transform(transformToString)
      .listen(print, cancelOnError: false, onError: print);
}

// Starts listening to [input] and duplicates all non-error events.
StreamSubscription<String> _onListen(Stream<int> input, bool cancelOnError) {
  StreamSubscription<int> subscription;
  // Create controller that forwards pause, resume and cancel events.
  var controller = new StreamController<String>(
      onPause: () {
        subscription.pause();
      },
      onResume: () {
        subscription.resume();
      },
      onCancel: () => subscription.cancel(),
      sync: true); // "sync" is correct here, since events are forwarded.

  subscription = input.listen((int data) {
    controller.add("$data after transform");
  },
      onError: controller.addError,
      onDone: controller.close,
      cancelOnError: cancelOnError);

  // Return a new [StreamSubscription] by listening to the controller's
  // stream.
  return controller.stream.listen(null);
}

// Instantiate a transformer:
var transformToString = const StreamTransformer<int, String>(_onListen);

Future splitLinesStream(Stream stream) {
  return stream
      .transform(Utf8Decoder())
      .transform(const LineSplitter())
      .map((line) => '${Zone.current[#filename]}: $line') //Add
      .toList();
}

Future splitLines(filename) {
  return runZoned(() {
    //Add
    return splitLinesStream(new File(filename).openRead());
  }, zoneValues: {#filename: filename}); //Add
}

/**
 * 在Zone里面传递参数
 */
void testPassParamInZone() {
  Future.forEach(
      ['d:\\test.txt', 'd:\\testA.txt'],
      (file) => splitLines(file).then((lines) {
            lines.forEach(print);
          }));
}

/**
 * 在Zone里面重写方法
 */
void overrideFunInZone() {
  runZoned(() {
    print('Will be ignored');
  }, zoneSpecification:
      new ZoneSpecification(print: (self, parent, zone, message) {
    // Ignore message.
//    parent.print(zone, message);
  }));
}

Future zoneExceptionTest() {
  runZoned(() {
//    throw Exception("sync error");
//    return new Future(() {
////    throw Exception("async error");
//      return print("xxx");
//    }).catchError(print);

    Future.error("hehe error");
  }, onError: print);
}

//首先，f1、f2和f3会将任务添加到事件队列中，而且then()注册的函数并不会被添加到队列，也不会直接运行。
// 接着完成计算，在f2.then中，new Future会将任务添加到事件队列，
// f1因为已经完成计算，因此f3.then会将任务添加到微任务队列，先于new Future打印信息
void testTask() async {
  Future f1 = new Future(() => null);
  Future f2 = new Future(() => null);
  Future f3 = new Future(() => null);

  f1.whenComplete(() {
    print('f1 conplete');
  });

  f2.whenComplete(() {
    print('f2 conplete');
  });

  f3.whenComplete(() {
    print('f3 conplete');
  });

  f3.then((_) => print("f3 then"));

  f2.then((_) {
    print("f2 then");
    new Future(() => print("new Future befor f1 then"));
    f1.then((_) {
      print("f1 then");
    });
  });
}

//main() {
//  print('1');
//  scheduleMicrotask(() => print('microtask 1'));
//
//  new Future.delayed(new Duration(seconds: 1), () => print('delayed'));
//  new Future(() => print('future 1'));
//  new Future(() => print('future 2'));
//
//  scheduleMicrotask(() => print('microtask 2'));
//
//  print('2');
//}

//Stream get asynchronousNaturals async* {
//  print("Begin");
//
//  int k = 0;
//  while (k < 3) {
//    print("Before Yield");
//    yield k++;
//  }
//
//  print("End");
//}
//
//main() {
//  StreamSubscription subscription = asynchronousNaturals.listen(null);
//  subscription.onData((value) {
//    print(value);
//  });
//}

Iterable naturalsDownFrom(n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

//main() {
//  for (var i in naturalsDownFrom(3)) {
//    print(i);
//  }
//  print(naturalsDownFrom(3)
//      .firstWhere((value) => value % 2 == 0, orElse: () => 8));
//  var logger = Logger("zone_test");
//  logger.info("info message");
//  Logger log = new Logger(r"main");
//
//  Logger.root.level = Level.WARNING;
//  Logger.root.onRecord.listen((LogRecord rec) {
//    print('${rec.level.name}: ${rec.time}: ${rec.message}');
//    if (rec.error != null && rec.stackTrace != null) {
//      print('${rec.error}: ${rec.stackTrace}');
//    }
//  });
//
//  log.config("x=5");
//  log.info("对x进行赋值");
//  log.warning("x是double类型");
//  log.severe("网络连接失败");
//}
