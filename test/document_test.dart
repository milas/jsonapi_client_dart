// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import "package:jsonapi_client/jsonapi_client.dart";
import "package:test/test.dart";

Map<String, dynamic> getMockJSONAPIResourceAsMap() {
  var dataMap = new Map<String, dynamic>();
  dataMap['type'] = 'person';
  dataMap['attributes'] = new Map<String, dynamic>();
  dataMap['attributes']['name'] = 'Pasquale';
  return dataMap;
}

void main() {
  group("test Document creation", () {
    test("create a JSONAPIDocument with a single resource", () {
      var inputMap = new Map<String, dynamic>();
      inputMap['data'] = getMockJSONAPIResourceAsMap();

      JsonApiDocument expectedDocument = JsonApiDocument.fromJson(inputMap);

      expect(expectedDocument.data != null, equals(true));
      expect(expectedDocument.data.length, equals(1));
      expect(expectedDocument.errors == null, equals(true));
    });

    test("create a JSONAPIDocument with multiple resources", () {
      var dataList = [
        getMockJSONAPIResourceAsMap(),
        getMockJSONAPIResourceAsMap()
      ];

      var inputMap = new Map<String, dynamic>();
      inputMap['data'] = dataList;

      JsonApiDocument expectedDocument = JsonApiDocument.fromJson(inputMap);

      expect(expectedDocument.data != null, equals(true));
      expect(expectedDocument.data is List<JsonApiResource>, equals(true));
      expect(expectedDocument.errors == null, equals(true));
    });

    test("create a JSONAPIDocument from a Map with both data and errors", () {
      var errorListMap = new List<Map<String, dynamic>>();

      var errorMap = new Map<String, dynamic>();
      errorMap['status'] = '500';
      errorMap['detail'] = 'Internal server error';

      errorListMap.add(errorMap);

      var inputMap = new Map<String, dynamic>();
      inputMap['data'] = getMockJSONAPIResourceAsMap();
      inputMap['errors'] = errorListMap;
      inputMap['meta'] = new Map<String, dynamic>();

      expect(() {
        JsonApiDocument.fromJson(inputMap);
      }, throwsFormatException);
    });

    test("create a JSONAPIDocument from an empty map", () {
      var aMap = new Map<String, dynamic>();

      expect(() {
        JsonApiDocument.fromJson(aMap);
      }, throwsFormatException);
    });
  });

  group("test Document conversion", () {
    test("encode JSONDocument into a Map", () {
      String inputJson =
          '{"data":{"type":"person","attributes":{"name":"Pasquale"}}}';

      Map<String, dynamic> aMap = jsonDecode(inputJson);
      JsonApiDocument document = JsonApiDocument.fromJson(aMap);
      String outputJson = jsonEncode(document.toJson());

      expect(outputJson, equals(inputJson));
    });
  });
}
