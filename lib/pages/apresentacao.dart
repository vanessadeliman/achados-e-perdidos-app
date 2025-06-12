import 'package:achados_e_perdidos/pages/login_cadastro/cadastro.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/login.dart';
import 'package:flutter/material.dart';

class BemVindoPage extends StatelessWidget {
  const BemVindoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Image.asset('assets/logo.png', scale: 2),
          Text(
            'Bem-vindo ao Achados & Perdidos!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            '🎒 Aqui, seus objetos perdidos têm mais chances de voltar para casa. 🧭',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '🔍 Perdeu algo? Publique e conte com a ajuda da comunidade.\n'
            '📢 Achou algo? Informe aqui e ajude a devolver para quem está procurando.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            '💬✨ Juntos, conectamos pessoas e devolvemos histórias.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                  child: const Text('Entrar', style: TextStyle(height: 5)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CadastroPage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Não tem conta? Cadastre-se',
                    style: TextStyle(height: 5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
