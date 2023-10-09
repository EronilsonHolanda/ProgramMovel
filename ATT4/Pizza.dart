class Pizza {
  int codigo;
  String sabor;
  double preco;

  Pizza(this.codigo, this.sabor, this.preco);

  @override
  String toString() {
    return 'Código: $codigo, Sabor: $sabor, Preço: R\$ $preco';
  }
}
