import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../Methods/Methods.dart';

class MockDirectory extends Mock implements Directory {}

void main() {
  group('Methods Tests', () {
    late Methods methods;
    late MockDirectory mockDirectory;

    setUp(() {
      mockDirectory = MockDirectory();
      methods = Methods(null);
    });

    test('Test getFolders', () {
      List<FileSystemEntity> mockEntities = [
        Directory('/storage/emulated/0/Folder1'),
        File('/storage/emulated/0/File1.txt'),
        Directory('/storage/emulated/0/Folder2'),
        File('/storage/emulated/0/File2.txt'),
      ];

      when(mockDirectory.listSync()).thenReturn(mockEntities);

      methods.externalStorageDir = mockDirectory;

      methods.getFolders();

      for (var folder in methods.folders) {
        expect(folder is Directory, true);
      }

      for (var content in methods.contents) {
        expect(content is File, true);
      }

      expect(methods.folders.length, 2);
      expect(methods.contents.length, 2);
    });
    test('Test getContents', () {
      String path = '/storage/emulated/0/testFolder';

      List<FileSystemEntity> mockEntities = [
        Directory('/storage/emulated/0/testFoldersubfolder1'),
        File('/storage/emulated/0/testFolderfile1.txt'),
        Directory('/storage/emulated/0/testFoldersubfolder2'),
        File('/storage/emulated/0/testFolder/file2.txt'),
      ];

      when(mockDirectory.listSync()).thenReturn(mockEntities);

      methods.externalStorageDir = mockDirectory;

      methods.getContents(path);

      expect(methods.contents.length, 4);
      expect(methods.contents[0] is Directory, true);
      expect(methods.contents[1] is File, true);
      expect(methods.contents[2] is Directory, true);
      expect(methods.contents[3] is File, true);

      expect(
          methods.contents[0].path, '/storage/emulated/0/testFoldersubfolder1');
      expect(
          methods.contents[1].path, '/storage/emulated/0/testFolderfile1.txt');
    });
  });
}
