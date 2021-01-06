import 'package:flutter/material.dart';
import 'package:step_app/models/qustionsModels.dart';
import 'package:step_app/screens/questions/questionsInner/questionScreenLogic.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuestionInnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionsInnerModel(),
      child: QuestionScreen(),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  QuestionScreenLogic qsl = QuestionScreenLogic();
  double screenWidth, screenHeight;
  final Color mainColor = Color(0xff008e85);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    qsl.questionsInnerModel =
        Provider.of<QuestionsInnerModel>(context, listen: false);
    qsl.parentContext = context;
    if (qsl.questionsInnerModel.isDataLoaded == false) qsl.loadData();
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Consumer<QuestionsInnerModel>(
              builder:
                  (context, QuestionsInnerModel questionsInnerModel, child) {
                return qsl.questionsInnerModel.isDataLoaded
                    ? Stack(
                        children: [
                          // the app bar
                          Positioned(
                            //top: ,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.06433,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        print("i will go backward");
                                      },
                                      child: Container(
                                        width: screenHeight * 0.08,
                                        height: screenHeight * 0.06433,
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                          size: screenHeight * 0.035,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      qsl.jsonData["questionName"],
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // progress bar
                          Positioned(
                            top: screenHeight * 0.06433,
                            width: screenWidth,
                            height: screenHeight * 0.05133,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.05133,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LinearPercentIndicator(
                                    width: screenWidth * 0.75,
                                    lineHeight: screenHeight * 0.01,
                                    percent: (questionsInnerModel
                                                .currentQuestionIndex +
                                            1) /
                                        questionsInnerModel.questions.length,
                                    progressColor: mainColor,
                                  ),
                                  Text(
                                    "${questionsInnerModel.currentQuestionIndex + 1}/${questionsInnerModel.questions.length}",
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.022,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // the questionArea
                          Positioned(
                            top: screenHeight * 0.14,
                            width: screenWidth,
                            height: screenHeight * 0.18,
                            child: Center(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: screenWidth * 0.85,
                                  height: screenHeight * 0.18,
                                  color: Color(0xffdaf0ee),
                                  child: Center(
                                    child: Container(
                                        width: screenWidth * 0.65,
                                        height: screenHeight * 0.14,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              questionsInnerModel.questions[
                                                      questionsInnerModel
                                                          .currentQuestionIndex]
                                                  ["question"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.025),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // the answers
                          Positioned(
                            width: screenWidth,
                            top: screenHeight * 0.4,
                            child: Center(
                              child: Container(
                                width: screenWidth * 0.92,
                                height: screenHeight * 0.367,
                                child: AnswersViewer(
                                    qsim: questionsInnerModel,
                                    answers: questionsInnerModel.questions[
                                        questionsInnerModel
                                            .currentQuestionIndex]["answers"]),
                              ),
                            ),
                          ),
                          // navigation
                          Positioned(
                            bottom: screenHeight * 0.11 + 5,
                            height: screenHeight * 0.1158,
                            width: screenWidth,
                            child: Center(
                              child: Container(
                                width: 0.872 * screenWidth,
                                height: screenHeight * 0.1158,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 0.872 * screenWidth,
                                        height: screenHeight * 0.0824,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              screenHeight * 0.0412),
                                          border: Border.all(
                                              color: Color(0xffb2d6d4)),
                                        ),
                                        child: Container(
                                          width: 0.872 * screenWidth,
                                          height: screenHeight * 0.103,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width:
                                                      0.336 * screenWidth - 1,
                                                  height: screenHeight * 0.0824,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if ((questionsInnerModel
                                                                .currentQuestionIndex) >
                                                            0) {
                                                          // i will go back
                                                          questionsInnerModel
                                                              .currentQuestionIndex--;
                                                          questionsInnerModel
                                                              .justNotify();
                                                        }
                                                      },
                                                      child: Container(
                                                        width:
                                                            0.22 * screenWidth,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenHeight *
                                                                      0.03,
                                                              height:
                                                                  screenHeight *
                                                                      0.03,
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/backIcon.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Text(
                                                              "السابق",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "Cairo",
                                                                  color: Color(
                                                                      0xff0d848b)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                  width:
                                                      0.336 * screenWidth - 1,
                                                  height: screenHeight * 0.0824,
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if ((questionsInnerModel
                                                                    .currentQuestionIndex +
                                                                1) <
                                                            questionsInnerModel
                                                                .questions
                                                                .length) {
                                                          // i will get next question
                                                          questionsInnerModel
                                                              .currentQuestionIndex++;
                                                          questionsInnerModel
                                                              .justNotify();
                                                        }
                                                      },
                                                      child: Container(
                                                        width:
                                                            0.22 * screenWidth,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              "التالي",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "Cairo",
                                                                  color: Color(
                                                                      0xff0d848b)),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenHeight *
                                                                      0.03,
                                                              height:
                                                                  screenHeight *
                                                                      0.03,
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/nextIcon.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //the feedback Circle
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          questionsInnerModel.appearFeedback =
                                              true;
                                          questionsInnerModel.justNotify();
                                        },
                                        child: Container(
                                            width: screenHeight * 0.14,
                                            height: screenHeight * 0.1158,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: screenHeight * 0.103,
                                                    height:
                                                        screenHeight * 0.103,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffdaf0ee),
                                                        shape: BoxShape.circle),
                                                  ),
                                                ),
                                                Positioned(
                                                    left: screenHeight * 0.036,
                                                    child: Container(
                                                      width: screenHeight * 0.1,
                                                      height:
                                                          screenHeight * 0.1,
                                                      child: Image.asset(
                                                        "assets/icons/customer_support.png",
                                                        width:
                                                            screenHeight * 0.1,
                                                        height:
                                                            screenHeight * 0.1,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ))
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // bottomBar
                          // the shadow
                          Positioned(
                            bottom: 5,
                            width: screenWidth,
                            height: screenHeight * 0.11,
                            child: CustomPaint(
                              painter:
                                  BottomBarPainter(color: Color(0x22038c91)),
                            ),
                          ),
                          Positioned(
                            bottom: 3,
                            width: screenWidth,
                            height: screenHeight * 0.11,
                            child: CustomPaint(
                              painter:
                                  BottomBarPainter(color: Color(0x22038c91)),
                            ),
                          ),
                          // the actual bar
                          Positioned(
                            bottom: 0,
                            width: screenWidth,
                            height: screenHeight * 0.11,
                            child: CustomPaint(
                                painter: BottomBarPainter(color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ...List.generate(4, (index) {
                                          List icons = [
                                            "assets/icons/infoIcon.png",
                                            "assets/icons/premiumIcon.png",
                                            "assets/icons/profileIcon.png",
                                            "assets/icons/homeIcon.png"
                                          ];
                                          int current = 3;
                                          return Container(
                                            width: screenHeight * 0.033,
                                            height: screenHeight * 0.05,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  icons[index],
                                                  width: screenHeight * 0.033,
                                                  height: screenHeight * 0.033,
                                                  color: current == index
                                                      ? Color(0xff0d848b)
                                                      : Color(0xffb2d6d4),
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(),
                                                Container(
                                                  width: screenHeight * 0.01,
                                                  height: screenHeight * 0.01,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: current == index
                                                          ? Color(0xff0d848b)
                                                          : Colors.white),
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                  ],
                                )),
                          ),
                          //gray backgroung
                          //questionsInnerModel.appearFeedback
                          false
                              ? InkWell(
                                  onTap: () {
                                    questionsInnerModel.appearFeedback = false;
                                    questionsInnerModel.justNotify();
                                  },
                                  child: Container(
                                    width: screenWidth,
                                    height: screenHeight,
                                    color: Color(0x66666666),
                                  ),
                                )
                              : Container(),
                          // pop up
                          //questionsInnerModel.appearFeedback
                          false
                              ? Center(
                                  child: Container(
                                    height: screenHeight * 0.50,
                                    width: screenHeight * 0.40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.016),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.10,
                                          width: screenHeight * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                screenHeight * 0.016),
                                            color: Color(0xff0d848b),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "مساعدك للتفوق",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenHeight * 0.035),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.30,
                                          width: screenHeight * 0.40,
                                          child: Center(
                                            child: Container(
                                                width: screenWidth * 0.65,
                                                height: screenHeight * 0.14,
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Text(
                                                      questionsInnerModel
                                                                  .questions[
                                                              questionsInnerModel
                                                                  .currentQuestionIndex]
                                                          ["feedbackText"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenHeight *
                                                                  0.025),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.10,
                                          width: screenHeight * 0.40,
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                print("open youtube video");
                                              },
                                              child: Container(
                                                height: screenHeight * 0.07,
                                                width: screenHeight * 0.20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenHeight * 0.034),
                                                  color: Color(0xff0d848b),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "شاهد الحل",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              screenHeight *
                                                                  0.025),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Center(
                        child: Theme(
                            data: ThemeData(
                              accentColor: mainColor,
                            ),
                            child: CircularProgressIndicator()),
                      );
              },
            )),
      ),
    );
  }
}

class BottomBarPainter extends CustomPainter {
  BottomBarPainter({@required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width, height = size.height;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = color;
    final bar = Path();
    bar.moveTo(0, height * 0.1744); // start point
    bar.arcToPoint(Offset(width * 0.0399, 0), // end point
        radius: Radius.circular(height * 0.1744), // how the curve would be
        clockwise: true);
    bar.lineTo(width * 0.0479, 0);
    bar.arcToPoint(Offset(width * 0.9521, 0), // end point
        radius: Radius.circular(height * 5.5), // how the curve would be
        clockwise: false);
    bar.lineTo(width * 0.9601, 0);
    bar.arcToPoint(Offset(width, height * 0.1744), // end point
        radius: Radius.circular(height * 0.1744), // how the curve would be
        clockwise: true);
    bar.lineTo(width, height);
    bar.lineTo(0, height);
    bar.lineTo(0, height * 0.1744);

    canvas.drawPath(bar, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class AnswersViewer extends StatelessWidget {
  final List answers;
  QuestionsInnerModel qsim;
  double screenHeight, screenWidth;
  AnswersViewer({@required this.answers, @required this.qsim});
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ...List.generate(
            answers.length,
            (i) => Column(
                  children: [
                    InkWell(
                        onTap: () {
                          qsim.userAnswers[qsim.currentQuestionIndex] = i;
                          qsim.justNotify();
                        },
                        child: Container(
                          height: screenHeight * 0.0644,
                          width: screenWidth * 0.92,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: screenHeight * 0.054,
                                width: screenHeight * 0.054,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff0d848b)),
                                child: Center(
                                  child: Text(
                                    "${i == 0 ? "A" : i == 1 ? "B" : i == 2 ? "C" : "D"}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 0.025 * screenHeight),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenHeight * 0.01,
                              ),
                              Container(
                                height: screenHeight * 0.0644,
                                width: screenWidth*0.92-screenHeight *0.07-2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.013),
                                    border: Border.all(
                                        color: (qsim.userAnswers[qsim
                                                        .currentQuestionIndex] !=
                                                    null &&
                                                qsim.userAnswers[qsim
                                                        .currentQuestionIndex] ==
                                                    i)
                                            ? Color(0xff0d848b)
                                            : Color(0xffb2d6d4))),
                                child: Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "${answers[i]}",
                                      style: TextStyle(
                                          fontSize: 0.02 * screenHeight),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: screenHeight * 0.02188,
                    )
                  ],
                )).toList()
      ],
    );
  }
}
