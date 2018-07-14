import 'package:json_annotation/json_annotation.dart';

part 'ref.g.dart';

@JsonSerializable()
class JsonApiResourceRef {
  final String type;
  final String id;

  JsonApiResourceRef({this.type, this.id});
  factory JsonApiResourceRef.fromJson(Map<String, dynamic> json) => _$JsonApiResourceRefFromJson(json);
}