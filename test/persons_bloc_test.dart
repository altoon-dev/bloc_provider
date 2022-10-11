import 'package:flutter_demo/bloc/bloc_actions.dart';
import 'package:flutter_demo/bloc/person.dart';
import 'package:flutter_demo/bloc/persons.bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPerson1 = [
  Person(
    age:20,
    name: 'Foo',
  ),
  Person(
    age:30,
    name:'Bar'
  ),
];
const mockedPerson2 = [
  Person(
    age:20,
    name: 'Foo',
  ),
  Person(
      age:30,
      name:'Bar'
  ),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPerson1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPerson2);

void main(){
  group('Testing bloc',() {
    //write our tests

    late PersonsBloc bloc;
    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc,FetchResult?>(
        'Test initial state',
        build: () => bloc,
        verify: (bloc) => expect(bloc.state, null),
    );

    // fetch mock data (person1) and compare it with FetchResult
    blocTest<PersonsBloc,FetchResult?>(
      'Mock Retrieving persons from first iterable',
      build: ()=> bloc,
      act: (bloc){
        bloc.add(LoadPersonsAction(
            url: 'dummy_url_1',
            loader: mockGetPersons1,
        ),
        );
        bloc.add(LoadPersonsAction(
          url: 'dummy_url_1',
          loader: mockGetPersons1,
        ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPerson1,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPerson1,
          isRetrievedFromCache: true,
        ),
      ],
    );
    // fetch mock data (person2) and compare it with FetchResult
    blocTest<PersonsBloc,FetchResult?>(
      'Mock Retrieving persons from second iterable',
      build: ()=> bloc,
      act: (bloc){
        bloc.add(LoadPersonsAction(
          url: 'dummy_url_2',
          loader: mockGetPersons2,
        ),
        );
        bloc.add(LoadPersonsAction(
          url: 'dummy_url_2',
          loader: mockGetPersons2,
        ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPerson2,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPerson2,
          isRetrievedFromCache: true,
        ),
      ],
    );
  });
}
