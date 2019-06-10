import 'package:json_annotation/json_annotation.dart';

part 'json_serializer.g.dart';

//flutter packages pub run build_runner build
@JsonSerializable()
class Person {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'age')
  int age;

  Person(
    this.name,
    this.age,
  );

  factory Person.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
