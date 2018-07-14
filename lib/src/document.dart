// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:jsonapi_client/src/ref.dart';

import 'resource.dart';
import 'error.dart';

part 'document.g.dart';

/// Dartlang representation of a JSON API Document object.
/// Conforms to the JsonApi 1.0 specification.
/// For any further information please visit http://jsonapi.org
@JsonSerializable(includeIfNull: false)
class JsonApiDocument extends Object with _$JsonApiDocumentSerializerMixin {
  List<JsonApiError> errors;

  @JsonKey(fromJson: _resourcesFromJson, toJson: _resourcesToJson)
  List<JsonApiResource> data;

  List<JsonApiResource> included;

  Map<String, dynamic> meta;

  JsonApiDocument(): super();
  factory JsonApiDocument.fromJson(Map<String, dynamic> json) {
    var doc = _$JsonApiDocumentFromJson(json);
    if (doc.data != null && doc.errors != null) {
      throw new FormatException("Cannot have both errors and data");
    }
    if (doc.data == null && doc.errors == null && doc.meta == null) {
      throw new FormatException("Must include at least one of data, errors, meta");
    }
    if (doc.data == null && doc.included != null) {
      throw new FormatException("included cannot be present if data is not");
    }
    return doc;
  }

  JsonApiResource findIncluded(JsonApiResourceRef ref) {
    return this.included.firstWhere((resource) => resource.type == ref.type && resource.id == ref.id);
  }
}

List<JsonApiResource> _resourcesFromJson(Object deserialized) {
  if (deserialized is List) {
    return deserialized.map((e) => JsonApiResource.fromJson(e)).toList();
  } else if (deserialized is Map<String, dynamic>) {
    return [JsonApiResource.fromJson((deserialized))]; 
  } else {
    return null;
  }
}

Object _resourcesToJson(List<JsonApiResource> data) {
  if (data.length == 1) {
    return data[0].toJson();
  }
  return data.map((e) => e.toJson()).toList();
}