import 'dart:io';
import 'Pizza.dart';
import 'Pedido.dart';

void main() {
  List<Pizza> cardapio = [];
  List<Pedido> pedidos = [];
  int codigoPedido = 1;

  // Função para carregar os dados do arquivo
  void carregarDados() {
    final pizzasFile = File('pizzas.txt');
    final pedidosFile = File('pedidos.txt');

    if (pizzasFile.existsSync()) {
      final pizzaLines = pizzasFile.readAsLinesSync();
      cardapio = pizzaLines.map((line) => Pizza.fromText(line)).toList();
    }

    if (pedidosFile.existsSync()) {
      final pedidoLines = pedidosFile.readAsLinesSync();
      pedidos = pedidoLines.map((line) => Pedido.fromText(line, cardapio)).toList();
    }
  }

  // Função para salvar os dados no arquivo
  void salvarDados() {
    final pizzasFile = File('pizzas.txt');
    final pedidosFile = File('pedidos.txt');

    final pizzaText = cardapio.map((pizza) => pizza.toText()).join('\n');
    final pedidoText = pedidos.map((pedido) => pedido.toText()).join('\n');

    pizzasFile.writeAsStringSync(pizzaText);
    pedidosFile.writeAsStringSync(pedidoText);
  }

  // Carregar os dados ao iniciar o programa
  carregarDados();

  while (true) {
    print("--------------------------------");
    print("PIZZARIA ITALIANA");
    print("--------------------------------");
    print("\nMenu de opções:");
    print("1) Cadastrar pizza");
    print("2) Editar pizza");
    print("3) Remover pizza");
    print("4) Fazer Pedido");
    print("5) Listar Pizzas");
    print("6) Listar pedidos");
    print("7) Sair");
    print("--------------------------------");

    stdout.write("Digite a opção desejada: ");
    var opcao = int.parse(stdin.readLineSync()!);

    if (opcao == 1) {
      print("--------------------------------");
        stdout.write("Digite o código da pizza: ");
      var codigoPizza = int.parse(stdin.readLineSync()!);

      if (cardapio.any((pizza) => pizza.codigo == codigoPizza)) {
        print(
            "Já existe uma pizza com este código. Código duplicado não é permitido.");
      } else {
        stdout.write("Digite o sabor da pizza: ");
        var saborPizza = stdin.readLineSync()!;
        stdout.write("Digite o preço da pizza: ");
        var precoPizza = double.parse(stdin.readLineSync()!);

        var novaPizza = Pizza(codigoPizza, saborPizza, precoPizza);
        cardapio.add(novaPizza);

        print("Pizza cadastrada com sucesso!");
        print("--------------------------------");
      }
    } else if (opcao == 2) {
      print("--------------------------------");
      print("\nEditar pizza:");
      if (cardapio.isEmpty) {
        print("Não há pizzas cadastradas.");
      } else {
        print("Pizzas no cardápio:");
        for (var i = 0; i < cardapio.length; i++) {
          print("${i + 1}) ${cardapio[i]}");
        }

        stdout.write("Digite o código da pizza que deseja editar: ");
        var codigoEditar = int.parse(stdin.readLineSync()!);

        var pizzaEditarIndex =
            cardapio.indexWhere((pizza) => pizza.codigo == codigoEditar);

        if (pizzaEditarIndex != -1) {
          var pizzaEditar = cardapio[pizzaEditarIndex];
          print("Pizza encontrada: ${pizzaEditar}");
          stdout.write(
              "Digite o novo sabor da pizza (ou deixe em branco para manter o mesmo): ");
          var novoSabor = stdin.readLineSync()!;
          if (novoSabor.isNotEmpty) {
            pizzaEditar.sabor = novoSabor;
          }

          stdout.write(
              "Digite o novo preço da pizza (ou deixe em branco para manter o mesmo): ");
          var novoPreco = stdin.readLineSync()!;
          if (novoPreco.isNotEmpty) {
            pizzaEditar.preco = double.parse(novoPreco);
          }
          print("--------------------------------");
          print("Pizza editada com sucesso!");
        } else {
          print("Código de pizza inválido. Tente novamente.");
        }
        print("--------------------------------");
      }
    } else if (opcao == 3) {
      print("--------------------------------");
      print("\nRemover pizza:");
      if (cardapio.isEmpty) {
        print("Não há pizzas cadastradas.");
      } else {
        print("Pizzas no cardápio:");
        for (var i = 0; i < cardapio.length; i++) {
          print("${i + 1}) ${cardapio[i]}");
        }

        stdout.write("Digite o código da pizza que deseja remover: ");
        var codigoRemover = int.parse(stdin.readLineSync()!);

        var pizzaRemover =
            cardapio.indexWhere((pizza) => pizza.codigo == codigoRemover);

        if (pizzaRemover != -1) {
          cardapio.removeAt(pizzaRemover);
          print("Pizza removida com sucesso!");
        } else {
          print("Código de pizza não encontrado.");
        }
        print("--------------------------------");
      }
    } else if (opcao == 4) {
      // Fazer pedido
      if (cardapio.isEmpty) {
        print("Não há pizzas cadastradas.");
      } else {
        print("--------------------------------");
        print("\nPizzas no cardápio:");
        for (var i = 0; i < cardapio.length; i++) {
          print("${i + 1}) ${cardapio[i]}");
        }

        print(
            "\nDigite os códigos das pizzas que deseja incluir no pedido (0 para encerrar o pedido):");
        var totalPedido = 0.0;
        var pizzaEncontrada = false;
        var pedidoAtual = <Pizza>[]; // Lista para rastrear o pedido atual

        while (true) {
          stdout.write("Código da pizza (0 para encerrar): ");
          var codigoPedido = int.parse(stdin.readLineSync()!);

          if (codigoPedido == 0) {
            break;
          }

          for (var pizza in cardapio) {
            if (pizza.codigo == codigoPedido) {
              pedidoAtual.add(pizza);
              totalPedido += pizza.preco;
              print("${pizza.sabor} adicionada ao pedido.");
              pizzaEncontrada = true;
              break;
            }
          }

          if (!pizzaEncontrada) {
            print("Código de pizza inválido. Tente novamente.");
          }
          pizzaEncontrada = false;
        }

        if (pedidoAtual.isNotEmpty) {
          var dataPedido = DateTime.now();
          var novoPedido =
              Pedido(codigoPedido, dataPedido, pedidoAtual, totalPedido);
          pedidos.add(novoPedido); // Adicionar o pedido à lista de pedidos
          codigoPedido++; // Incrementar o próximo código disponível
          print("\nPedido realizado com sucesso!");
        } else {
          print("Pedido vazio.");
        }
        print("--------------------------------");
      }
    } else if (opcao == 5) {
      print("\nPizzas no cardápio:");
      for (var i = 0; i < cardapio.length; i++) {
        print("${i + 1}) ${cardapio[i]}");
      }
    } else if (opcao == 6) {
      // Listar pedidos
      if (pedidos.isEmpty) {
        print("--------------------------------");
        print("Não há pedidos realizados.");
      } else {
        print("\nPedidos realizados:");

        for (var pedido in pedidos) {
          print("Código do Pedido: ${pedido.codigo}");
          print("Data do Pedido: ${pedido.data}");
          print("Pizzas:");
          for (var pizza in pedido.pizzas) {
            print(" - ${pizza.sabor}");
          }
          print("Valor Total do Pedido: R\$ ${pedido.valorTotal}");
          print("");
        }
        print("--------------------------------");
      }
    } else if (opcao == 7) {
      print("--------------------------------");
      print("Volte Sempre !");
      print("--------------------------------");
      // Encerrar o programa e salvar os dados
      salvarDados();
      break;
    } else {
      print("Opção inválida. Tente novamente.");
    }
  }
}
