import 'dart:convert';

import 'package:clima_vista/data/http/http_client.dart';
import 'package:clima_vista/data/http/http_exceptions.dart';
import 'package:clima_vista/model/temperatura_model.dart';
import 'package:clima_vista/service/geolocator.dart';
import 'package:geolocator/geolocator.dart';

abstract class ITemperaturaRepository {
  Future<TemperaturaModel> getTemperatura();
}

class TemperaturaRepository implements ITemperaturaRepository {
  final IHttpClient client;

  TemperaturaRepository({required this.client});

  @override
  Future<TemperaturaModel> getTemperatura() async {
    Position posicao = await Geolocator_Temperatura().determinePosition();
    String latitude = posicao.latitude.toString();
    String longitude = posicao.longitude.toString();

    final response = await client.get(
        url:
            'https://api.hgbrasil.com/weather?key=bb85c099&lat=$latitude&lon=$longitude&user_ip=remote');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final results = body['results'];

      final TemperaturaModel temperatura = TemperaturaModel.fromMap(results);
      return temperatura;
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: 'Nada foi encontrado');
    } else {
      throw Exception('Deu erro');
    }
  }
}
