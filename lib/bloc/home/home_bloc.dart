import 'dart:async';

import 'package:bin_trade/repository/charts_repo.dart';
import 'package:bin_trade/repository/history_repo.dart';
import 'package:bin_trade/repository/remote_confige.dart';
import 'package:bin_trade/repository/user_repo.dart';
import 'package:bin_trade/setting/strings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../models/charts.dart';
import '../../models/news.dart';
import '../../models/order.dart';
import '../../models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({UserRepo? repo, MyHistoryRepo? hisRepo, FirebaseRemote? remote})
      : _repo = repo ?? UserRepo(),
        // _remote = remote ?? FirebaseRemote(),
        _historyRepo = hisRepo ?? MyHistoryRepo(),
        super(HomeState(order: MyOrder.initial())) {
    on<OnboardIndicatorOutEvent>(onTapOnboardIndicatorOut);
    on<OnboardIndicatorBackEvent>(onTapOnboardIndicatorBack);
    on<OnboardIndicatorInEvent>(onTapOnboardIndicatorIn);
    on<HomeChangePageIndex>(onHomeChangePageIndex);
    on<GetUserEvent>(onGetUser);
    on<SetUserEvent>(onSetUser);
    on<SetUserImageEvent>(onSetUserImage);
    on<GetCurrentChartsEvent>(onGetCharts);
    on<SetOrderTimeEvent>(onSetTimeOrder);
    on<SetOrderPointEvent>(onSetPointOrder);
    on<AddOrderEvent>(onAddOrder);
    on<StopOrderEvent>(onStopOrder);
    on<GetHistoryEvent>(onGetHistory);
    on<ChangeHistoryPageIndex>(onChangeHistoryPageIndex);
    on<ResetUserEvent>(onResetUser);
    on<GetNewsEvent>(onGetNews);
    on<GetTimerUpdateChartEvent>(onGetTimer);
  }
  final UserRepo _repo;
  final MyHistoryRepo _historyRepo;
  final InAppReview inAppReview = InAppReview.instance;

  onTapOnboardIndicatorOut(
      OnboardIndicatorOutEvent event, Emitter<HomeState> emit) {
    if (state.onboardIndicator == 1) return;
    emit(state.copyWith(onboardIndicator: state.onboardIndicator + 1));
  }

  onChangeHistoryPageIndex(
      ChangeHistoryPageIndex event, Emitter<HomeState> emit) {
    emit(state.copyWith(historyPageIndex: event.index));
  }

  onTapOnboardIndicatorIn(
      OnboardIndicatorInEvent event, Emitter<HomeState> emit) async {
    if (state.onboardIndicator == 0 &&
        !state.showAppStoreRate &&
        await inAppReview.isAvailable()) {
      return emit(state.copyWith(
          showAppStoreRate: true,
          onboardIndicator: state.onboardIndicator + 1));
    }
    emit(state.copyWith(
        onboardIndicator: state.onboardIndicator + 1, showAppStoreRate: false));
  }

  onTapOnboardIndicatorBack(
      OnboardIndicatorBackEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(onboardIndicator: event.b));
  }

  onHomeChangePageIndex(HomeChangePageIndex event, Emitter<HomeState> emit) {
    // if (event.index == 3 && state.news.isEmpty) {
    //   add(const GetNewsEvent());
    // }
    emit(state.copyWith(homePageIndex: event.index));
  }

  onGetNews(GetNewsEvent event, Emitter<HomeState> emit) async {
    final news = await MyDio.getNews();
    emit(state.copyWith(news: news));
  }

  onGetUser(GetUserEvent event, Emitter<HomeState> emit) async {
    try {
      final myUser = await _repo.getUserName();
      emit(state.copyWith(user: myUser));
      // add(ResetUserEvent());
    } catch (e) {
      emit(state);
    }
  }

  onResetUser(ResetUserEvent event, Emitter<HomeState> emit) async {
    try {
      await _repo.resetData();
      await _historyRepo.resete();
      add(GetUserEvent());
    } catch (e) {
      emit(state);
    }
  }

  onSetUser(SetUserEvent event, Emitter<HomeState> emit) async {
    final name = event.name.isEmpty
        ? state.user?.name ?? 'Enter your name...'
        : event.name;
    await _repo.setUser(name: name);
    add(GetUserEvent());
  }

  onSetUserImage(SetUserImageEvent event, Emitter<HomeState> emit) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      image != null ? await _repo.setImage(image: image) : null;
      add(GetUserEvent());
    } catch (e) {
      emit(state);
    }
  }

  onGetTimer(GetTimerUpdateChartEvent event, Emitter<HomeState> emit) async {
    try {
      Timer.periodic(const Duration(seconds: 30), (timer) async {
        add(GetCurrentChartsEvent(value: state.currentValute));
      });
    } catch (e) {
      emit(state.copyWith(charts: []));
    }
  }

  onGetCharts(GetCurrentChartsEvent event, Emitter<HomeState> emit) async {
    try {
      final list = await MyDio.getCourse(
          valute: event.value,
          time: DateTime.now().subtract(const Duration(minutes: 30)));

      emit(state.copyWith(charts: list, currentValute: event.value));
      final opens = list.first.open;
      if (!list.any((element) => element.open != opens)) {
        emit(state.copyWith(isWorker: false));
      }
    } catch (e) {
      emit(state.copyWith(charts: []));
    }
  }

  onGetHistory(GetHistoryEvent event, Emitter<HomeState> emit) async {
    final hist = await _historyRepo.getHistory();
    emit(state.copyWith(history: hist));
  }

  onAddTg(AddTgEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: MyStatus.tg));
  }

  onAddOrder(AddOrderEvent event, Emitter<HomeState> emit) async {
    if (state.user!.points < state.order.price) {
      return emit(state.copyWith(
          status: MyStatus.error, error: "You don't have enough points!"));
    }
    if (!state.isWorker) return;
    await MyDio.getCourse(
        time: DateTime.now().subtract(const Duration(minutes: 30)),
        valute: state.currentValute);
    final id = DateTime.now();
    final order = state.order.copyWith(
        cost: state.cost,
        valute: state.currentValute,
        isActive: true,
        date: id,
        myId: id.microsecond.toString(),
        promise: event.value);
    final activeOrders = {...state.activeOrders};
    activeOrders[order.myId] = order;
    emit(state.copyWith(
      activeOrders: activeOrders,
      user: state.user!.copyWith(points: state.user!.points - order.price),
      order: MyOrder.initial(),
    ));
    _repo.saveUserPoints(point: state.user!.points);
    Timer(
      order.timer,
      () {
        add(StopOrderEvent(id: order.myId));
      },
    );
  }

  onSetTimeOrder(SetOrderTimeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(order: state.order.copyWith(time: event.value)));
  }

  onSetPointOrder(SetOrderPointEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        order: state.order.copyWith(price: int.tryParse(event.value)),
      ),
    );
  }

  onStopOrder(StopOrderEvent event, Emitter<HomeState> emit) async {
    final orders = {...state.activeOrders};
    final order = orders.remove(event.id);
    emit(state.copyWith(activeOrders: orders));
    if (order == null) return;
    final x = await MyDio.getCourse(
        time: DateTime.now().subtract(const Duration(minutes: 30)),
        valute: order.valute);
    emit(state.copyWith(charts: x)); // titile valute change
    final result = (x.last.close as double) > order.cost;
    if (result == order.promise) {
      final newHistory = [
        ...state.history,
        order.copyWith(status: MyStatus.win)
      ];
      emit(state.copyWith(history: newHistory));
      emit(state.copyWith(
        status: MyStatus.win,
        user: state.user!
            .copyWith(points: state.user!.points + (order.price * 2)),
      ));
      _repo.saveUserPoints(point: state.user!.points);
      _historyRepo.saveHistory(order: order.copyWith(status: MyStatus.win));

      emit(state.copyWith(status: MyStatus.initial));
    } else {
      final newHistory = [
        ...state.history,
        order.copyWith(status: MyStatus.lose)
      ];
      emit(state.copyWith(history: newHistory));
      emit(state.copyWith(
        status: MyStatus.lose,
      ));
      _historyRepo.saveHistory(order: order.copyWith(status: MyStatus.lose));

      final newActive = {...state.activeOrders};
      newActive.remove(event.id);
      if (state.user!.points < 50) {
        emit(state.copyWith(status: MyStatus.zero));
      }
      emit(state.copyWith(status: MyStatus.initial));
    }
  }
}
