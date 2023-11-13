class News {
  final int id;
  final String title;
  final String image;
  final String dateTime;
  final String text;
  News({
    required this.id,
    required this.title,
    required this.image,
    required this.dateTime,
    required this.text,
  });
  DateTime get dateDur {
    String date = dateTime;
    final indexDay = dateTime.indexOf('.');
    final day = date.substring(0, indexDay);
    final month = date.substring(indexDay + 1, indexDay + 3);
    final years = date.substring(indexDay + 4, indexDay + 8);
    final index = dateTime.indexOf(':');
    final hour = dateTime.substring(index - 2, index);
    final minutes = dateTime.substring(index + 1, index + 3);
    return DateTime(
      int.tryParse(years)!,
      int.tryParse(month)!,
      int.tryParse(day)!,
      int.tryParse(hour)!,
      int.tryParse(minutes)!,
    );
  }
  String get subtitle {
    if (text.contains(
        '\n        \n\n                    \n        \n        \n                    \n')) {
      final startIndex = text.indexOf(
          '\n        \n\n                    \n        \n        \n                    \n');
      final result = text.substring(0, startIndex - 1);
      return result;
    }
    return '';
  }
  String get description {
    if (text.contains(
        '\n        \n\n                    \n        \n        \n                    \n')) {
      final startIndex = text.indexOf(
          '\n        \n\n                    \n        \n        \n                    \n');
      final result = text.substring(startIndex + 71);
      return result;
    }
    return text;
  }

  Duration get duration {
    return DateTime.now().difference(dateDur);
  }

  String get dura {
    final left = DateTime.now().difference(dateDur);
    int minute = 0;
    int hour = 0;
    if (left.inHours >= 1) {
      hour = left.inHours;
      return '$hour';
    } else {
      minute = left.inMinutes;
      return '$minute';
    }
  }

  News copyWith({
    int? id,
    String? title,
    String? image,
    String? dateTime,
    String? text,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      dateTime: dateTime ?? this.dateTime,
      text: text ?? this.text,
    );
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['resultId'] as int,
      title: map['resultTitle'] as String,
      image: map['resultImage'] as String,
      dateTime: map['resultDateTime'] as String,
      text: map['resultText'] as String,
    );
  }

  @override
  String toString() {
    return 'News(id: $id, title: $title, Image: $image, dateTime: $dateTime, text: $text)';
  }

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.image == image &&
        other.dateTime == dateTime &&
        other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        dateTime.hashCode ^
        text.hashCode;
  }
}
