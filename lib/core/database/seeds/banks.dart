import 'package:my_finan/shared/models/bank_icons.dart';
import 'package:uuid/uuid.dart';

List<Map<String, Object?>> banksValues() {
  final createdAt = DateTime.now().millisecondsSinceEpoch;
  final List<Map<String, Object?>> list = [];
  for (var bank in listBanks) {
    list.add({
      'id': const Uuid().v1(),
      'description': bank.name,
      'path': bank.path,
      'createdAt': createdAt,
      'updatedAt': null
    });
  }
  return list;
}
