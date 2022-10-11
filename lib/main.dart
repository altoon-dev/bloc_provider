import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/bloc_actions.dart';
import 'dart:math' as math show Random;
import 'bloc/person.dart';
import 'bloc/persons.bloc.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    ),
  );
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));


extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(
                    const LoadPersonsAction(url: persons1Url, loader: getPersons)
                  );
                },
                child: const Text('Load Json #1'),
              ),
          TextButton(
            onPressed: () {
              context.read<PersonsBloc>().add(
                  const LoadPersonsAction(url: persons2Url, loader: getPersons)
              );
            },
            child: const Text('Load Json #2'),
          ),
        ],
      ),
        ],
    ),
    );
  }
}
