import 'dart:async';
import 'package:weshot/screens/category/category_reducer.dart';
import 'package:weshot/screens/category/category_service.dart';
import 'package:weshot/store/app/app_store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:weshot/screens/post/post_reducer.dart';
import 'package:rxdart/rxdart.dart';


Stream<dynamic> getCategoryListEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetCategoryListAction)
      .asyncMap((action) => CategoryService.getCategoryList())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetCategoryListResponseAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction(),
          ]));
}


List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> categoryEffects = [
  getCategoryListEpic,
];

