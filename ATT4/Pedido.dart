import 'Pizza.dart';

class Pedido {
  int codigo;
  DateTime data;
  List<Pizza> pizzas;
  double valorTotal;

  Pedido(this.codigo, this.data, this.pizzas, this.valorTotal);
}