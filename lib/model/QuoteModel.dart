class QuoteModel {

  final String q;
  final String a;
  final String h;

  QuoteModel({this.q, this.a, this.h});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      q: json['q'],
      a: json['a'],
      h: json['h']
    );
  }


}