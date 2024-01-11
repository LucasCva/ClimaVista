class TemperaturaModel {
  final String cidade;
  final int temperatura;
  final String hora;

  TemperaturaModel({
    required this.cidade,
    required this.temperatura,
    required this.hora,
  });

  factory TemperaturaModel.fromMap(Map<String, dynamic> map) {
    return TemperaturaModel(
      cidade: map['city'],
      temperatura: map['temp'],
      hora: map['time'],
    );
  }
}
