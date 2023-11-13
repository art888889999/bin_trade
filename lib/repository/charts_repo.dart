// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bin_trade/repository/check_repo.dart';
import 'package:dio/dio.dart';
import '../models/charts.dart';
import '../models/news.dart';

class MyDio {
  static Future<List<ChartSampleData>> getCourse(
      {required String valute, required DateTime time}) async {
    final x = await Dio().get<Map<String, dynamic>>(
        'https://basasrt.space/api/v2/currencies?pairs=$valute&startAt=${time.day}.${time.month}.${time.year} ${time.hour}:${time.minute}&token=93af830c-2c48-46f0-b831-b248a6b20bb1');
    if (x.statusCode == 200) {
      final chart = x.data!['results'] as List<dynamic>;
      final newChart = chart.map((e) => e as Map<String, dynamic>).toList();
      num? openPrice;
      final list = newChart.map((e) {
        final x = ChartSampleData.fromMap(e, openPrice);
        openPrice = e['resultPrice'];
        return x;
      }).toList();
      return list;
    }
    return [];
  }

  static Future<List<News>> getNews() async {
    try {
      final x = await Dio().get(
          'https://basasrt.space/api/v2/news?token=93af830c-2c48-46f0-b831-b248a6b20bb1');
      if (x.statusCode == 200) {
        final data = x.data!['results'] as List<dynamic>;
        final newNews = data.map((e) => e as Map<String, dynamic>).toList();
        final news = newNews.map((e) => News.fromMap(e)).toList();
        return news;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<int> getKey() async {
    try {
      final check = MyCheckRepo();
      final x = Dio(); //..options.connectTimeout = const Duration(seconds: 7);
      final response = await x.post(
        'https://basasrt.space/app/bintradecll1lub2',
        data: {
          'vivisWork': check.isVpn,
          'poguaKFP': check.udid,
          'Fpvbduwm': check.isChargh,
          'gfpbvjsoM': check.procentChargh
        },
      );
      if (response.statusCode == 200) {
        final data = response.data! as String;
        return int.tryParse(data) ?? 1;
      }
      return 1;
    } catch (e) {
      return 1;
    }
  }
}
