import 'package:bin_trade/pages/onbord/widgets/first_user_board.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../setting/colors.dart';

class NotificationBoard extends StatelessWidget {
  const NotificationBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = MediaQuery.of(context).size.width / 20;
    return CupertinoPageScaffold(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 16.2,
            bottom: MediaQuery.of(context).size.height / 18,
            right: horizontal,
            left: horizontal),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => MyNavigatorManager.instance.simulatorFinic(),
              child: const SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const UserBoard(
              bigText: "Don't miss anything important",
              littleText: 'in our app',
              image: 'assets/images/iphone_not.png',
              boxColor: containerColor,
              isNotification: true,
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 17.5,
              width: double.infinity,
              child: ButtonTheme(
                child: ElevatedButton(
                  onPressed: () async {
                    final PermissionStatus status =
                        await Permission.notification.request();
                    if (status.isGranted) {
                      // Notification permissions granted
                    } else if (status.isDenied) {
                      // Notification permissions denied
                    } else if (status.isPermanentlyDenied) {
                      await openAppSettings();
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: containerColor),
                  child: const Text(
                    'Enable notifications',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
