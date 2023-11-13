import 'package:bin_trade/models/fin.dart';
import 'package:bin_trade/pages/onbord/teleg_board.dart';
import 'package:bin_trade/pages/onbord/user_in_next.dart';
import 'package:bin_trade/pages/onbord/user_out_next.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../bloc/home/home_bloc.dart';
import 'notif_board.dart';

class OnboardPage extends StatefulWidget {
  static const String routeName = '/onboard';
  static Route route({required FinArt finArt}) {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return OnboardPage(finArt: finArt);
        });
  }

  final FinArt finArt;
  const OnboardPage({super.key, required this.finArt});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final InAppReview inAppReview = InAppReview.instance;

  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    if (widget.finArt.isFinanse) {
      return BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            previous.onboardIndicator != current.onboardIndicator &&
                current.onboardIndicator > 1 &&
                current.onboardIndicator <= 3 ||
            current.showAppStoreRate != previous.showAppStoreRate,
        listener: (context, state) async {
          if (state.showAppStoreRate) {
            return inAppReview.requestReview();
          }
          if (state.onboardIndicator == 3) {
            controller.nextPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.linear);
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.linear);
          }
        },
        child: PageView(
          padEnds: false,
          pageSnapping: false,
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const UserInBoard(),
            TelegaBoard(tg: widget.finArt.tg),
            const NotificationBoard()
          ],
        ),
      );
    } else {
      return const UsrOutBoard();
    }
  }
}
