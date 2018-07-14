// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:jsonapi_client/src/relationship.dart';

part 'resource.g.dart';

/// Dartlang representation of a JSON API Document object.
/// Conforms to the JsonApi 1.0 specification.
/// For any further information please visit http://jsonapi.org
@JsonSerializable(includeIfNull: false)
class JsonApiResource extends Object with _$JsonApiResourceSerializerMixin {
  /// The id of the JSON API Resource.
  /// The id is not required when the resource object originates at the
  /// client and represents a new resource to be created on the server.
  String id;

  /// The type of the JSON API Resource
  @JsonKey(nullable: false)
  String type;

  /// The attributes of the JSON API Resource, represented as a Map.
  Map<String, Object> attributes;

  /// The links of the JSON API Resource, represented as a Map.
  Map<String, dynamic> links;

  /// The relationships of the JSON API Resource, represented as a Map.
  Map<String, JsonApiRelationship> relationships;

  JsonApiResource() : super();
  factory JsonApiResource.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('type') || json['type'] == null) {
      throw new FormatException("Resource object has no type");
    }

    return _$JsonApiResourceFromJson(json);
  }
}
