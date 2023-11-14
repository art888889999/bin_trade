import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final navi = MyNavigatorManager.instance;
  final bloc = HomeBloc()
    ..add(const GetCurrentChartsEvent(value: 'EURUSD'))
    ..add(GetUserEvent())
    ..add(const GetNewsEvent())
    ..add(const GetHistoryEvent());

  runApp(MyApp(
    navi: navi,
    bloc: bloc,
  ));
}

class MyApp extends StatelessWidget {
  final MyNavigatorManager navi;
  final HomeBloc bloc;
  const MyApp({super.key, required this.navi, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => bloc
        ..add(const GetCurrentChartsEvent(value: 'EURUSD'))
        ..add(const GetTimerUpdateChartEvent()),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navi.key,
        theme: const CupertinoThemeData(
            primaryColor: menuIconsColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        onGenerateRoute: navi.onGenerateRoute,
      ),
    );
  }
}
