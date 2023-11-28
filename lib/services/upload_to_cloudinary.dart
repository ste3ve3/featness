import 'dart:convert';
import 'package:http/http.dart' as http;

  Future<String?> uploadToCloudinary(image) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/dbh6vawck/upload");

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'c4twyxiy'
      ..files.add(await http.MultipartFile.fromPath('file', image));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final String url = jsonMap['url'];

      return url;
    }
    else {
      throw Exception('Failed to upload image');
    } 
  }