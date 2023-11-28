import 'dart:convert';

Future<String?> imageToBase64(selectedImage) async {
    if (selectedImage == null) return null;

    List<int> imageBytes = await selectedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
}