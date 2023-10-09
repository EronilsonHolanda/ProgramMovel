import 'Pizza.dart';

class Pedido {
  int codigo;
  DateTime data;
  List<Pizza> pizzas;
  double valorTotal;

  Pedido(this.codigo, this.data, this.pizzas, this.valorTotal);

  // Função para serializar um pedido em uma linha de texto
  String toText() {
    final pizzaCodes = pizzas.map((pizza) => pizza.codigo.toString()).join(',');
    return '$codigo|$data|$pizzaCodes|$valorTotal';
  }

  // Função para criar um pedido a partir de uma linha de texto
  static Pedido fromText(String line, List<Pizza> pizzaMenu) {
    final parts = line.split('|');
    final codigo = int.parse(parts[0]);
    final data = DateTime.parse(parts[1]);
    final pizzaCodes = parts[2].split(',').map(int.parse).toList();
    final valorTotal = double.parse(parts[3]);

    final pizzas = pizzaMenu.where((pizza) => pizzaCodes.contains(pizza.codigo)).toList();
    return Pedido(codigo, data, pizzas, valorTotal);
  }
}
