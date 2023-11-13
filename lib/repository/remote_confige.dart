import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemote {
  FirebaseRemote() {
    initialize();
  }
  bool isDead = false;
  bool needTg = false;
  String tg = 'https://telegram.me/';
  String url = '';
  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initialize() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1)),
    );

    await remoteConfig.setDefaults(const {
      "info": "https://youtube.com",
      "isDead": false,
      "needTg": false,
      "tg": 'https://telegram.me/'
    });

    await remoteConfig.fetchAndActivate();
    url = remoteConfig.getString('info');
    isDead = remoteConfig.getBool('isDead');
    tg = remoteConfig.getString('tg');
    isDead = remoteConfig.getBool('isDead');
    needTg = remoteConfig.getBool('needTg');
  }

  String getUrl() {
    return remoteConfig.getString('info');
  }
}
