import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'dart:async';

void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
  String a = null;
}

class B {
  const B.constCreate();

  final String name = "haha";
}

class C {
  C.initFromJson(Map<String, String> jsonMap) : name = jsonMap["name"] {
    print(name);
  }

  String name;
}

class D {
  say() {
    print('say in D');
  }
}

class E {
//  say() {
//    print("say in E");
//  }
}

mixin F on E {
  say() {
    print('say in mixinF');
  }
}

class G extends E with F {}

class H {
  H(int f()) {}
}

int say() {}

runningInMicroTask() {
  print('runningInMicroTask');
}

testParam(String name, {int age, double height}) {
  print('age  $age  height  $height');
}

testParamA(String name, [int age]) {
  print('age  $age');
}

testParamB(void test(int age), int age) {
  test(age);
}

void testParamC(int age) {
  print('age   $age');
}

main() {
//  testParamB(testParamC, 1);

//  testParamA("haha");

//  scheduleMicrotask(() {
////    print("haha");
//    runningInMicroTask();
//  });

//  var task = Future.microtask(() {
//    return Future.value(1);
//  });
//  task.then((value) => print(value));

//  var dateTime=DateTime.now();
//  print(dateTime.toIso8601String());
}

Function printMsg = (msg) => print("this is $msg");

void foreach(int a) {
  print(a);
}

int test() {
  return 3;
}

int test1() => 1;

int test2(int a) => a;

int test3({int a}) => a;

int test4({@required int a}) => a;

String test5([String name]) => name;

printTest(String test) {
  print(test);
}
