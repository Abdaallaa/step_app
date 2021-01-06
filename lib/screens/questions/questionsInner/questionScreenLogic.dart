import 'package:step_app/models/qustionsModels.dart';
import 'dart:convert';
import 'package:flutter/material.dart';


class QuestionScreenLogic {
  QuestionsInnerModel questionsInnerModel;
  BuildContext parentContext ; 
  List<Map> questions ; 
  var jsonData ;

  void loadData() async {
    // load data
    await Future.delayed(Duration(seconds: 1));
    await getJsonData() ;
    questionsInnerModel.allDataAreLoaded();
  }
  Future getJsonData()async{
    var jsonRaw = await DefaultAssetBundle.of(parentContext).loadString("assets/json/choose.json");
    jsonData = json.decode(jsonRaw);
    questionsInnerModel.questions = jsonData["questionData"];
    questionsInnerModel.currentQuestionIndex = 0;
  }
}
