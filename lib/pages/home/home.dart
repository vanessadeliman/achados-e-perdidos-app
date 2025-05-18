import 'package:achados_e_perdidos/pages/home/tabs/cadastro_item_tab.dart';
import 'package:achados_e_perdidos/pages/home/tabs/config_tab.dart';
import 'package:achados_e_perdidos/pages/home/tabs/feed_tab.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
        onTap:
            (value) => setState(() {
              index = value;
              controller.animateTo(value);
            }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Adicionar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),

      body: TabBarView(
        controller: controller,
        children: [FeedTab(), CadastroItemTab(), ConfigTab()],
      ),
    );
  }
}
