import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
    String id;
    String title;
    String firstName;
    String lastName;
    String picture;
    String email;
    DateTime registerDate;
    DateTime updatedDate;

    UserDetails({
        required this.id,
        required this.title,
        required this.firstName,
        required this.lastName,
        required this.picture,
        required this.email,
        required this.registerDate,
        required this.updatedDate,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        title: json["title"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
        email: json["email"],
        registerDate: DateTime.parse(json["registerDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
        "email": email,
        "registerDate": registerDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
    };
}
