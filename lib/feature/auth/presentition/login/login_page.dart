import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_login/feature/auth/presentition/login/login_cubit.dart';
import 'package:form_login/feature/auth/presentition/login/success_page.dart';
import 'package:form_login/feature/auth/presentition/widget/loading_dialog_widget.dart';

class loginPage extends StatelessWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(title: const Text('Built-in Widgets')),
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: formBloc.addErrors,
                    icon: const Icon(Icons.error_outline),
                    label: const Text('ADD ERRORS'),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: formBloc.submit,
                    icon: const Icon(Icons.send),
                    label: const Text('SUBMIT'),
                  ),
                ],
              ),
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse!)));
                },
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: const InputDecoration(
                            labelText: 'TextFieldBlocBuilder',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: const InputDecoration(
                            labelText: 'DropdownFieldBlocBuilder',
                          ),
                          itemBuilder: (context, value) => FieldItem(
                            isEnabled: value != 'Option 1',
                            child: Text(value),
                          ),
                        ),
                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select2,
                          decoration: const InputDecoration(
                            labelText: 'RadioButtonGroupFieldBlocBuilder',
                          ),
                          itemBuilder: (context, item) => FieldItem(
                            child: Text(item),
                          ),
                        ),
                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          decoration: const InputDecoration(
                            labelText: 'CheckboxGroupFieldBlocBuilder',
                          ),
                          itemBuilder: (context, item) => FieldItem(
                            child: Text(item),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date1,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: const InputDecoration(
                            labelText: 'DateTimeFieldBlocBuilder',
                            prefixIcon: Icon(Icons.calendar_today),
                            helperText: 'Date',
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.dateAndTime1,
                          canSelectTime: true,
                          format: DateFormat('dd-MM-yyyy  hh:mm'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: const InputDecoration(
                            labelText: 'DateTimeFieldBlocBuilder',
                            prefixIcon: Icon(Icons.date_range),
                            helperText: 'Date and Time',
                          ),
                        ),
                        TimeFieldBlocBuilder(
                          timeFieldBloc: formBloc.time1,
                          format: DateFormat('hh:mm a'),
                          initialTime: TimeOfDay.now(),
                          decoration: const InputDecoration(
                            labelText: 'TimeFieldBlocBuilder',
                            prefixIcon: Icon(Icons.access_time),
                          ),
                        ),
                        SwitchFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean2,
                          body: const Text('CheckboxFieldBlocBuilder'),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean1,
                          body: const Text('CheckboxFieldBlocBuilder'),
                        ),
                        SliderFieldBlocBuilder(
                          inputFieldBloc: formBloc.double1,
                          divisions: 10,
                          labelBuilder: (context, value) =>
                              value.toStringAsFixed(2),
                        ),
                        ChoiceChipFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          itemBuilder: (context, value) => ChipFieldItem(
                            label: Text(value),
                          ),
                        ),
                        FilterChipFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context, value) => ChipFieldItem(
                            label: Text(value),
                          ),
                        ),
                        BlocBuilder<InputFieldBloc<File?, String>,
                            InputFieldBlocState<File?, String>>(
                            bloc: formBloc.file,
                            builder: (context, state) {
                              return Container();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}