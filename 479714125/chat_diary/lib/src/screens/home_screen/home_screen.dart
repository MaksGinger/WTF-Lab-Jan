import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/floating_action_button.dart';
import '../../models/page_model.dart';
import '../add_page/add_page_screen.dart';
import '../events_screen/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'widgets/page_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenCubit _cubit = HomeScreenCubit();

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenCubit>(
      create: (context) => _cubit,
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.listOfPages.length,
              itemBuilder: (context, index) {
                var page = state.listOfPages[index];
                final pageWidget = BlocProvider<EventScreenCubit>(
                  create: (context) => EventScreenCubit(page),
                  child: PageCard(
                    parentContext: context,
                    deletePage: _deleteSelectedPage,
                    editPage: _editSelectedPage,
                  ),
                );
                return pageWidget;
              },
            ),
            floatingActionButton: AppFloatingActionButton(
              onPressed: () => _navigateToAddPageAndFetchResult(context),
              child: const Icon(Icons.add, size: 50),
            ),
          );
        },
      ),
    );
  }

  Future<void> _navigateToAddPageAndFetchResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeScreenCubit>.value(
          value: _cubit,
          child: const AddPageScreen(
            title: 'Create a new Page',
          ),
        ),
      ),
    );
    if (result != null) {
      final pageModel = result as PageModel;
      _cubit.addPage(pageModel);
    }
  }

  Future<void> _navigateToEditPageAndEditPage(
    BuildContext context,
    PageModel page,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeScreenCubit>.value(
          value: _cubit,
          child: AddPageScreen(
            title: 'Edit Page',
            titleOfPage: page.name,
          ),
        ),
      ),
    );
    if (result != null) {
      final newPage = result as PageModel;
      _cubit.editPage(newPage, page);
    }
  }

  Future<void> _deleteSelectedPage(BuildContext context, PageModel page) async {
    await _showDeleteDialog(context, page);
  }

  Future<void> _editSelectedPage(BuildContext context, PageModel page) async {
    await _navigateToEditPageAndEditPage(context, page);
  }

  Future<void> _showDeleteDialog(BuildContext context, PageModel page) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete page?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you really sure you want to delete this page?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                context.read<HomeScreenCubit>().removePage(page);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
