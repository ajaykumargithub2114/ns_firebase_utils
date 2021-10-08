import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../src.dart';

class FirebaseStorageService {
  static Future<String> uploadFile(
    File file,
    String path, {
    Map<String, String> customMetadata = const {},
  }) async {
    Reference storageReference = FirebaseStorage.instance.ref().child(path);

    final UploadTask uploadTask = storageReference.putFile(
      file,
      SettableMetadata(
        contentLanguage: 'en',
        customMetadata: customMetadata,
      ),
    );

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {
      appLogsNS("uploadTask whenComplete");
    });

    appLogsNS("uploadTask whenComplete[${snapshot.state.index}]");

    String fileURL = await storageReference.getDownloadURL();
    appLogsNS("uploadFile fileURL: $fileURL");
    return fileURL;
  }
}
