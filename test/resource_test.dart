// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import "package:jsonapi_client/jsonapi_client.dart";
import "package:test/test.dart";

void main() {
  group("test Resource creation", () {
    test("create a JSONAPIResource from a Map", () {
      var dataMap = new Map<String, dynamic>();
      dataMap['type'] = 'person';
      dataMap['attributes'] = new Map<String, dynamic>();
      dataMap['attributes']['name'] = 'Pasquale';

      JsonApiResource expectedResource = JsonApiResource.fromJson(dataMap);

      expect(expectedResource.type, equals('person'));
    });

    test("create a JSONAPIResource with no type", () {
      var dataMap = new Map<String, dynamic>();
      dataMap['attributes'] = new Map<String, dynamic>();
      dataMap['attributes']['name'] = 'Pasquale';

      expect(() {
        JsonApiResource.fromJson(dataMap);
      }, throwsFormatException);
    });
  });

  group("test Resource conversion", () {
    test("encode JSONAPIResource into a Map", () {
      String inputJson = '{"type":"person","attributes":{"name":"Pasquale"}}';

      Map<String, dynamic> inputMap = jsonDecode(inputJson);
      JsonApiResource resource = JsonApiResource.fromJson(inputMap);
      String outputJson = jsonEncode(resource.toJson());

      expect(outputJson, equals(inputJson));
    });
  });
}
