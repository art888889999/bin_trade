import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserRepo {
  final String user = 'user';
  final String points = 'points';
  final String imagePathKey = 'images_path';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<MyUser> getUserName() async {
    final userName = (await prefs).getString(user);
    final userPoints = (await prefs).getInt(points);
    final localPath = (await prefs).getString(imagePathKey);
    if (localPath == null) {
      return MyUser(
          name: userName ?? 'Enter your Name...', points: userPoints ?? 12000);
    }
    final path = await getApplicationDocumentsDirectory();
    final image = FileImage(File(path.path + localPath));
    return MyUser(
        image: image,
        name: userName ?? 'Enter your Name...',
        points: userPoints ?? 12000);
  }

  Future<void> setUser({required String name}) async {
    (await prefs).setString(user, name);
  }

  Future<void> setImage({required XFile image}) async {
    final path = await getApplicationDocumentsDirectory();
    final String imgpath = path.path;
    final date = DateTime.now();
    await image.saveTo('$imgpath/${date.millisecond}.jpeg');
    (await prefs).setString(imagePathKey, '/${date.millisecond}.jpeg');
  }

  Future<void> saveUserPoints({required int point}) async {
    (await prefs).setInt(points, point);
  }

  Future<void> resetData() async {
    (await prefs).clear();
  }
}
