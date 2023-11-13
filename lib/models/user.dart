// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyUser {
  FileImage? image;
  final String name;
  final int points;
  MyUser({
    this.image,
    this.name = '',
    this.points = 12000,
  });

  MyUser copyWith({
    String? name,
    int? points,
    FileImage? image
  }) {
    return MyUser(
      name: name ?? this.name,
      image: image??this.image,
      points: points ?? this.points,
    );
  }
}
