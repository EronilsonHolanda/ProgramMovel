class Conta {
  String _titular;
  int _numeroConta;
  double _saldo;

  Conta(this._titular, this._numeroConta, this._saldo);

  String get titular => _titular;
  int get numeroConta => _numeroConta;
  double get saldo => _saldo;

  set titular(String novoTitular) {
    if (novoTitular.isNotEmpty) {
      _titular = novoTitular;
    }
  }

  set numeroConta(int novoNumeroConta) {
    if (novoNumeroConta > 0) {
      _numeroConta = novoNumeroConta;
    }
  }

  void depositar(double valor) {
    if (valor > 0) {
      _saldo += valor;
      print("Depósito de $valor realizado com sucesso.");
    } else {
      print("Valor inválido para depósito.");
    }
  }

  bool sacar(double valor) {
    if (valor > 0 && valor <= _saldo) {
      _saldo -= valor;
      print("Saque de $valor realizado com sucesso.");
      return true;
    } else {
      print("Saldo insuficiente.");
      return false;
    }
  }

  bool transferir(double valor, Conta contaDestino) {
    if (sacar(valor)) {
      contaDestino.depositar(valor);
      print("Transferência de $valor para a conta de ${contaDestino.titular} realizada com sucesso."); 
      return true;
    } else {
      print("Transferência não concluída.");
      return false;
    }
  }

  void mostrarSaldo() {
    print("Saldo da conta de $_titular: R\$ $_saldo");
  }
}

void main() {
  Conta conta1 = Conta("João", 12345, 1000.0);
  Conta conta2 = Conta("Maria", 54321, 500.0);

  conta1.mostrarSaldo();
  conta2.mostrarSaldo();

  conta1.depositar(200.0);
  conta1.mostrarSaldo();

  conta1.sacar(150.0);
  conta1.mostrarSaldo();

  conta1.transferir(300.0, conta2);
  conta1.mostrarSaldo();
  conta2.mostrarSaldo();
}
