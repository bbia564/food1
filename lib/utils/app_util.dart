import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppUtil {
  static Future<String> saveImageToFile(Uint8List imageData, String imageName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$imageName.jpg';
    final file = File(filePath);
    await file.writeAsBytes(imageData);
    return filePath; // 返回文件路径
  }

  void onImageSelected() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
    }
  }

  /// 随机字符
  static String randomLetters(int len) {
    String alphabet = 'QWERTYUIOPASDFGHJKLZXCVBNM';
    String r = '';
    for (var i = 0; i < len; i++) {
      final index = Random().nextInt(alphabet.length);
      r += alphabet[index];
    }
    return r;
  }
}
