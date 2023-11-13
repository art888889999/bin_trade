import 'package:bin_trade/models/news.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../setting/colors.dart';

class NewItem extends StatelessWidget {
  static const String routeName = '/news';
  static Route route(News item) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => NewItem(item: item),
    );
  }

  final News item;
  const NewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                item.image.isNotEmpty
                    ? Image.network(
                        item.image,
                        width: MediaQuery.of(context).size.width,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                Text(
                  '${item.dura} ${item.duration.inHours >= 1 ? 'hours' : 'minutes'}  ago',
                  style: const TextStyle(color: menuIconsColor, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Achievements',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 50),
            child: GestureDetector(
                onTap: () => MyNavigatorManager.instance.simulatorPop(),
                child: const Icon(Icons.navigate_before,
                    size: 40, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
