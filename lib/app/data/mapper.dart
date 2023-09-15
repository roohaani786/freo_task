
import '../modules/home/wiki_search_result_mapper.dart';

class MapperFactory {
  static Map<Type, dynamic Function(dynamic)> constructors = {};

  static void registerConstructor<T>(
    T Function(dynamic) callback,
  ) {
    if (constructors[T] == null) constructors[T] = callback;
  }

  static void initialize() {
    registerWikiResultConstructors();
  }

  static T? map<T>(dynamic json) {
    assert(
      constructors[T] != null,
      "A proper constructor callback must be registered for all api model classes. Couldn't find registry for $T",
    );

    if (json == null) return null;

    return constructors[T]!(json) as T;
  }

  /// Below methods are just helpers to avoid putting null checks at every json -> class conversion

  static T? mapItem<T>(dynamic json, T Function(dynamic) mapper) {
    if (json == null) return null;
    return mapper(json);
  }

  static List<T>? mapList<T>(List<dynamic>? json, T Function(dynamic) mapper) {
    if (json == null) return null;
    return json.map<T>(mapper).toList();
  }
}
