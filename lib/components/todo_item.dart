import 'package:flutter/material.dart';
import 'package:flutter_todo/components/widgets.dart';
import 'package:flutter_todo/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/realm/schemas.dart';
import 'package:flutter_todo/realm/realm_services.dart';


class TodoItem extends StatelessWidget {
  final Item item;

  const TodoItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    bool isMine = (item.ownerId == realmServices.currentUser?.id);
    return item.isValid
        ? ListTile(

            title: Text(item.summary),
            subtitle: Row(
              children: [
                Text(item.division),
                SizedBox(width: 20,),
                Text(item.classes),
              ],
            ),

            shape: const Border(bottom: BorderSide()),
          )
        : Container();
  }
}
