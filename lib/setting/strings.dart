import 'package:flutter/material.dart';

const String appName = 'myTradeApp';
const Map<String, String> valute = {
  'EUR/USD': 'EURUSD',
  'USD/JPY': 'USDJPY',
  'GBP/USD': 'GBPUSD',
  'AUD/USD': 'AUDUSD',
  'USD/CAD': 'USDCAD'
};
const Map<String, String> timeOrder = {
  'one': '00:30',
  'second': '01:00',
  'third': '01:30',
  'four': '02:00',
  'five': '02:30',
  'six': '03:00',
};
const Map<String, String> moneyOrder = {
  'dollar': '50',
  'evro': '100',
  'rouble': '200',
  'four': '500',
  'five': '1000',
  'six': '5000',
  'seven': '10000',
};
final Map<String, Widget> flags = {
  'EURUSD': Image.asset(
    'assets/images/EURUSD.png',
    width: 30,
  ),
  'USDJPY': Image.asset(
    'assets/images/JPNUSD.png',
    width: 30,
  ),
  'GBPUSD': Image.asset(
    'assets/images/GBRUSD.png',
    width: 30,
  ),
  'AUDUSD': Image.asset(
    'assets/images/AUSUSD.png',
    width: 30,
  ),
  'USDCAD': Image.asset(
    'assets/images/CNDUSD.png',
    width: 30,
  )
};
const Map<String, List<int>> achievData = {
  'Bidding for \$100': [5000, 100],
  'Bidding for \$200': [10000, 200],
  '10 successful deals': [5000, 10],
  '20 deals': [5000, 20],
  '40 deals': [10000, 40],
  '100 deals': [10000, 40],
  '20 successful deals': [10000, 20],
  '80 successful deals': [30000, 80],
  'Bidding for \$500': [15000, 500],
  'Bidding for \$1000': [20000, 1000],
};
