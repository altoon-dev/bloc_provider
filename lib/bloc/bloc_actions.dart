import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_demo/bloc/person.dart';

const persons1Url = 'http://127.0.0.1:5500/lib/api/persons1.json';
const persons2Url = 'http://127.0.0.1:5500/lib/api/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);
@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({required this.url, required this.loader}) : super();
}
