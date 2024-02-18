import 'dart:convert';

class OrderDataResponse {
  String? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  OrderDataResponse(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory OrderDataResponse.fromMap(Map<String, dynamic> map) {
    return OrderDataResponse(
      id: map['_id'],
      title: map['title'],
      note: map['note'],
      isCompleted: map['isCompleted']?.toInt(),
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color']?.toInt(),
      remind: map['remind']?.toInt(),
      repeat: map['repeat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDataResponse.fromJson(String source) =>
      OrderDataResponse.fromMap(json.decode(source));
}
