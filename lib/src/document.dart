// Copyright (c) 2016, Qurami team.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'resource.dart';
import 'error.dart';

/// Dartlang representation of a JSON API Document object.
/// Conforms to the JsonApi 1.0 specification.
/// For any further information please visit http://jsonapi.org
class JsonApiDocument {
  /// The meta object of the JSON API Document.
  Map _meta;
  Map get meta => _meta;

  /// The data object of the JSON API Document.
  /// This member is mandatory by jsonapi specification. This object, by jsonapi
  /// design, can be either an Array or a Resource, therefore the type is
  /// intentionally generic. It will always be initialized as a Resource or as a
  /// List of Resource instances.
  Object _data;
  Object get data => _data;

  /// The errors array of the JSON API Document, empty if no errors have been
  /// received.
  /// This member is mandatory by JSON API specification.
  JSONAPIErrorList _errors;
  JSONAPIErrorList get errors => _errors;

  /// The links object of the JSON API Document.
  /// This member is optional by JSON API specification.
  Map _links;
  Map get links => _links;

  /// The included resources array of the JSON API Document.
  /// If any resource has been included, it's stored in this array following
  /// jsonapi specification, otherwise this array is empty.
  List<Object> _included;
  List<Object> get included => _included;

  /// The jsonapi map includes information about the implementation of the
  /// JSON API document.
  Map _jsonapi;
  Map get jsonapi => _jsonapi;

  JsonApiDocument(Map dictionary) {
    if ((!dictionary.containsKey('data')) &&
        (!dictionary.containsKey('errors'))) {
      throw new FormatException(
          "A JSON API document must include data or error");
    }

    if ((dictionary.containsKey('data')) &&
        (dictionary.containsKey('errors'))) {
      throw new FormatException(
          "A JSON API document cannot include both data and error");
    }

    if (dictionary.containsKey('data')) {
      _data = _initResourceFromData(dictionary['data']);
    }

    if (dictionary.containsKey('errors')) {
      _errors = new JSONAPIErrorList(dictionary['errors']);
    }

    if (dictionary.containsKey('meta')) {
      _meta = dictionary['meta'];
    }

    if (dictionary.containsKey('links')) {
      _links = dictionary['links'];
    }

    if (dictionary.containsKey('included')) {
      _included = _initResourceFromData(dictionary['included']);
    }

    if (dictionary.containsKey('jsonapi')) {
      _jsonapi = dictionary['jsonapi'];
    }
  }

  Map toJson() {
    Map map = new Map();

    if (data != null) {
      if (data is JsonApiResource) {
        map['data'] = (data as JsonApiResource).toJson();
      } else {
        map['data'] = (data as JSONAPIResourceList).toJson();
      }
    }

    if (errors != null) {
      map['errors'] = errors.toJson();
    }

    if (meta != null) {
      map['meta'] = meta;
    }

    if (links != null) {
      map['links'] = links;
    }

    if (included != null) {
      // included objects are always in a list!
      map['included'] = (data as JSONAPIResourceList).toJson();
    }

    if (jsonapi != null) {
      map['jsonapi'] = jsonapi;
    }

    return map;
  }

  _initResourceFromData(rawData) {
    if (rawData is List<Object>) {
      return new JSONAPIResourceList(rawData);
    } else {
      return new JsonApiResource(rawData);
    }
  }
}
