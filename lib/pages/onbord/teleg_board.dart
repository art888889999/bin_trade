import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/pages/onbord/widgets/first_user_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../setting/colors.dart';

class TelegaBoard extends StatelessWidget {
  final String tg;
  const TelegaBoard({super.key, required this.tg});

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
              onTap: () =>
                  context.read<HomeBloc>().add(OnboardIndicatorInEvent()),
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
