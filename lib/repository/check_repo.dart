import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MyCheckRepo {
  final StreamController<int> checkController = StreamController();
  String? udid;
  int? procentChargh;
  bool? isChargh;
  bool? isVpn;
  MyCheckRepo() {
    checkBattery();
    checkVpn();
    checkDeviceInfo();
  }
  Future<void> checkVpn() async {
    if (await CheckVpnConnection.isVpnActive()) {
      isVpn = true;
    } else {
      isVpn = false;
    }
  }

  Future<void> checkBattery() async {
    Battery battery = Battery();
    procentChargh = await battery.batteryLevel;
    isChargh = (await battery.batteryState) == BatteryState.charging;
  }

  Future<void> checkDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    udid = iosInfo.identifierForVendor;
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MaterialApp(
//     home: LoadingW(),
//   ));
// }

// class LoadingW extends StatefulWidget {
//   const LoadingW({super.key});

//   @override
//   State<LoadingW> createState() => _LoadingWState();
// }

// class _LoadingWState extends State<LoadingW> {
//   final checkRepo = MyCheckRepo();
//   StreamController<int> streamController = MyCheckRepo().checkController;
//   double value = 0;
//   double oldValue = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder<int>(
//             stream: streamController.stream,
//             builder: (context, snapshot) {
//               if (!snapshot.hasData || snapshot.data == null) {
//                 return const SizedBox();
//               }
//               oldValue = value;
//               value = snapshot.data! / 4;
//               return CheckWidget(
//                 begin: oldValue,
//                 end: value,
//                 key: ValueKey('$oldValue'),
//               );
//             }),
//       ),
//     );
//   }
// }

// class CheckWidget extends StatefulWidget {
//   final double begin;
//   final double end;
//   const CheckWidget({super.key, required this.begin, required this.end});

//   @override
//   State<CheckWidget> createState() => _CheckWidgetState();
// }

// class _CheckWidgetState extends State<CheckWidget>
//     with TickerProviderStateMixin {
//   @override
//   void initState() {
//     controller.forward();
//     super.initState();
//   }

//   late final AnimationController controller = AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 250));
//   late Animation anime =
//       Tween(begin: widget.begin, end: widget.end).animate(controller);
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: anime,
//         builder: (context, w) {
//           return LinearProgressIndicator(
//             value: anime.value,
//             color: Colors.blue,
//             backgroundColor: Colors.white,
//           );
//         });
//   }
// }
