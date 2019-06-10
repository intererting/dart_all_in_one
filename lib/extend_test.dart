void main() {
  Father father = Son("yuliyang");
  print(father.name);
}

class Father {
  String name;

  Father(this.name);
}

class Son extends Father {
  Son(name) : super(name);
}

class SonA implements Father {
  @override
  String name;
}
