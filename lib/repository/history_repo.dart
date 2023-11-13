import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/order.dart';

class MyHistoryRepo {
  Isar? _isar;
  Future<Isar> get _isarGetter async {
    final appDir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open([IsarOrderSchema], directory: appDir.path);
    return _isar!;
  }

  Future<void> resete() async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      isar.clear();
    });
  }

  Future<void> saveHistory({required MyOrder order}) async {
    final isar = await _isarGetter;
    final isarOrder = IsarOrder()
      ..cost = order.cost
      ..myId = order.myId
      ..isActive = order.isActive
      ..price = order.price
      ..status = order.status
      ..time = order.time
      ..date = order.date
      ..valute = order.valute
      ..promise = order.promise;
    isar.writeTxn(() async {
      isar.isarOrders.put(isarOrder);
    });
  }

  Future<List<MyOrder>> getHistory() async {
    final isar = await _isarGetter;
    final items = await isar.isarOrders.where().findAll();
    final history = <MyOrder>[];
    items.map(
      (e) {
        history.add(
          MyOrder(
            myId: e.myId!,
            status: e.status,
            price: e.price!,
            date: e.date!,
            time: e.time!,
            cost: e.cost!,
            valute: e.valute!,
            isActive: e.isActive!,
            promise: e.promise!,
          ),
        );
      },
    ).toList();
    return history;
  }
}
