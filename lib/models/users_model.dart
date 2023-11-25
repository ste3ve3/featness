// ignore_for_file: constant_identifier_names
import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    List<Datum> data;
    int total;
    int page;
    int limit;

    Users({
        required this.data,
        required this.total,
        required this.page,
        required this.limit,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
    };
}

class Datum {
    String id;
    String title;
    String firstName;
    String lastName;
    String picture;

    Datum({
        required this.id,
        required this.title,
        required this.firstName,
        required this.lastName,
        required this.picture,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
    };
}
