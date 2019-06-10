void main() {
  var human = Human('yuliyang');
  print(human is Student);
}

class Human {
  const factory Human(String name) = Student;
}

class Student implements Human {
  final String name;

  const Student(this.name);
}
