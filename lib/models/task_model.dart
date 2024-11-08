class TaskMdoel{
  String id;       // id is used in update and delete 
  String title ;
  String description;
  DateTime date;
  bool isDone ;

  TaskMdoel ({
    this.id = '',
    required this.title,
    required this.description,
    required this.date ,
     this.isDone = false}
    );

}