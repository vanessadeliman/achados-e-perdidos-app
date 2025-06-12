import 'package:achados_e_perdidos/pages/home/bloc/registros_bloc.dart';
import 'package:achados_e_perdidos/pages/home/tabs/cadastro_item_tab.dart';
import 'package:achados_e_perdidos/pages/home/tabs/config_tab.dart';
import 'package:achados_e_perdidos/pages/home/tabs/feed_tab.dart';
import 'package:achados_e_perdidos/pages/login_cadastro/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrosBloc(context.read<LoginBloc>().sessaoAtiva),
      child: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin {
  int index = 0;
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, initialIndex: index, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: irPara,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Adicionar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),

      body: TabBarView(
        controller: controller,
        children: [
          FeedTab(),
          BlocProvider.value(
            value: context.read<RegistrosBloc>(),
            child: CadastroItemTab(irPara),
          ),
          ConfigTab(),
        ],
      ),
    );
  }

  void irPara(value) => setState(() {
    index = value;
    controller.animateTo(value);
  });
}
