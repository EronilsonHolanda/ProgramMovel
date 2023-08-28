import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Banco {
    private List<Conta> contas;
    private List<Titular> titulares;

    public Banco(){
        contas = new ArrayList<>();
        titulares = new ArrayList<>();
    }
    
    public void adicionaTitular(String nome, String telefone, String endereco){
        Titular titular = new Titular(nome, telefone, endereco);
        titulares.add(titular);       
    }
    public void adicionaConta(Titular titular, double saldo){
        Conta conta = new Conta(titular, saldo);
        contas.add(conta);
    }

    public Titular encontraTitularPorId(int id) {
        for (Titular titular : titulares) {
            if (titular.getId() == id) {
                return titular;
            }
        }
        return null;
    }

    public Conta encontrarContaPorId(int id){
        for (Conta conta : contas){
            if(conta.getId() == id){
                return conta;
            }
        }
        return null;
    }
    
    public void exibirTodosOsTitulares() {
        System.out.println("Lista de Todos os Titulares:");
        for (Titular titular : titulares) {
            System.out.println("ID: " + titular.getId());
            System.out.println("Nome: " + titular.getNome());
            System.out.println("Telefone: " + titular.getTelefone());
            System.out.println("Endereço: " + titular.getEndereco());
            System.out.println("-----------------------");
        }
    }

    public void exibirTodasAsContas(){
        System.out.println("Lista de Todas as Contas");
        for (Conta conta : contas){
            System.out.println("ID: " + conta.getId());
            System.out.println("Titular: " + conta.getTitular().getNome());
            System.out.println("Saldo: " + conta.getSaldo());
            System.out.println("-----------------------");
        }
    }

    public void atualizarTitular(int id, String novoNome, String novoTelefone, String novoEndereco) {
        for (Titular titular : titulares) {
            if (titular.getId() == id) {
                titular.setNome(novoNome);
                titular.setTelefone(novoTelefone);
                titular.setEndereco(novoEndereco);
                System.out.println("Titular atualizado com sucesso.");
                return;
            }
        }
        System.out.println("Titular não encontrado com o ID fornecido.");
    }

    public void atualizarConta(int id){
        for (Conta conta : contas){
            if (conta.getId() == id){
                System.out.println("Conta atualizada com sucesso.");
                return;
            }
        }
        System.out.println("Conta não encontrada com o ID fornecido");
    }

    public void removerTitular(int id) {
        Iterator<Titular> iterator = titulares.iterator();
        while (iterator.hasNext()) {
            Titular titular = iterator.next();
            if (titular.getId() == id) {
                iterator.remove();
                System.out.println("Titular removido com sucesso.");
                return;
            }
        }
        System.out.println("Titular não encontrado com o ID fornecido.");
    }

    public void removerConta(int id){
        Iterator<Conta> iterator = contas.iterator();
        while (iterator.hasNext()){
            Conta conta = iterator.next();
            if (conta.getId() == id){
                iterator.remove();
                System.out.println("Conta removida com sucesso.");
                return;
            }
        }
        System.out.println("Conta não encontrada com o ID fornecido.");
    }
}
