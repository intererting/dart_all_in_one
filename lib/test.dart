import 'package:flutter/material.dart';

void main() {
//  try {
//    throw Exception("测试");
//  } on Exception {
//    print('on Exception');
//  } catch (e) {
//    print('$e');
//  }
  testFun((String name) {
    print(name);
  });
}

void testFun(void say(String name), {bool judge()}) {
  say("haha");
}

abstract class Animal {
  void say() {
    print('say');
  }
}

class Dog extends Animal {}

class Human {
  var name;

  Human(this.name);

  void test() {
    print('xxx');
  }
}

class Man implements Human {
  @override
  get name => null;

  @override
  void set name(_name) {}

  @override
  String test() {
    return null;
  }
}
