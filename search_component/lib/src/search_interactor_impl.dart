import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:search_component/search_component.dart';

class SearchInteractor<T, R> implements ISearchInteractor<R> {
  SearchInteractor({
    required ResultMapper<R, T> resultMapper,
    required ResultFetcher<T> resultFetcher,
    required EmptyTest<T> emptyTest,
  })  : _resultMapper = resultMapper,
        _emptyTest = emptyTest,
        _resultFetcher = resultFetcher {
    _queryResultSubscription = _querySubject
        .map((String query) => query.trim())
        .doOnData((String query) {
          if (query.isEmpty) {
            _resultSubject.add(const SearchState.def());
          }
        })
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .where((String query) => query.isNotEmpty)
        .doOnData((_) {
          _resultSubject.add(const SearchState.loading());
        })
        .switchMap((String query) {
          return Stream<T>.fromFuture(_resultFetcher.call(query))
              .asyncMap((T result) async {
            if (_emptyTest.call(result)) {
              return SearchState<R>.empty();
            }
            return SearchState<R>.result(await _resultMapper.call(result));
          });
        })
        .listen((SearchState<R> result) {
          _resultSubject.add(result);
        });
  }

  final ResultMapper<R, T> _resultMapper;
  final ResultFetcher<T> _resultFetcher;
  final EmptyTest<T> _emptyTest;

  StreamSubscription<SearchState>? _queryResultSubscription;

  final BehaviorSubject<String> _querySubject =
      BehaviorSubject<String>.seeded('');

  final BehaviorSubject<SearchState<R>> _resultSubject =
      BehaviorSubject<SearchState<R>>.seeded(const SearchState.def());

  @override
  Stream<SearchState<R>> get result => _resultSubject;

  @override
  void onQuery(String query) {
    _querySubject.add(query);
  }

  @override
  void dispose() {
    _queryResultSubscription?.cancel();
  }
}