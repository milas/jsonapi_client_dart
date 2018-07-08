// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import "package:jsonapi_client/jsonapi_client.dart";
import "package:test/test.dart";

void main() {
  group("test Error creation", () {
    test("create a JsonApiError from a correct Map", () {
      var errorMap = new Map<String, dynamic>();
      errorMap['status'] = '500';
      errorMap['detail'] = 'Internal server error';

      JsonApiError expectedError = JsonApiError.fromJson(errorMap);

      expect(expectedError.status, equals('500'));
      expect(expectedError.detail, equals('Internal server error'));
    });
  });

  group("test Error conversion", () {
    test("encode JSONAPIError into a Map", () {
      String inputJson = '{"status":"500","detail":"Internal server error"}';

      Map<String, dynamic> aMap = jsonDecode(inputJson);
      JsonApiError error = JsonApiError.fromJson(aMap);
      String outputJson = jsonEncode(error);

      expect(outputJson, equals(inputJson));
    });
  });
}
