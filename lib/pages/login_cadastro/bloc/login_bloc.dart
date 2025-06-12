import 'dart:async';
import 'dart:convert';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/state_events_login.dart';
import 'package:achados_e_perdidos/modelos/sessao.dart';
import 'package:achados_e_perdidos/services/interceptor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  Sessao sessaoAtiva;
  InterceptedClient cliente = InterceptedClient.build(
    interceptors: [LoggingInterceptor(tempoRquisicao: 120)],
    requestTimeout: const Duration(seconds: 120),
  );
  LoginBloc(this.sessaoAtiva) : super(InitState()) {
    on<LogarEvent>(_login);
    on<CadastrarEvent>(_cadastro);
  }

  FutureOr<void> _login(LogarEvent event, emit) async {
    emit(CarregandoState());
    try {
      String credentials = '${event.email}:${event.senha}';
      String base64Credentials = base64Encode(utf8.encode(credentials));

      Map<String, String> headers = {
        'Authorization': 'Basic $base64Credentials',
        'Content-Type': 'application/json',
      };

      final response = await cliente.post(
        Uri.parse('https://ifce-achados.onrender.com/api/auth/login'),
        headers: headers,
        body: jsonEncode({"email": event.email, "password": event.senha}),
      );

      if (response.statusCode == 200) {
        sessaoAtiva = Sessao.fromJson(response.body);
        sessaoAtiva.lembrar = event.lembrar;
        SharedPreferences cache = await SharedPreferences.getInstance();
        await cache.setString('sessaoAtiva', sessaoAtiva.toJson());
        emit(SucessoState());
      } else {
        final mensagem = jsonDecode(response.body);
        emit(ErroState(mensagem["message"]));
      }
    } catch (e) {
      emit(ErroState('Ocorreu um erro: ${e.toString()}'));
    }
  }

  FutureOr<void> _cadastro(CadastrarEvent event, emit) async {
    emit(CarregandoState());
    try {
      String credentials = '${event.email}:${event.senha}';
      String base64Credentials = base64Encode(utf8.encode(credentials));

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $base64Credentials',
      };

      sessaoAtiva.nome = event.nome;
      sessaoAtiva.instituicao = event.instituicao;
      sessaoAtiva.lembrar = event.lembrar;
      sessaoAtiva.email = event.email;
      sessaoAtiva.matricula = event.matricula;
      sessaoAtiva.senha = event.senha;

      final response = await cliente.post(
        Uri.parse('https://ifce-achados.onrender.com/api/auth/registro'),
        headers: headers,
        body: jsonEncode(sessaoAtiva.toMap()),
      );

      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        sessaoAtiva.token = map["token"] ?? '';
        SharedPreferences cache = await SharedPreferences.getInstance();
        await cache.setString('sessaoAtiva', sessaoAtiva.toJson());
        emit(SucessoState());
      } else {
        final mensagem = jsonDecode(response.body);
        emit(ErroState(mensagem["message"]));
      }
    } catch (e) {
      emit(ErroState('Ocorreu um erro: ${e.toString()}'));
    }
  }
}
