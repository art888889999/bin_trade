import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPage extends StatefulWidget {
  static const String routeName = '/edit';
  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const EditPage(),
    );
  }

  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          backgroundColor: appBarColor,
          previousPageTitle: 'Back',
          middle: Text(
            'Edit profile',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.user?.image != current.user?.image,
                  builder: (context, state) {
                    return CircleAvatar(
                        backgroundImage: state.user?.image,
                        radius: 100,
                        backgroundColor: menuIconsColor);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        context.read<HomeBloc>().add(const SetUserImageEvent());
                      },
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: containerColor,
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 47,
              child: CupertinoTextField(
                style: const TextStyle(color: Colors.white),
                controller: controller,
                placeholderStyle: const TextStyle(
                    color: menuIconsColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                placeholder: '   Name',
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: textFieldColor),
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: containerColor),
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                onPressed: () {
                  context.read<HomeBloc>().add(
                        SetUserEvent(name: controller.text),
                      );
                  MyNavigatorManager.instance.simulatorPop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
