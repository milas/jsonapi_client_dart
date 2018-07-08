library model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'model.g.dart';

abstract class JsonApiResponse implements Built<JsonApiResponse, JsonApiResponseBuilder> {
  List<JsonApiError> get errors;

  JsonApiResponse._();
  factory JsonApiResponse([updates(JsonApiResponseBuilder b)]) = _$JsonApiResponse;
  static Serializer<JsonApiResponse> get serializer => _$jsonApiResponseSerializer;
}

abstract class JsonApiError implements Built<JsonApiError, JsonApiErrorBuilder> {
  String get id;

  JsonApiError._();
  factory JsonApiError([updates(JsonApiErrorBuilder b)]) = _$JsonApiError;
  static Serializer<JsonApiError> get serializer => _$jsonApiErrorSerializer;
}