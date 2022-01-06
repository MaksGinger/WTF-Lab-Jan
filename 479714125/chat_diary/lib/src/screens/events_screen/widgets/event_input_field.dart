import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../models/event_model.dart';
import '../cubit/cubit.dart';

class EventInputField extends StatefulWidget {
  final FocusNode inputNode;
  final TextEditingController inputController;
  final void Function(String) editEvent;

  const EventInputField({
    Key? key,
    required this.inputNode,
    required this.inputController,
    required this.editEvent,
  }) : super(key: key);

  @override
  State<EventInputField> createState() => _EventInputFieldState();
}

class _EventInputFieldState extends State<EventInputField> {
  bool _keyboardIsVisible = false;
  final ImagePicker _picker = ImagePicker();
  late final EventScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<EventScreenCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomOffset = MediaQuery.of(context).viewInsets.bottom;
    _keyboardIsVisible = bottomOffset != 0;
    return Padding(
      padding: EdgeInsets.only(
        bottom: _keyboardIsVisible ? bottomOffset : 12,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  cubit.deleteCurrentCaregory();
                  cubit.toggleIsCategory();
                },
                icon: Icon(
                  Icons.bubble_chart,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Flexible(
                child: TextField(
                  focusNode: widget.inputNode,
                  enabled: !cubit.state.containsMoreThanOneSelected,
                  controller: widget.inputController,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    hintText: 'Enter Event',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              _keyboardIsVisible
                  ? IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: _addEventModel,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: _pickImage,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _addEventModel() {
    if (widget.inputController.text.isNotEmpty) {
      if (!cubit.state.isEditing) {
        var index = cubit.state.newEventIndex;
        final EventModel model;
        if (cubit.state.isCategory && cubit.state.currentCategory != null) {
          model = EventModel(
            pageId: cubit.state.page.id,
            id: index,
            text: widget.inputController.text,
            date: DateFormat('dd.MM.yy').add_Hm().format(DateTime.now()),
            category: cubit.state.currentCategory,
          );
        } else {
          model = EventModel(
            pageId: cubit.state.page.id,
            id: index,
            text: widget.inputController.text,
            date: DateFormat('dd.MM.yy').add_Hm().format(DateTime.now()),
          );
        }
        cubit.addEvent(model);
        widget.inputController.clear();
        cubit.deleteCurrentCaregory();
        cubit.setIsCategoryFalse();
      } else {
        widget.editEvent(widget.inputController.text);
        widget.inputController.clear();
      }
    }
  }

  void _pickImage() async {
    try {
      final nativeImagePath =
          await _picker.pickImage(source: ImageSource.gallery);
      if (nativeImagePath != null) {
        final imagePath = File(nativeImagePath.path);
        final EventModel model;
        var index = cubit.state.newEventIndex;
        if (cubit.state.isCategory && cubit.state.currentCategory != null) {
          model = EventModel(
            pageId: cubit.state.page.id,
            id: index,
            image: imagePath,
            date: DateFormat('dd.MM.yy').add_Hm().format(DateTime.now()),
            category: cubit.state.currentCategory,
          );
        } else {
          model = EventModel(
            pageId: cubit.state.page.id,
            id: index,
            image: imagePath,
            date: DateFormat('dd.MM.yy').add_Hm().format(DateTime.now()),
          );
        }
        cubit.addEvent(model);
        cubit.deleteCurrentCaregory();
        cubit.setIsCategoryFalse();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
