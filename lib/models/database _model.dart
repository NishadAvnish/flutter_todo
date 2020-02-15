class DatabaseModel{
  String _description,_title;
  int _id;
  DateTime _deadLine;
  String _category;

  DatabaseModel(this._description, this._title, this._deadLine,this._category);

  DatabaseModel.withId(this._id, this._deadLine,this._description,this._title,this._category);
  
  int get id =>_id;
  String get description=>_description;
  String get title=>_title;
  DateTime get deadLine=>_deadLine;
  String get category=>_category;
  
}