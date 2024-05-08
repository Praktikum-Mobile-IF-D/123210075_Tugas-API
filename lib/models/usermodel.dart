import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String? id;
  String? name;
  String picture;
  String? gender;
  String? email;
  String? country;

  User({this.id, this.name, this.picture = "", this.gender, this.email, this.country});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['login']['username'],
      name: '${json['name']['first']} ${json['name']['last']}',
      picture: json['picture']['large'],
      gender: json["gender"],
      country: json["location"]["country"],
      email: json["email"],
    );
  }

  static Future<List<User>> callApi() async {
    String apiUrl =
        "https://randomuser.me/api/?results=10"; // Perbaiki typo di sini, harusnya 'results', bukan 'result'
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      final userData = jsonResponse['results'] as List;
      return userData
          .map((user) => User.fromJson(user))
          .toList(); // Perbaiki pemetaan objek User di sini
    } else {
      throw Exception('Failed to load user');
    }
  }
}
