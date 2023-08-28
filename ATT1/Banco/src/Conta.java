public class Conta {
    private static int contadorIds = 1; // Contador de IDs
    private Titular titular;
    private int id;
    private double saldo;

public Conta(){

}
public Conta(Titular titular, double saldo){
    this.titular = titular;
    this.id = contadorIds++;
    this.saldo = saldo;
}

public int getId() {
    return id;
}

public double getSaldo(){
    return saldo;
}

public Titular getTitular(){
    return titular;
}

public void setSaldo(double saldo){
    this.saldo = saldo;
}

public void depositar(double valor) {
    if (valor >= 0) {
        saldo += valor;
    } else {
        System.out.println("Não é possível depositar um valor negativo.");
    }
}
public boolean sacar(double valor) {
    if (valor >= 0) {
        if (saldo >= valor) {
            saldo -= valor;
            return true;
        } else {
            System.out.println("Saldo insuficiente");
            return false;
        }
    } else {
        System.out.println("Não é possível sacar um valor negativo.");
        return false;
    }
}
public void transferir(Conta destino, double valor){
        if (sacar(valor)) {
            destino.depositar(valor);
            System.out.println("Transferencia realizada");
        } else {
            System.out.println("Transferencia não realizada");
        }
        
        

}
public double consultarSaldo(){
    return saldo;
}

public String toString() {
    return " Saldo: " + saldo;
    }
}
