import 'package:achados_e_perdidos/componentes/toggle.dart';
import 'package:achados_e_perdidos/pages/home/home.dart';
import 'package:achados_e_perdidos/pages/apresentacao.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/login_bloc.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/state_events_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask/mask/mask.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final TextEditingController matricula = TextEditingController();
  final TextEditingController instituicao = TextEditingController();
  final TextEditingController nome = TextEditingController();
  final TextEditingController confirmaSenha = TextEditingController();
  bool mostrarSenha = false;
  bool mostrarSenhaConfirma = false;
  bool lembrar = false;

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? validacao(String? valor) {
    if (valor != null && valor.isEmpty) {
      return 'Informe sua senha!';
    }
    if (senha.text != confirmaSenha.text) {
      return 'As senhas devem ser iguais';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BemVindoPage();
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        toolbarHeight: 60,
        actions: [],
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SucessoState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeProvider();
                },
              ),
            );
          }
          if (state is ErroState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.erro)));
          }
        },
        builder: (context, state) {
          return Form(
            key: form,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Text(
                      'Criar nova conta',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                TextFormField(
                  enabled: state is! CarregandoState,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      (value) => Mask.validations.generic(
                        value,
                        error: 'Informe o seu nome',
                      ),
                  controller: nome,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                  ),
                ),
                TextFormField(
                  enabled: state is! CarregandoState,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      (value) => Mask.validations.generic(
                        value,
                        error: 'Informe o nome da sua instituição',
                      ),
                  controller: instituicao,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Instituição',
                    hintText: 'Digite o nome da sua instituição',
                  ),
                ),
                TextFormField(
                  enabled: state is! CarregandoState,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      (value) => Mask.validations.generic(
                        value,
                        error: 'Informe a sua matricula',
                      ),
                  controller: matricula,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Matricula',
                    hintText: '0000000000000000',
                  ),
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
                    hintText: 'exemplo@exemplo.com',
                  ),
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
                      icon: Icon(
                        mostrarSenha ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: !mostrarSenha,
                ),
                TextFormField(
                  enabled: state is! CarregandoState,
                  validator: validacao,
                  controller: confirmaSenha,
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    hintText: 'Digite novamente sua senha',
                    alignLabelWithHint: true,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          mostrarSenhaConfirma = !mostrarSenhaConfirma;
                        });
                      },
                      icon: Icon(
                        mostrarSenhaConfirma
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: !mostrarSenhaConfirma,
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
                const SizedBox(height: 30),
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
                        onPressed:
                            state is CarregandoState
                                ? null
                                : () {
                                  if (form.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                      CadastrarEvent(
                                        email: email.text,
                                        senha: senha.text,
                                        instituicao: instituicao.text,
                                        matricula: matricula.text,
                                        nome: nome.text,
                                        lembrar: lembrar,
                                      ),
                                    );
                                  }
                                },
                        child: const Text(
                          'Cadastrar-se',
                          style: TextStyle(height: 5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
