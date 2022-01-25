import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/database_config.dart';
import '../../../models/event_model.dart';
import '../../../models/page_model.dart';

part 'state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit()
      : super(HomeScreenState(
          listOfPages: [],
          newPageId: 0,
        ));

  void init() async {
    final listOfPages =
        await DatabaseAccess.instance.firebaseDBProvider.retrievePages();
    listOfPages.forEach(print);
    //final list = await DatabaseAccess.databaseProvider.retrievePages();
    emit(state.copyWith(
        listOfPages: listOfPages, newPageId: listOfPages.length));
  }

  void migrateEventsToPage(
      PageModel page, Iterable<EventModel> eventsToMigrate) async {
    var id = page.nextEventId;
    for (var event in eventsToMigrate) {
      event.id = id;
      event.pageId = page.id;
      id += 1;
      page.nextEventId += 1;
    }

    state.listOfPages[page.id].events.insertAll(0, eventsToMigrate);
    await DatabaseAccess.instance.databaseProvider
        .insertEvents(eventsToMigrate);
    emit(state.copyWith(listOfPages: state.listOfPages));
  }

  void addPage(PageModel page) async {
    state.listOfPages.add(page);
    await DatabaseAccess.instance.firebaseDBProvider.insertPage(page);
    //await DatabaseAccess.instance.databaseProvider.insertPage(page);
    emit(state.copyWith(
        listOfPages: state.listOfPages, newPageId: state.newPageId + 1));
  }

  void editPage(PageModel page, PageModel oldPage) async {
    final newPage = page.copyWith(id: oldPage.id, events: oldPage.events);
    //await DatabaseAccess.instance.databaseProvider.updatePage(newPage);
    await DatabaseAccess.instance.firebaseDBProvider.updatePage(newPage);
    final pages =
        await DatabaseAccess.instance.firebaseDBProvider.retrievePages();
    emit(state.copyWith(listOfPages: pages));
  }

  void removePage(PageModel page) async {
    await DatabaseAccess.instance.databaseProvider.deletePage(page);
    final pages =
        await DatabaseAccess.instance.databaseProvider.retrievePages();
    emit(state.copyWith(listOfPages: pages));
  }
}
