import 'package:bin_trade/pages/onbord/widgets/first_user_board.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../setting/colors.dart';

class TGPage extends StatelessWidget {
  static const String routeName = '/tg';
  static Route route(String tg) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => TGPage(
              tg: tg,
            ));
  }

  final String tg;
  const TGPage({super.key, required this.tg});

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
              bigText: 'Join our telegram Channel',
              littleText: 'and trade with our team',
              image: 'assets/images/iphone_telega.png',
              boxColor: telegaButton,
              isNotification: false,
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 17.5,
              width: double.infinity,
              child: ButtonTheme(
                child: ElevatedButton(
                  onPressed: () {
                    launchTelegram();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: telegaButton),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/telega.png'),
                      const Text(
                        'Join',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchTelegram() async {
    String url = tg;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
