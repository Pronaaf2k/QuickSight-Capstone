import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:myapp/model/camera_upload.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  ApiService();

  Future<String?> uploadImage(File imageFile) async {
    try {
      if (!imageFile.existsSync()) {
        debugPrint('Error: Image file does not exist');
        return null;
      }

      final uri = Uri.parse('$baseUrl/image-process/');

      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile(
          'file',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBytes = await response.stream.toBytes();

        String? audioPath = await saveAudioFile(responseBytes);

        return audioPath;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> saveAudioFile(List<int> bytes) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      final audioFile = File('${tempDir.path}/scene_summary.mp3');

      await audioFile.writeAsBytes(bytes);

      return audioFile.path;
    } catch (e) {
      return '';
    }
  }

  Future<UploadedImage?> fetchImageResponse(int imageId) async {
    try {
      final uri = Uri.parse('$baseUrl/images/$imageId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return UploadedImage.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
