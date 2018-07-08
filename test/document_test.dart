// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import "package:jsonapi_client/jsonapi_client.dart";
import "package:test/test.dart";

Map getMockJSONAPIResourceAsMap() {
  Map dataMap = new Map();
  dataMap['type'] = 'person';
  dataMap['attributes'] = new Map();
  dataMap['attributes']['name'] = 'Pasquale';
  return dataMap;
}

void main() {
  group("test Document creation", () {
    test("create a JSONAPIDocument with a single resource", () {
      Map inputMap = new Map();
      inputMap['data'] = getMockJSONAPIResourceAsMap();

      JSONAPIDocument expectedDocument = new JSONAPIDocument(inputMap);

      expect(expectedDocument.data != null, equals(true));
      expect(expectedDocument.data is JSONAPIResource, equals(true));
      expect(expectedDocument.errors == null, equals(true));
    });

    test("create a JSONAPIDocument with multiple resources", () {
      List<Map> dataList = new List<Map>();
      dataList.add(getMockJSONAPIResourceAsMap());
      dataList.add(getMockJSONAPIResourceAsMap());

      Map inputMap = new Map();
      inputMap['data'] = dataList;

      JSONAPIDocument expectedDocument = new JSONAPIDocument(inputMap);

      expect(expectedDocument.data != null, equals(true));
      expect(expectedDocument.data is JSONAPIResourceList, equals(true));
      expect(expectedDocument.errors == null, equals(true));
    });

    test("create a JSONAPIDocument from a Map with both data and errors", () {
      List<Map> errorListMap = new List<Map>();

      Map errorMap = new Map();
      errorMap['status'] = '500';
      errorMap['detail'] = 'Internal server error';

      errorListMap.add(errorMap);

      Map inputMap = new Map();
      inputMap['data'] = getMockJSONAPIResourceAsMap();
      inputMap['errors'] = errorListMap;
      inputMap['meta'] = new List<Object>();

      expect(() {
        new JSONAPIDocument(inputMap);
      }, throwsFormatException);
    });

    test("create a JSONAPIDocument from an empty map", () {
      Map aMap = new Map();

      expect(() {
        new JSONAPIDocument(aMap);
      }, throwsFormatException);
    });
  });

  group("test Document conversion", () {
    test("encode JSONDocument into a Map", () {
      String inputJson =
          '{"data":{"type":"person","attributes":{"name":"Pasquale"}}}';

      Map aMap = jsonDecode(inputJson);
      JSONAPIDocument document = new JSONAPIDocument(aMap);
      String outputJson = jsonEncode(document);

      expect(outputJson, equals(inputJson));
    });
  });
}
