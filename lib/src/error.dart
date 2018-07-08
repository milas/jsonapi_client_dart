// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonApiError extends Object with _$JsonApiErrorSerializerMixin {
  /// The id of the JSON API Error.
  String id;

  /// The status of the JSON API Error.
  String status;

  /// The code of the JSON API Error.
  String code;

  /// The title of the JSON API Error.
  String title;

  /// The details of the JSON API Error.
  String detail;

  /// The links object of the JSON API Error.
  Map links;

  /// The source object of the JSON API Error.
  Map source;

  /// The meta object the JSON API Error.
  Map meta;

  JsonApiError(): super();
  factory JsonApiError.fromJson(Map<String, dynamic> json) => _$JsonApiErrorFromJson(json);
}
