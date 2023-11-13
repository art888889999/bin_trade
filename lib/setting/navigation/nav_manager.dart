import 'package:bin_trade/models/fin.dart';
import 'package:bin_trade/models/news.dart';
import 'package:bin_trade/pages/achiev_history.dart';
import 'package:bin_trade/pages/edit.dart';
import 'package:bin_trade/pages/error.dart';
import 'package:bin_trade/pages/finic.dart';
import 'package:bin_trade/pages/new_item.dart';
import 'package:bin_trade/pages/onbord/home_page.dart';
import 'package:bin_trade/pages/onbord/onboard.dart';
import 'package:bin_trade/pages/splash.dart';
import 'package:bin_trade/pages/tg.dart';
import 'package:bin_trade/repository/onbord_repo.dart';
import 'package:bin_trade/repository/remote_confige.dart';
import 'package:flutter/cupertino.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final repo = OnbordRepo();
  final key = GlobalKey<NavigatorState>();
  NavigatorState? get nav => key.currentState;
  final FirebaseRemote remoute = FirebaseRemote();
  Future<void> firstPush() async {
    await repo.isFinanseMode();
    if (repo.firstShow) {
      nav!.pushReplacementNamed('/onboard',
          arguments: FinArt(isFinanse: repo.isFinanse, tg: remoute.tg));
    } else {
      if (repo.isFinanse || remoute.isDead) {
        if (remoute.needTg) {
          nav!.pushNamed('/tg', arguments: remoute.tg);
        } else {
          final url = remoute.getUrl();
          nav!.pushReplacementNamed('/finic', arguments: url);
        }
      } else {
        nav!.pushReplacementNamed('/home');
      }
    }
  }

  Future<void> simulatorPop() async {
    nav!.pop();
  }

  Future<void> simulatorPush() async {
    nav!.pushNamed('/home');
  }

  Future<void> simulatorFinic() async {
    nav!.pushNamed('/finic', arguments: remoute.url);
  }

  Future<void> achievPush(MyAchiev achiev) async {
    nav!.pushNamed('/achiev', arguments: achiev);
  }

  Future<void> newsPush(News news) async {
    nav!.pushNamed('/news', arguments: news);
  }

  Future<void> editPush() async {
    nav!.pushNamed('/edit');
  }

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashPage.route();
      case '/onboard':
        final finArt = settings.arguments as FinArt;
        return OnboardPage.route(finArt: finArt);
      case '/tg':
        final tg = settings.arguments as String;
        return TGPage.route(tg);
      case '/finic':
        final url = settings.arguments as String;
        return FinicPage.route(url);
      case '/achiev':
        final achiev = settings.arguments as MyAchiev;

        return AchievHistory.route(achiev);
      case '/home':
        return HomePage.route();
      case '/news':
        return NewItem.route(settings.arguments as News);
      case '/edit':
        return EditPage.route();
      default:
        return ErrorPage.route();
    }
  }
}
