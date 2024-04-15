import 'dart:io';

import 'package:file_manager_abdulelah_alsbiei/Methods/Methods.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/Colors.dart';
import 'package:file_manager_abdulelah_alsbiei/main.dart';
import 'package:flutter/material.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/colors.dart' as clr;
import 'package:file_manager_abdulelah_alsbiei/Components/components.dart'
    as comp;
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:provider/provider.dart';

import '../Components/Components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> selectedTheme = ColorsLists().selectedTheme;
  bool isGridView = false;

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
                future: methods.getFolders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while fetching folders
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Use the fetched folders here
                    return Column(children: [
                      Container(
                        height: isGridView ? 100 : 0,
                      ),
                      isGridView
                          ? Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: methods.folders.length,
                                itemBuilder: (BuildContext context, int index) {
                                  FileSystemEntity item =
                                      methods.folders[index];
                                  String itemName = item.path.split('/').last;
                                  return InkWell(
                                    onTap: () async {
                                      FileSystemEntity item =
                                          methods.folders[index];
                                      if (item is Directory) {
                                        methods.openFolderContents(item.path);
                                      } else {}
                                    },
                                    child: comp
                                        .components(context)
                                        .GridViewCard(
                                            context,
                                            methods.folders[index],
                                            methods.folders[index].path
                                                .split('/')
                                                .last,
                                            methods.getFileIcon(
                                                methods.folders[index]), () {
                                      FileSystemEntity item =
                                          methods.folders[index];
                                      if (item is Directory) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return FolderActionsDialog(
                                              folderPath: item.path,
                                              onRename: methods.renameFolder,
                                              onDelete: methods.deleteFolder,
                                              onViewInfo:
                                                  methods.viewFolderInfo,
                                            );
                                          },
                                        );
                                      } else {}
                                    }),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: methods.folders.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        index == 0
                                            ? Container(
                                                height: 100,
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () async {
                                            FileSystemEntity item =
                                                methods.folders[index];
                                            if (item is Directory) {
                                              methods.openFolderContents(
                                                  item.path);
                                            } else {}
                                          },
                                          child: comp
                                              .components(context)
                                              .ItemListCard(
                                                  context,
                                                  methods.folders[index],
                                                  methods.folders[index].path
                                                      .split('/')
                                                      .last,
                                                  methods.getFileIcon(
                                                      methods.folders[index]),
                                                  () {
                                            FileSystemEntity item =
                                                methods.folders[index];
                                            if (item is Directory) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FolderActionsDialog(
                                                    folderPath: item.path,
                                                    onRename:
                                                        methods.renameFolder,
                                                    onDelete:
                                                        methods.deleteFolder,
                                                    onViewInfo:
                                                        methods.viewFolderInfo,
                                                  );
                                                },
                                              );
                                            } else {}
                                          }),
                                        ),
                                      ],
                                    );
                                  }),
                            )
                    ]);
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
                            child: Text(
                              "My Files",
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: selectedTheme[1]),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isGridView = !isGridView;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedTheme[1],
                                  ),
                                  child: Icon(
                                    isGridView
                                        ? Icons.view_list
                                        : Icons.grid_on,
                                    color: selectedTheme[0],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
