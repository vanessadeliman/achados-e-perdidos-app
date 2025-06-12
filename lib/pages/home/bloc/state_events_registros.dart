import 'package:achados_e_perdidos/modelos/ocorrencia.dart';

abstract class RegistrosState {}

class InitState extends RegistrosState {}

class CarregandoState extends RegistrosState {}

class SucessoState extends RegistrosState {}

class ErroState extends RegistrosState {
  final String erro;
  ErroState(this.erro);
}

class ItemCadastradoComSucesso extends RegistrosState {}

abstract class RegistrosEvents {}

class CadastrarItem extends RegistrosEvents {
  final Ocorrencia ocorrencia;
  CadastrarItem(this.ocorrencia);
}

class CadastrarEvent extends RegistrosEvents {}
