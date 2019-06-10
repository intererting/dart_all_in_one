mixin A {
  void printTest() {
    print('in mixin A');
  }
}

mixin B {
  void printTest() {
    print('in mixin B');
  }
}

class TestMixin with B, A {}

void main() {
  var testMixin = TestMixin();
  testMixin.printTest();
}
