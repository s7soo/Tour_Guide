class IATAModel{

  final data;

  const IATAModel({
    required this.data,
  });

  factory IATAModel.fromJson(Map<String, dynamic> json){
      return IATAModel(
         data: json['data'],
     );

  }

  @override
  String toString() {
    return 'IATAModel${data}';
  }

}