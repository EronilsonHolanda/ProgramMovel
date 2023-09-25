import 'dart:io';

class Banco {
  List<Titular> titulares = [];
  List<Conta> contas = [];

  void cadastrarTitular() {
    stdout.write('Digite o nome do titular: ');
    String nome = stdin.readLineSync()!;
    stdout.write('Digite o telefone do titular: ');
    String telefone = stdin.readLineSync()!;
    stdout.write('Digite o endereço do titular: ');
    String endereco = stdin.readLineSync()!;

    Titular titular = Titular(nome, telefone, endereco);
    titulares.add(titular);
    print('Titular cadastrado com sucesso.');
  }

  void abrirConta() {
    stdout.write('Digite o saldo da conta: ');
    double saldo = double.parse(stdin.readLineSync()!);
    stdout.write('Digite a descrição da conta: ');
    String descricao = stdin.readLineSync()!;

    listarTitulares();
    stdout.write('Digite o ID do titular para associar a esta conta: ');
    int idTitular = int.parse(stdin.readLineSync()!);

    Titular? titularEncontrado = titulares.firstWhereOrNull((titular) => titular.id == idTitular);

    if (titularEncontrado != null) {
      Conta conta = Conta(saldo, titularEncontrado, descricao);
      contas.add(conta);
      print('Conta cadastrada com sucesso.');
    } else {
      print('Titular não encontrado com o ID fornecido.');
    }
  }

  void listarTitulares() {
    print('Lista de Titulares:');
    for (var titular in titulares) {
      print('ID: ${titular.id}, Nome: ${titular.nome}');
    }
  }

  void listarContas() {
    print('Lista de Contas:');
    for (var conta in contas) {
      print('ID da Conta: ${conta.id}, Saldo: ${conta.saldo}, Titular: ${conta.titular.nome}');
    }
  }

  void sacar() {
    listarContas();
    stdout.write('Digite o ID da conta para sacar: ');
    int idConta = int.parse(stdin.readLineSync()!);
    Conta? conta = contas.firstWhereOrNull((conta) => conta.id == idConta);

    if (conta != null) {
      stdout.write('Digite o valor para sacar: ');
      double valor = double.parse(stdin.readLineSync()!);

      if (valor > 0) {
        conta.sacar(valor);
      } else {
        print('Valor de saque inválido.');
      }
    } else {
      print('Conta não encontrada com o ID fornecido.');
    }
  }

  void depositar() {
    listarContas();
    stdout.write('Digite o ID da conta para depositar: ');
    int idConta = int.parse(stdin.readLineSync()!);
    Conta? conta = contas.firstWhereOrNull((conta) => conta.id == idConta);

    if (conta != null) {
      stdout.write('Digite o valor para depositar: ');
      double valor = double.parse(stdin.readLineSync()!);

      if (valor > 0) {
        conta.depositar(valor);
      } else {
        print('Valor de depósito inválido.');
      }
    } else {
      print('Conta não encontrada com o ID fornecido.');
    }
  }

  void transferir() {
    listarContas();
    stdout.write('Digite o ID da conta de origem: ');
    int idContaOrigem = int.parse(stdin.readLineSync()!);
    Conta? contaOrigem = contas.firstWhereOrNull((conta) => conta.id == idContaOrigem);

    if (contaOrigem != null) {
      stdout.write('Digite o ID da conta de destino: ');
      int idContaDestino = int.parse(stdin.readLineSync()!);
      Conta? contaDestino = contas.firstWhereOrNull((conta) => conta.id == idContaDestino);

      if (contaDestino != null) {
        stdout.write('Digite o valor a transferir: ');
        double valor = double.parse(stdin.readLineSync()!);

        if (valor > 0 && valor <= contaOrigem.saldo) {
          contaOrigem.sacar(valor);
          contaDestino.depositar(valor);
          print('Transferência realizada com sucesso.');
        } else {
          print('Valor de transferência inválido ou saldo insuficiente na conta de origem.');
        }
      } else {
        print('Conta de destino não encontrada com o ID fornecido.');
      }
    } else {
      print('Conta de origem não encontrada com o ID fornecido.');
    }
  }

  void mostrarSaldo() {
    listarContas();
    stdout.write('Digite o ID da conta para mostrar o saldo: ');
    int idConta = int.parse(stdin.readLineSync()!);
    Conta? conta = contas.firstWhereOrNull((conta) => conta.id == idConta);

    if (conta != null) {
      print('Saldo da Conta ID ${conta.id}: ${conta.saldo}');
    } else {
      print('Conta não encontrada com o ID fornecido.');
    }
  }

  void menuPrincipal() {
    int opcao = -1;

    do {
      print('Menu Principal:');
      print('1. Cadastro de Titular');
      print('2. Cadastro de Conta');
      print('3. Operar Conta');
      print('4. Sair');
      stdout.write('Escolha uma opção: ');

      try {
        opcao = int.parse(stdin.readLineSync()!);

        switch (opcao) {
          case 1:
            cadastrarTitular();
            break;
          case 2:
            abrirConta();
            break;
          case 4:
            print('Encerrando o programa.');
            break;
          default:
            print('Opção inválida. Tente novamente.');
        }
      } catch (e) {
        print('Entrada inválida. Tente novamente.');
      }
    } while (opcao != 4);
  }
}

class Titular {
  static int contadorIds = 1;
  int id;
  String nome;
  String telefone;
  String endereco;

  Titular(this.nome, this.telefone, this.endereco) : id = contadorIds++;
}

class Conta {
  static int contadorIds = 1;
  int id;
  double saldo;
  Titular titular;
  String descricao;

  Conta(this.saldo, this.titular, this.descricao) : id = contadorIds++;

  void depositar(double valor) {
    if (valor > 0) {
      saldo += valor;
      print('Depósito de $valor realizado com sucesso. Novo saldo: $saldo');
    } else {
      print('Valor de depósito inválido.');
    }
  }

  void sacar(double valor) {
    if (valor > 0 && valor <= saldo) {
      saldo -= valor;
      print('Saque de $valor realizado com sucesso. Novo saldo: $saldo');
    } else {
      print('Saldo insuficiente ou valor de saque inválido.');
    }
  }
}

void main() {
  Banco banco = Banco();
  banco.menuPrincipal();
}

extension IterableExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool test(E element)) {
    for (final E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
