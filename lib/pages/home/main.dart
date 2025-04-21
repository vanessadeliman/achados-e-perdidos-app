import 'package:achados_e_perdidos/modelos/sessao.dart';
import 'package:achados_e_perdidos/pages/home/home.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences cache = await SharedPreferences.getInstance();
  final sessaoCache = cache.getString('sessaoAtiva');
  Sessao sessaoAtiva = Sessao();
  if (sessaoCache != null && sessaoCache.isNotEmpty) {
    sessaoAtiva = Sessao.fromJson(sessaoCache);

    if (sessaoAtiva.token.isNotEmpty) {
      DateTime? expirationDate = Jwt.getExpiryDate(sessaoAtiva.token);

      if (expirationDate != null) {
        if (!DateTime.now().isBefore(expirationDate)) {
          sessaoAtiva.token = '';
        }
      }
    }
  }
  runApp(MyApp(sessaoAtiva));
}

class MyApp extends StatelessWidget {
  final Sessao sessaoAtiva;
  const MyApp(this.sessaoAtiva, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginBloc(sessaoAtiva))],
      child: MaterialApp(
        title: 'Achados e Perdidos',
        theme: ThemeData(
          primaryColor: Color(0xFFFF991F),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFFFF991F),
            primary: Color(0xFFFF991F),
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
