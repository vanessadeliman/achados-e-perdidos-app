import 'package:achados_e_perdidos/componentes/toggle.dart';
import 'package:achados_e_perdidos/pages/home/home.dart';
import 'package:achados_e_perdidos/pages/apresentacao.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/login_bloc.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/state_events_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask/mask/mask.dart';

class Login extends StatefulWidget {
  const Login( {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();

  final TextEditingController senha = TextEditingController();
  bool mostrarSenha = false;
  bool lembrar = false;

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? validacao(String? valor) {
    if (valor != null && valor.isEmpty) {
      return 'Informe sua senha!';
    }
    return null;
  }

  @override
  void initState() {
    if (context.read<LoginBloc>().sessaoAtiva.lembrar) {
      email.text = context.read<LoginBloc>().sessaoAtiva.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        actions: [
        
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return BemVindoPage();
              }));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SucessoState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Home();
            }));
          }
          if (state is ErroState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.erro)));
          }
        },
        builder: (context, state) {
          return Form(
            key: form,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bem vindo!',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    TextFormField(
                      enabled: state is! CarregandoState,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Mask.validations.email(value),
                      controller: email,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'E-mail',
                          hintText: 'exemplo@exemplo.com'),
                    ),
                    TextFormField(
                      enabled: state is! CarregandoState,
                      validator: validacao,
                      controller: senha,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          alignLabelWithHint: true,
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  mostrarSenha = !mostrarSenha;
                                });
                              },
                              icon: Icon(mostrarSenha
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                      obscureText: !mostrarSenha,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Lembrar-se'),
                        const Spacer(),
                        Toggle((ativo) {
                          lembrar = ativo;
                        }),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: FilledButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: state is CarregandoState
                                    ? null
                                    : () {
                                        if (form.currentState!.validate()) {
                                          context.read<LoginBloc>().add(
                                              LogarEvent(email.text, senha.text,
                                                  lembrar));
                                        }
                                      },
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(height: 5),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
