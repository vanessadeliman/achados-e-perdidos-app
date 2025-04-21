import 'package:achados_e_perdidos/componentes/card_item.dart';
import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                'assets/backgroud.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text('IFCE'),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 150),
                Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8FAFE),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    187,
                                    187,
                                    187,
                                  ),
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  hintText: 'Buscar objeto...',
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              fixedSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ), // ← aqui ajusta os cantos
                              ),
                              side: BorderSide(
                                color: const Color.fromARGB(255, 187, 187, 187),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            icon: Icon(
                              Icons.tune,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {},
                            label: Text(
                              'Filtro',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Itens encontrados',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      CardItem(),
                      CardItem(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
