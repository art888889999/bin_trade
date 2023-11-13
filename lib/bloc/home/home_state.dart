// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum MyStatus { loading, error, initial, win, lose, zero, tg }

class HomeState extends Equatable with Achevs {
  final int onboardIndicator;
  final bool showAppStoreRate;
  final int homePageIndex;
  final bool isWorker;
  final int historyPageIndex;
  final MyUser? user;
  final String error;
  final List<News> news;
  final Map<String, MyOrder> activeOrders;
  final MyStatus status;
  final String currentValute;
  final FileImage? image;
  final List<ChartSampleData> charts;
  final MyOrder order;
  final List<MyOrder> history;
  HomeState(
      {this.onboardIndicator = 0,
      this.showAppStoreRate = false,
      this.error = '',
      this.isWorker = true,
      this.news = const [],
      this.history = const [],
      this.historyPageIndex = 0,
      this.status = MyStatus.initial,
      this.activeOrders = const {},
      required this.order,
      this.image,
      this.charts = const [],
      this.currentValute = 'EURUSD',
      this.user,
      this.homePageIndex = 0});
  HomeState copyWith(
          {int? onboardIndicator,
          bool? showAppStoreRate,
          MyUser? user,
          Map<String, MyOrder>? activeOrders,
          MyOrder? order,
          String? error,
          int? historyPageIndex,
          List<News>? news,
          MyStatus? status,
          List<MyOrder>? history,
          bool? isWorker,
          String? currentValute,
          List<ChartSampleData>? charts,
          FileImage? image,
          int? homePageIndex}) =>
      HomeState(
          onboardIndicator: onboardIndicator ?? this.onboardIndicator,
          error: error ?? this.error,
          activeOrders: activeOrders ?? this.activeOrders,
          status: status ?? this.status,
          homePageIndex: homePageIndex ?? this.homePageIndex,
          news: news ?? this.news,
          isWorker: isWorker ?? this.isWorker,
          image: image ?? this.image,
          charts: charts ?? this.charts,
          historyPageIndex: historyPageIndex ?? this.historyPageIndex,
          history: history ?? this.history,
          currentValute: currentValute ?? this.currentValute,
          order: order ?? this.order,
          user: user ?? this.user,
          showAppStoreRate: showAppStoreRate ?? this.showAppStoreRate);

  double get cost {
    return charts.last.close as double;
  }

  @override
  List<Object?> get props => [
        activeOrders,
        status,
        charts,
        news,
        history,
        isWorker,
        currentValute,
        order,
        user,
        showAppStoreRate,
        homePageIndex,
        historyPageIndex,
        onboardIndicator,
        error,
        image
      ];

  @override
  List<MyOrder> get hist => history;
}

mixin Achevs {
  List<MyOrder> get hist;
  int get historyOrderNumber {
    return hist.length;
  }

  List<int> get pointLevel {
    switch (allPrice) {
      case < 5000:
        return [1, 5000];
      case < 10000:
        return [2, 10000];
      case < 30000:
        return [3, 30000];
      case < 80000:
        return [4, 80000];
      case < 120000:
        return [5, 120000];
      default:
        return [6, 5000];
    }
  }

  int get allPrice {
    final sc10 = successfulDeal_10.length == 10
        ? achievData['10 successful deals']![0]
        : 0;
    final sc20 = successfulDeal_20.length == 20
        ? achievData['20 successful deals']![0]
        : 0;
    final sc80 = successfulDeal_80.length == 80
        ? achievData['80 successful deals']![0]
        : 0;
    final deal20 = deal_20.length == 20 ? achievData['20 deals']![0] : 0;
    final deal40 = deal_40.length == 40 ? achievData['40 deals']![0] : 0;
    final deal100 = deal_100.length == 100 ? achievData['100 deals']![0] : 0;
    return p100 +
        p200 +
        p500 +
        p1000 +
        sc10 +
        sc20 +
        sc80 +
        deal100 +
        deal40 +
        deal20;
  }

  int get p_100 {
    int price = 0;
    price_100.map((e) => price += e.price).toList();
    return price;
  }

  int get p_200 {
    int price = 0;
    price_200.map((e) => price += e.price).toList();
    return price;
  }

  int get p_500 {
    int price = 0;
    price_500.map((e) => price += e.price).toList();
    return price;
  }

  int get p_1000 {
    int price = 0;
    price_1000.map((e) => price += e.price).toList();
    return price;
  }

  int get p100 {
    int price = 0;
    price_100.map((e) => price += e.price).toList();
    return price >= 100 ? achievData['Bidding for \$100']![0] : 0;
  }

  int get p200 {
    int price = 0;
    price_200.map((e) => price += e.price).toList();
    return price >= 200 ? achievData['Bidding for \$200']![0] : 0;
  }

  int get p500 {
    int price = 0;
    price_500.map((e) => price += e.price).toList();
    return price >= 500 ? achievData['Bidding for \$500']![0] : 0;
  }

  int get p1000 {
    int price = 0;
    price_1000.map((e) => price += e.price).toList();
    return price >= 1000 ? achievData['Bidding for \$1000']![0] : 0;
  }

  List<MyOrder> get price_100 {
    int list = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        if (list > 100) {
          return false;
        }
        list += element.price;
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get price_200 {
    int list = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        if (list > 200) {
          return false;
        }
        list += element.price;
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get price_500 {
    int list = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        if (list > 500) {
          return false;
        }
        list += element.price;
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get price_1000 {
    int list = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        if (list > 1000) {
          return false;
        }
        list += element.price;
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  int get sucsessDeal {
    return hist
        .where((element) => element.status == MyStatus.win)
        .toList()
        .length;
  }

  List<MyOrder> get successfulDeal_20 {
    int count = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        count += 1;
        return count > 10 && count <= 30;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get successfulDeal_10 {
    int count = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        count += 1;
        return count <= 10;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get successfulDeal_80 {
    int count = 0;
    return hist.where((element) {
      if (element.status == MyStatus.win) {
        count += 1;
        return count > 30 && count <= 110;
      } else {
        return false;
      }
    }).toList();
  }

  List<MyOrder> get deal_20 {
    int count = 0;
    return hist.where((element) {
      count += 1;
      return count > -1 && count <= 20;
    }).toList();
  }

  List<MyOrder> get deal_40 {
    int count = 0;
    return hist.where((element) {
      count += 1;
      return count > 20 && count <= 60;
    }).toList();
  }

  List<MyOrder> get deal_100 {
    int count = 0;
    return hist.where((element) {
      count += 1;
      return count > 60 && count <= 160;
    }).toList();
  }

  List<MyOrder> mainGet(String achiev) {
    switch (achiev) {
      case 'Bidding for \$100':
        return price_100;
      case 'Bidding for \$200':
        return price_200;
      case '10 successful deals':
        return successfulDeal_10;
      case '20 deals':
        return deal_20;
      case '40 deals':
        return deal_40;
      case '100 deals':
        return deal_100;
      case '20 successful deals':
        return successfulDeal_20;
      case '80 successful deals':
        return successfulDeal_80;
      case 'Bidding for \$500':
        return price_500;
      case 'Bidding for \$1000':
        return price_1000;
      default:
        return [];
    }
  }
}
