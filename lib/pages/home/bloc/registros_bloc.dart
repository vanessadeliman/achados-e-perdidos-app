import 'dart:async';
import 'dart:convert';

import 'package:achados_e_perdidos/modelos/sessao.dart';
import 'package:achados_e_perdidos/pages/home/bloc/state_events_registros.dart';
import 'package:achados_e_perdidos/services/interceptor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class RegistrosBloc extends Bloc<RegistrosEvents, RegistrosState> {
  Sessao sessaoAtiva;
  InterceptedClient cliente = InterceptedClient.build(
    interceptors: [LoggingInterceptor(tempoRquisicao: 120)],
    requestTimeout: const Duration(seconds: 120),
  );

  RegistrosBloc(this.sessaoAtiva) : super(InitState()) {
    on<CadastrarItem>(_cadastrarItem);
  }

  FutureOr<void> _cadastrarItem(CadastrarItem event, emit) async {
    emit(CarregandoState());
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ${sessaoAtiva.token}',
        'Content-Type': 'application/json',
      };

      final response = await cliente.post(
        Uri.parse('https://ifce-achados.onrender.com/api/items/cadastro'),
        headers: headers,
        body: jsonEncode(event.ocorrencia.toJson()),
      );

      if (response.statusCode == 200) {
        emit(ItemCadastradoComSucesso());
      } else {
        throw Exception(response.body.toString());
      }
    } catch (e) {
      emit(ErroState('Ocorreu um erro: ${e.toString()}'));
    }
  }
}
