import 'package:bin_trade/repository/charts_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbordRepo {
  OnbordRepo() {
    getIsFirstShow();
  }
  bool firstShow = true;
  bool isFinanse = true;
  final String fs = 'fs';
  final String show = 'show';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<void> getIsFirstShow() async {
    firstShow = (await prefs).getBool(show) ?? true;
    if (firstShow) {
      setFirstShow();
    }
  }

  Future<void> isFinanseMode() async {
    final firstShowF = (await prefs).getBool(fs) ?? true;
    if (!firstShowF) {
      isFinanse = true;
    } else {
      final x = await MyDio.getKey();
      isFinanse = x == 0;
      if (isFinanse) {
        setFirstShowFinance();
      }
    }
  }

  Future<void> setFirstShow() async {
    (await prefs).setBool(show, false);
  }

  Future<void> setFirstShowFinance() async {
    (await prefs).setBool(fs, true);
  }
}
