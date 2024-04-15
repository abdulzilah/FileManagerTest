import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/colors.dart' as clr;
import 'package:file_manager_abdulelah_alsbiei/Components/components.dart'
    as comp;
import '../Components/Components.dart';
import '../Methods/Methods.dart';
import '../Theme/Colors.dart';
import 'HomePage.dart';

class FolderViewWidget extends StatefulWidget {
  final String folderPath;

  const FolderViewWidget({super.key, required this.folderPath});

  @override
  State<FolderViewWidget> createState() => _FolderViewWidgetState();
}

List<Color> selectedTheme = ColorsLists().selectedTheme;

class _FolderViewWidgetState extends State<FolderViewWidget> {
  @override
  Widget build(BuildContext context) {
    Methods methods = Methods(context);

    return ChangeNotifierProvider(
      create: (context) => Methods(context),
      child: Scaffold(
        backgroundColor: selectedTheme[0],
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: FutureBuilder<void>(
                future: methods.getContents(widget.folderPath),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while fetching folders
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Use the fetched folders here
                    return ListView.builder(
                      itemCount: methods.contents.length,
                      itemBuilder: (BuildContext context, int index) {
                        FileSystemEntity item = methods.contents[index];
                        String itemName = item.path.split('/').last;
                        return Column(
                          children: [
                            index == 0
                                ? Container(
                                    height: 100,
                                  )
                                : Container(),
                            InkWell(
                              onTap: () async {
                                FileSystemEntity item = methods.contents[index];
                                if (item is Directory) {
                                  methods.openFolderContents(item.path);
                                }
                              },
                              child: comp.components(context).ItemListCard(
                                  context,
                                  methods.contents[index],
                                  methods.contents[index].path.split('/').last,
                                  methods.getFileIcon(methods.contents[index]),
                                  () {
                                FileSystemEntity item = methods.contents[index];
                                if (item is Directory) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FolderActionsDialog(
                                        folderPath: item.path,
                                        onRename: methods.renameFolder,
                                        onDelete: methods.deleteFolder,
                                        onViewInfo: methods.viewFolderInfo,
                                      );
                                    },
                                  );
                                } else {}
                              }),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Container(
                    height: 135,
                    color: clr.ColorsLists().lighten(selectedTheme[0], .05),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DelayedWidget(
                            delayDuration: const Duration(milliseconds: 0),
                            animationDuration: const Duration(seconds: 1),
                            animation: DelayedAnimations.SLIDE_FROM_LEFT,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                widget.folderPath.split('/').last,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme[1]),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  methods.createFolder();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme[1],
                                  ),
                                  child: Icon(
                                    Icons.create_new_folder,
                                    color: selectedTheme[0],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
