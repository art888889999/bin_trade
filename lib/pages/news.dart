import 'package:bin_trade/setting/colors.dart';
import 'package:bin_trade/setting/navigation/nav_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.news != current.news,
      builder: (context, state) {
        if (state.news.isEmpty) {
          return const CircularProgressIndicator.adaptive();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView.builder(
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final newNews = state.news[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: menuItemBackgroundColor,
                  child: InkWell(
                    onTap: () {
                      MyNavigatorManager.instance.newsPush(newNews);
                    },
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text(
                                      newNews.title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      newNews.text,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: menuIconsColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                                newNews.image.isNotEmpty
                                    ? SizedBox(
                                        width: 129,
                                        height: 129,
                                        child: Image.network(newNews.image),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const Divider(
                              color: menuIconsColor,
                            ),
                            Text(
                              '${newNews.dura} ${newNews.duration.inHours >= 1 ? 'hours' : 'minutes'} ago',
                              style: const TextStyle(
                                  color: menuIconsColor, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
