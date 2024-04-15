import 'dart:io';

import 'package:file_manager_abdulelah_alsbiei/Pages/FolderView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/colors.dart' as clr;

import '../Methods/Methods.dart';
import '../Pages/HomePage.dart';
import '../Theme/Colors.dart';

class components {
  BuildContext context;
  components(this.context);
  List<Color> selectedTheme = ColorsLists().selectedTheme;

  Widget ItemListCard(BuildContext ctx, FileSystemEntity item, String Name,
      IconData icons, Function onMoreOptions) {
    Methods methods = Methods(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
      child: InkWell(
        onLongPress: () {
          if (item is Directory) {
            showDialog(
              context: ctx,
              builder: (BuildContext context) {
                return FolderActionsDialog(
                  folderPath: item.path,
                  onRename: methods.renameFolder,
                  onDelete: methods.deleteFolder,
                  onViewInfo: methods.viewFolderInfo,
                );
              },
            );
          } else {
            // Handle file actions
          }
        },
        onTap: () async {
          if (item is Directory) {
            methods.openFolderContents(item.path);
          } else {
            // Handle file tap
          }
        },
        child: Container(
          height: 60,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: selectedTheme[2],
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          icons,
                          size: 25,
                          color: selectedTheme[3],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(ctx).size.width - 120,
                                  child: Text(
                                    Name,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: selectedTheme[3]),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  item is Directory
                      ? InkWell(
                          onTap: () {
                            onMoreOptions();
                          },
                          child: Icon(
                            Icons.more_vert_rounded,
                            color: selectedTheme[1],
                          ))
                      : Container()
                ],
              ),
              Divider(
                indent: 50,
                color: selectedTheme[2].withOpacity(0.5),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget GridViewCard(BuildContext ctx, FileSystemEntity item, String Name,
      IconData icons, Function onMoreOptions) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: clr.ColorsLists().lighten(selectedTheme[0], .03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  item is Directory
                      ? InkWell(
                          onTap: () {
                            onMoreOptions();
                          },
                          child: Icon(
                            Icons.more_vert_rounded,
                            color: selectedTheme[1],
                          ))
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icons,
                    size: 60,
                    color: item is Directory ? selectedTheme[2] : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    Name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: selectedTheme[3]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FolderActionsDialog extends StatelessWidget {
  final String folderPath;
  final Function(String) onRename;
  final Function(String) onDelete;
  final Function(String) onViewInfo;

  FolderActionsDialog({
    required this.folderPath,
    required this.onRename,
    required this.onDelete,
    required this.onViewInfo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        color: selectedTheme[2],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Folder Info",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 30, color: selectedTheme[1]),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onRename(folderPath);
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: selectedTheme[1],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Rename",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 25, color: selectedTheme[1]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onDelete(folderPath);
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: selectedTheme[1],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Delete",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 25, color: selectedTheme[1]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onViewInfo(folderPath);
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: selectedTheme[1],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Details",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 25, color: selectedTheme[1]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
