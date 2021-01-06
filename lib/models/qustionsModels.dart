import 'package:flutter/widgets.dart';

enum QuestionType {
  Choose
  //
  //
}

class QuestionsInnerModel with ChangeNotifier {
  bool isDataLoaded = false;
  int currentQuestionIndex;
  List questions;
  //QuestionType questionType;
  bool appearFeedback  = false;
  List<int> userAnswers;

  void allDataAreLoaded() {
    isDataLoaded = true;
    userAnswers = List(questions.length);
    notifyListeners();
  }
  void justNotify(){
    notifyListeners();
  }
}

// class QuestionModel {
//   String question;
//   int answerIndex;
//   List<String> answers;
//   List<String> feedbackNotes;
//   String feedbackLink;
//   int userAnswer;
// }
