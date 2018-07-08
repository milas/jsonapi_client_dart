library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  JsonApiResponse,
  JsonApiError,
])

final Serializers serializers = _$serializers;