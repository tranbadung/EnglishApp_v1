class Quiz{
  late String question; //Khởi tạo question sau 
  late List<String> option;
  String correctAnswer;

  Quiz({
    required this.question,
    required this.option,
    required this.correctAnswer,
  });
}