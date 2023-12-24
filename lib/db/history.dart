import 'package:cashalog/utils/currency.dart';
import 'package:isar/isar.dart';
part 'history.g.dart';

@collection
class Transaction {
  Id? id = Isar.autoIncrement;

  DateTime? date;

  int? amount;

  @enumerated
  late TransactionType type;

  String? description;
}

@collection
class Total {
  Id? id = Isar.autoIncrement;

  DateTime? date;

  int? total;
}
