import 'package:file_manager_abdulelah_alsbiei/Pages/HomePage.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/colors.dart' as clr;
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:provider/provider.dart';

import '../Methods/Methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Color> selectedTheme = ColorsLists().selectedTheme;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: selectedTheme[0],
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            color: selectedTheme[1],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4 + 1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(0, 0, 0, 0), selectedTheme[0]],
                stops: const [0, 1],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, 1),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      const SizedBox(
                        height: 120,
                      ),
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 0),
                        animationDuration: const Duration(seconds: 1),
                        animation: DelayedAnimations.SLIDE_FROM_LEFT,
                        child: Text(
                          "File Management Made Easy",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: selectedTheme[3]),
                        ),
                      ),
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 0),
                        animationDuration: const Duration(seconds: 1),
                        animation: DelayedAnimations.SLIDE_FROM_LEFT,
                        child: Text(
                          "Unlock seamless file management with our app: Organize, simplify, access – anytime, anywhere.",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: selectedTheme[4]),
                        ),
                      ),
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Row(
                          children: [
                            DelayedWidget(
                              delayDuration: const Duration(milliseconds: 0),
                              animationDuration: const Duration(seconds: 1),
                              animation: DelayedAnimations.SLIDE_FROM_LEFT,
                              child: Text(
                                "Select Your Theme",
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme[3]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          DelayedWidget(
                            delayDuration: const Duration(milliseconds: 0),
                            animationDuration: const Duration(seconds: 1),
                            animation: DelayedAnimations.SLIDE_FROM_LEFT,
                            child: Text(
                              "Personalize your Expierence",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: selectedTheme[4]),
                            ),
                          ),
                        ],
                      ),
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 0),
                        animationDuration: const Duration(seconds: 1),
                        animation: DelayedAnimations.SLIDE_FROM_RIGHT,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clr.ColorsLists().changeTheme(
                                        clr.ColorsLists().allThemes,
                                        "DefaultDark",
                                        selectedTheme);
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: clr.ColorsLists()
                                          .allThemes['DefaultDark']![1],
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    ),
                                  ], shape: BoxShape.circle),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topStart: Radius.circular(100),
                                              bottomStart: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists()
                                                .allThemes['DefaultDark']![1]),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topEnd: Radius.circular(100),
                                              bottomEnd: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists()
                                                .allThemes['DefaultDark']![2]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clr.ColorsLists().changeTheme(
                                        clr.ColorsLists().allThemes,
                                        "SecondaryDark",
                                        selectedTheme);
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: clr.ColorsLists()
                                          .allThemes['SecondaryDark']![1],
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    ),
                                  ], shape: BoxShape.circle),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topStart: Radius.circular(100),
                                              bottomStart: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists().allThemes[
                                                'SecondaryDark']![1]),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topEnd: Radius.circular(100),
                                              bottomEnd: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists().allThemes[
                                                'SecondaryDark']![2]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clr.ColorsLists().changeTheme(
                                        clr.ColorsLists().allThemes,
                                        "DefaultLight",
                                        selectedTheme);
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: clr.ColorsLists()
                                          .allThemes['DefaultLight']![1],
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    ),
                                  ], shape: BoxShape.circle),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topStart: Radius.circular(100),
                                              bottomStart: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists()
                                                .allThemes['DefaultLight']![1]),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topEnd: Radius.circular(100),
                                              bottomEnd: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists()
                                                .allThemes['DefaultLight']![2]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clr.ColorsLists().changeTheme(
                                        clr.ColorsLists().allThemes,
                                        "SecondaryLight",
                                        selectedTheme);
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: clr.ColorsLists()
                                          .allThemes['SecondaryLight']![1],
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    ),
                                  ], shape: BoxShape.circle),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topStart: Radius.circular(100),
                                              bottomStart: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists().allThemes[
                                                'SecondaryLight']![1]),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadiusDirectional
                                                    .only(
                                              topEnd: Radius.circular(100),
                                              bottomEnd: Radius.circular(100),
                                            ),
                                            color: clr.ColorsLists().allThemes[
                                                'SecondaryLight']![2]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      DelayedWidget(
                        delayDuration: const Duration(milliseconds: 0),
                        animationDuration: const Duration(seconds: 1),
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                        child: InkWell(
                          onTap: () async {
                           
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 65,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: selectedTheme[1],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Next",
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme[3],
                                    letterSpacing: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ])
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
