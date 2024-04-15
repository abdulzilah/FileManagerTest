import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Pages/FolderView.dart';
import '../Theme/Colors.dart';
import '../main.dart';

class Methods extends ChangeNotifier {
  BuildContext? context;

  Methods(BuildContext? context) {
    this.context = context;
  }

  String sortingOption = 'Name (A to Z)';
  List<FileSystemEntity> _folders = [];
  List<FileSystemEntity> _contents = [];
  late Directory _folder;
  bool isGridView = true;
  List<Color> selectedTheme = ColorsLists().selectedTheme;

  List<FileSystemEntity> get folders => _folders;
  List<FileSystemEntity> get contents => _contents;

  Directory externalStorageDir = Directory('/storage/emulated/0');

// request permission for managing device storage
  Future<void> requestPermission() async {
    await Permission.manageExternalStorage.request();
  }

  void updateState(BuildContext context) {
    // Use context to call setState
    (context as Element).markNeedsBuild();
  }

//fetching all folders from the deivce --> sorting the folders with the default option
  Future<void> getFolders() async {
    List<FileSystemEntity> entities = externalStorageDir.listSync();
    _folders = [];
    List<FileSystemEntity> files = [];

    for (var entity in entities) {
      if (entity is Directory) {
        folders.add(entity);
      } else if (entity is File) {
        files.add(entity);
      }
    }

    _folders = [...folders, ...files];
  }

  //get icon data for each folder
  IconData getFileIcon(FileSystemEntity file) {
    if (file is Directory) {
      return Icons.folder;
    } else {
      String extension = file.path.split('.').last.toLowerCase();
      return fileIcons[extension] ?? Icons.insert_drive_file;
    }
  }

//assign icons
  final Map<String, IconData> fileIcons = {
    'apk': Icons.android,
    'jpg': Icons.image,
    'jpeg': Icons.image,
    'png': Icons.image,
    'gif': Icons.image,
    'mp4': Icons.videocam,
    'mp3': Icons.music_note,
    'pdf': Icons.picture_as_pdf,
    'doc': Icons.description,
    'docx': Icons.description,
    'xls': Icons.table_chart,
    'xlsx': Icons.table_chart,
    'ppt': Icons.slideshow,
    'pptx': Icons.slideshow,
    'zip': Icons.archive,
    'rar': Icons.archive,
    'tar': Icons.archive,
  };
//get folder size
  int getFolderSize(Directory folder) {
    int size = 0;
    List<FileSystemEntity> entities =
        folder.listSync(recursive: true, followLinks: false);
    for (var entity in entities) {
      if (entity is File) {
        size += entity.statSync().size;
      }
    }
    return size;
  }

  String formatBytes(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    int i = 0;
    double num = bytes.toDouble();
    while (num >= 1024 && i < suffixes.length - 1) {
      num /= 1024;
      i++;
    }
    return num.toStringAsFixed(2) + ' ' + suffixes[i];
  }

  //showing contents
  void openFolderContents(String folderPath) {
    // Adding the recently opened folder to the list

    Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (context) => FolderViewWidget(folderPath: folderPath),
      ),
    );
  }

//get folder contents
  Future<void> getContents(String path) async {
    _folder = Directory(path);

    List<FileSystemEntity> entities = _folder.listSync();
    List<FileSystemEntity> folders = [];
    List<FileSystemEntity> files = [];

    for (var entity in entities) {
      if (entity is Directory) {
        folders.add(entity);
      } else if (entity is File) {
        files.add(entity);
      }
    }

    folders.sort((a, b) => a.path.compareTo(b.path));
    files.sort((a, b) => a.path.compareTo(b.path));

    _contents = [...folders, ...files];

  }

//create new folder
  void createFolder() async {
    String? folderName = await showDialog<String>(
      context: context!,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 180,
            decoration: BoxDecoration(
              color: selectedTheme[1],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Create Folder",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 30, color: selectedTheme[2]),
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: 'Folder Name',
                        labelStyle: TextStyle(color: selectedTheme[3])),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, controller.text);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Create",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    if (folderName != null && folderName.isNotEmpty) {
      Directory newFolder = Directory('${_folders[0].parent.path}/$folderName');
      newFolder.createSync();
      getFolders();
    }
  }

//renaming a folder
  void renameFolder(String oldFolderPath) async {
    Directory oldFolder = Directory(oldFolderPath);
    String oldFolderName = oldFolderPath.split('/').last;
    String? newFolderName = await showDialog<String>(
      context: context!,
      builder: (BuildContext context) {
        TextEditingController controller =
            TextEditingController(text: oldFolderName);
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 180,
            decoration: BoxDecoration(
              color: selectedTheme[1],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Rename Folder",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 30, color: selectedTheme[2]),
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: 'Folder Name',
                        labelStyle: TextStyle(color: selectedTheme[3])),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, controller.text);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Rename",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    if (newFolderName != null && newFolderName.isNotEmpty) {
      String newFolderPath =
          oldFolderPath.replaceAll(oldFolderName, newFolderName);
      await oldFolder.rename(newFolderPath);
      getFolders();
    }
  }

//deleting a folder
  void deleteFolder(String folderPath) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 140,
            decoration: BoxDecoration(
              color: selectedTheme[1],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Delete Folder?",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 30, color: selectedTheme[2]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedTheme[0],
                          ),
                          child: Center(
                              child: Text(
                            "Delete",
                            style: TextStyle(
                                color: selectedTheme[1],
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    if (confirmDelete != null && confirmDelete) {
      Directory folderToDelete = Directory(folderPath);
      folderToDelete.deleteSync(recursive: true);
      getFolders();
    }
    updateState(context!);
  }

//folder info
  void viewFolderInfo(String folderPath) {
    Directory folder = Directory(folderPath);
    DateTime modifiedDate = folder.statSync().modified;
    int size = getFolderSize(folder);
    String infoMessage =
        'Date Modified: $modifiedDate\nSize: ${formatBytes(size)}';
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 226,
            color: selectedTheme[2],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Folder Details",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 30, color: selectedTheme[1]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 310,
                        child: Text(
                          infoMessage,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 25, color: selectedTheme[1]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedTheme[0],
                      ),
                      child: Center(
                          child: Text(
                        "OK",
                        style: TextStyle(
                            color: selectedTheme[1],
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
