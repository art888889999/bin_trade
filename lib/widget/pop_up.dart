import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/models/order.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../setting/strings.dart';

// void main() {
//   runApp(CupertinoApp(
//     home: CupertinoPageScaffold(child: Builder(builder: (context) {
//       return Center(
//         child: ElevatedButton(
//             onPressed: () {
//               showAlertPop(context);
//             },
//             child: const Text('press')),
//       );
//     })),
//   ));
// }

Future<dynamic> showAlertPop(BuildContext context) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              child: const Text(
                'Reset',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                context.read<HomeBloc>().add(const ResetUserEvent());
                MyNavigatorManager.instance.simulatorPop();
              },
            )
          ],
          content: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your balance is zero',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Your progress and balance will be reset to defaults',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      });
}

Future<dynamic> showWinPop(BuildContext context, MyOrder order) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        final isW = order.status == MyStatus.win;
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 266,
            height: 299,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: menuItemBackgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Result',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: menuIconsColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        flags[order.valute] ?? const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          order.valute,
                          style: const TextStyle(color: Colors.white),
                        )),
                        Text(
                          '\$${order.price}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 139,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isW
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      '${isW ? '+' : '-'}${order.price} points',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isW ? Colors.green : Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  isW
                      ? 'You made money on this deal.'
                      : 'You lose on this trade.',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 139,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: containerColor),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        MyNavigatorManager.instance.simulatorPop();
                      }),
                )
              ],
            ),
          ),
        );
      });
}

/// Flutter code sample for [showCupertinoDialog].

// void main() => runApp(const CupertinoDialogApp());

class CupertinoDialogApp extends StatelessWidget {
  const CupertinoDialogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      restorationScopeId: 'app',
      home: CupertinoDialogExample(),
    );
  }
}

class CupertinoDialogExample extends StatelessWidget {
  const CupertinoDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.of(context).restorablePush(_dialogBuilder);
          },
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return CupertinoDialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Title'),
          content: const Text('Content'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
