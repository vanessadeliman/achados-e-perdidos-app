import 'dart:io';

import 'package:achados_e_perdidos/componentes/camera.dart';
import 'package:achados_e_perdidos/modelos/status.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroItemTab extends StatefulWidget {
  const CadastroItemTab({super.key});

  @override
  State<CadastroItemTab> createState() => _CadastroItemTabState();
}

class _CadastroItemTabState extends State<CadastroItemTab> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController quando = TextEditingController();
  final TextEditingController onde = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  Status status = Status.pendente;

  List<String> imagens = [];

  final newFolderPath = '/storage/emulated/0/Download';

  GlobalKey<FormState> chave = GlobalKey<FormState>();

  String? validator(String? text) {
    if (nome.text.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  final GlobalKey _fieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Cadastrar item',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
      body: Form(
        key: chave,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Preencha o formulário com informações sobre o objeto',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nome,
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Insira o nome do item',
                hintText: 'Nome',
              ),
            ),

            const SizedBox(height: 20),
            Text('Imagem', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();
                        for (File index in files) {
                          imagens.add(index.path);
                        }
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.upload),
                          Text(
                            'Imagem da galeria',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      late List<CameraDescription> cameras;
                      cameras = await availableCameras();
                      String? imagem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Camera(cameras[0]);
                          },
                        ),
                      );
                      if (imagem != null) {
                        setState(() {
                          imagens.add(imagem);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera),
                          Text(
                            'Abrir camera',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            imagens.isEmpty
                ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).highlightColor,
                  ),
                  height: 200,
                  child: const Center(child: Text('Nenhuma imagem adicionada')),
                )
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: imagens.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: GestureDetector(
                                child: Image.file(
                                  File(imagens[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    imagens.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            const SizedBox(height: 20),
            TextFormField(
              key: _fieldKey,
              controller: statusController,
              validator: validator,
              readOnly: true,
              onTap: () async {
                final RenderBox renderBox =
                    _fieldKey.currentContext!.findRenderObject() as RenderBox;
                final Offset offset = renderBox.localToGlobal(Offset.zero);
                final Size size = renderBox.size;
                final Status? statusSelecionado = await showMenu<Status>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + size.height,
                    offset.dx + size.width,
                    offset.dy,
                  ),
                  items: List.generate(
                    Status.values.length,
                    (index) => PopupMenuItem(
                      value: Status.values[index],
                      child: Text(Status.values[index].name),
                    ),
                  ),
                );
                if (statusSelecionado != null) {
                  setState(() {
                    statusController.text = statusSelecionado.name;
                    status = statusSelecionado;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Qual a situação do objeto?',
                hintText: 'Situação',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: quando,
              readOnly: true,
              validator: validator,
              onTap: () async {
                final DateTime? data = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2015),
                  lastDate: DateTime(2100),
                );

                if (data != null) {
                  setState(() {
                    quando.text = DateFormat('dd/MM/yyyy').format(data);
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Quando aconteceu?',
                hintText: 'Quando aconteceu?',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: onde,
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Onde ocorreu?',
                hintText: 'Onde ocorreu?',
              ),
            ),
            TextFormField(
              controller: descricao,
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Faça uma breve descrição do item',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {},
        label: const Text('Salvar'),
      ),
    );
  }
}
