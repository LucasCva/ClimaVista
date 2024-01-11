import 'package:clima_vista/data/http/http_exceptions.dart';
import 'package:clima_vista/data/repositories/temperatura_repository.dart';
import 'package:clima_vista/model/temperatura_model.dart';
import 'package:flutter/material.dart';

class StoresTemperatura {
  final TemperaturaRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<TemperaturaModel?> state =
      ValueNotifier<TemperaturaModel?>(null);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  StoresTemperatura({required this.repository});

  Future getTemperatura() async {
    isLoading.value = true;

    try {
      final result = await repository.getTemperatura();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
