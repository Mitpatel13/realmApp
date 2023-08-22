import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _Item {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  bool isComplete = false;
  late String summary;
  late String classes;
  late String division;
  @MapTo('owner_id')
  late String ownerId;
}
