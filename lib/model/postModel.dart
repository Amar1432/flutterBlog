// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    Welcome({
        required this.category,
        required this.id,
        required this.title,
        required this.description,
        required this.img,
        required this.date,
    });

    String category;
    String id;
    String title;
    String description;
    String img;
    DateTime date;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        category: json["category"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        img: json["img"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "_id": id,
        "title": title,
        "description": description,
        "img": img,
        "date": date.toIso8601String(),
    };
}
