import 'package:json_annotation/json_annotation.dart';
import 'package:jsonapi_client/src/ref.dart';

part 'relationship.g.dart';

@JsonSerializable()
class JsonApiRelationship {
  final Map<String, String> links;

  @JsonKey(name: "data", fromJson: _deserializeResourceRefs)
  final List<JsonApiResourceRef> refs;

  JsonApiRelationship({this.links, this.refs});
  factory JsonApiRelationship.fromJson(json) => _$JsonApiRelationshipFromJson(json);
}

List<JsonApiResourceRef> _deserializeResourceRefs(Object json) {
  if (json is List) {
    return json.map((e) => JsonApiResourceRef.fromJson(e)).toList();
  } else if (json is Map<String, dynamic>) {
    return [JsonApiResourceRef.fromJson(json)];
  } else {
    return null;
  }
}