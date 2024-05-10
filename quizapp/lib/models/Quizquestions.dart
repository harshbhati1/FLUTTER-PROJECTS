class Quizquestion{
  final String question;
  final List<String> answers;

  Quizquestion(this.question, this.answers);

  List<String> getShuffeledlist(){
    List<String> Shuffeledlist = List.of(answers);
    Shuffeledlist.shuffle();
    return Shuffeledlist;
  }
}