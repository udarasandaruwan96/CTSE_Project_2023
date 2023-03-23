class CommentModel {

  //defineing variables
  int? id;
  String? name;
  String? description;

  CommentModel(
    this.id,
    this.name, 
    this.description, 
    );

  // convert to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };

  // convert from json
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    json['id'],
    json['name'],
    json['description'],
  );


}