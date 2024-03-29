import 'package:flutter/material.dart';
import 'package:flutter_todo/components/widgets.dart';
import 'package:flutter_todo/realm/realm_services.dart';
import 'package:provider/provider.dart';

import 'dash_ctrl.dart';

class CreateItemAction extends StatelessWidget {
  const CreateItemAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Wrap(children: const [CreateItemForm()]),
            ));
  }
}

class CreateItemForm extends StatefulWidget {
  const CreateItemForm({Key? key}) : super(key: key);

  @override
  createState() => _CreateItemFormState();
}

class _CreateItemFormState extends State<CreateItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemEditingController;
  final DashboardController dashboardController = DashboardController();
  @override
  void initState() {
    _itemEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _itemEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return formLayout(
        context,
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Add student data", style: theme.headline6),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _itemEditingController,
                validator: (value) => (value ?? "").isEmpty ? "Please enter some text" : null,
              ),
              DropdownButtonFormField<String>(
                value: dashboardController.selectedClass.value,
                items: dashboardController.classes.map((classItem) {
                  return DropdownMenuItem<String>(
                    value: classItem,
                    child: Text(classItem),
                  );
                }).toList(),
                onChanged: (value) {
                  dashboardController.selectedClass.value = value!;
                },
                decoration: InputDecoration(labelText: 'Class'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: dashboardController.selectedDivision.value,
                items: dashboardController.divisions.map((divisionItem) {
                  return DropdownMenuItem<String>(
                    value: divisionItem,
                    child: Text(divisionItem),
                  );
                }).toList(),
                onChanged: (value) {
                  dashboardController.selectedDivision.value = value!;
                },
                decoration: InputDecoration(labelText: 'Division'),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(context),
                    Consumer<RealmServices>(builder: (context, realmServices, child) {
                      return okButton(context, "Add", onPressed: () => save(realmServices, context));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void save(RealmServices realmServices, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final summary = _itemEditingController.text;
      final devision = dashboardController.selectedDivision.value;
      final classes = dashboardController.selectedClass.value;
      realmServices.createItem(summary, false,devision,classes);
      Navigator.pop(context);
    }
  }
}
