import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageStorageService {
  static const String _imageFolderName = 'pokemon_images';

  Future<String> _getStoragePath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String storagePath = p.join(appDocDir.path, _imageFolderName);
    final Directory storageDir = Directory(storagePath);

    if (!await storageDir.exists()) {
      await storageDir.create(recursive: true);
    }
    return storagePath;
  }

  /// Resolves a stored filename into an absolute path valid for the current session.
  Future<String> resolvePath(String fileName) async {
    final storagePath = await _getStoragePath();
    return p.join(storagePath, fileName);
  }

  /// Saves an image from a generic source path to local storage and returns the filename.
  ///
  /// It handles both asset paths and filesystem paths automatically.
  Future<String> saveImage(String sourcePath) async {
    final String storagePath = await _getStoragePath();
    // If the sourcePath is already within our managed storage, return the filename
    if (p.isWithin(storagePath, sourcePath)) {
      return p.basename(sourcePath);
    }

    // Check if the sourcePath refers to an existing file on the filesystem
    final file = File(sourcePath);
    if (await file.exists()) {
      return saveFileToLocal(file);
    }
    
    // Otherwise, assume it's an asset
    return saveAssetToLocal(sourcePath);
  }

  /// Copies an asset image to the local persistent storage.
  /// Returns the filename of the local file.
  Future<String> saveAssetToLocal(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    final String storagePath = await _getStoragePath();
    final String fileName = p.basename(assetPath);
    final String localPath = p.join(storagePath, fileName);

    await File(localPath).writeAsBytes(bytes);
    return fileName;
  }

  /// Copies an external file to the persistent storage.
  /// Returns the filename of the local file.
  Future<String> saveFileToLocal(File sourceFile) async {
    final String storagePath = await _getStoragePath();
    final String fileName = p.basename(sourceFile.path);
    final String localPath = p.join(storagePath, fileName);

    await sourceFile.copy(localPath);
    return fileName;
  }

  /// Returns a File object for the given path.
  /// This is a helper for the UI layer.
  File getImageFile(String path) {
    return File(path);
  }

  /// Deletes an image file at the given absolute path.
  Future<void> deleteImage(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Deletes all images in the persistent storage folder.
  Future<void> deleteAllImages() async {
    final String storagePath = await _getStoragePath();
    final directory = Directory(storagePath);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
