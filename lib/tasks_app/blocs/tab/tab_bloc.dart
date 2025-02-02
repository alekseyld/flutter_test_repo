import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloctestapp/tasks_app/models/models.dart';

import '../blocs.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
