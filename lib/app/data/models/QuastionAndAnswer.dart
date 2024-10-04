class QuastionAndAnswer {
  final int id;
  final String quastion;
  final String answer;

  QuastionAndAnswer(
    this.id,
    this.quastion,
    this.answer,
  );

  factory QuastionAndAnswer.fromJsonEn(dynamic json) {
    return QuastionAndAnswer(
      json['id'] as int,
      json['question_en'] as String,
      json['answer_en'] as String,
    );
    // json[1]['image_path'] as String);
  }

  factory QuastionAndAnswer.fromJsonAr(dynamic json) {
    return QuastionAndAnswer(
      json['id'] as int,
      json['question_ar'] as String,
      json['answer_ar'] as String,
    );
    // json[1]['image_path'] as String);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'quastion': quastion,
        'answer': answer,
      };
}
