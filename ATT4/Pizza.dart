class Pizza {
  int codigo;
  String sabor;
  double preco;

  Pizza(this.codigo, this.sabor, this.preco);

  @override
  String toString() {
    return 'Código: $codigo, Sabor: $sabor, Preço: R\$ $preco';
  }

  // Função para serializar uma pizza em uma linha de texto
  String toText() {
    return '$codigo|$sabor|$preco';
  }

  // Função para criar uma pizza a partir de uma linha de texto
  static Pizza fromText(String line) {
    final parts = line.split('|');
    return Pizza(int.parse(parts[0]), parts[1], double.parse(parts[2]));
  }
}
