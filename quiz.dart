class QuizQuestion {
  final String question;
  final List<String> options;
  final int answerIndex;

  QuizQuestion({required this.question, required this.options, required this.answerIndex});
}

class Quiz {
  final String moduleId;
  final List<QuizQuestion> questions;

  Quiz({required this.moduleId, required this.questions});
}
