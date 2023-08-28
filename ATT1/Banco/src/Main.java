import java.util.Scanner;
public class Main
{
	public static void main(String[] args) {
        Scanner entrada = new Scanner(System.in);
        Banco banco = new Banco();
        int i, id;
        String nome, telefone, endereco;
        double valor;
        do{
                System.out.println("---------------------------------------");
                System.out.println("Escolha uma opção:");
                System.out.println("1 - Cadastro de titular ");
                System.out.println("2 - Cadastro de conta");
                System.out.println("3 - Operar uma conta");
                System.out.println("0 - Sair");
                System.out.println("---------------------------------------");
                i = entrada.nextInt();
                entrada.nextLine();
                switch(i){
                        case 1:
                        boolean submenuAtivo = true;
                        while (submenuAtivo) {
                        System.out.println("---------------------------------------");
                        System.out.println("Submenu - Cadastro de Titular:");
                        System.out.println("1 - Cadastre novo titular");
                        System.out.println("2 - Mostrar todos os titulares");
                        System.out.println("3 - Atualizar titular");
                        System.out.println("4 - Remover titular");
                        System.out.println("0 - Voltar ao menu principal");
                        System.out.println("---------------------------------------");
                        int submenuOpcao = entrada.nextInt();
                        entrada.nextLine();
                        switch (submenuOpcao) {
                                case 1:
                                System.out.println("Digite o nome do titular:");
                                nome = entrada.nextLine();
                                System.out.println("Digite o telefone do titular:");
                                telefone = entrada.nextLine();
                                System.out.println("Digite o endereço do titular:");
                                endereco = entrada.nextLine();
                                
                                banco.adicionaTitular(nome, telefone, endereco);
                                System.out.println("Titular cadastrado com sucesso.");
                                break;
                            case 2:
                                banco.exibirTodosOsTitulares();
                                break;
                            case 3:
                                System.out.println("Digite o ID do titular que deseja atualizar:");
                                int idTitular = entrada.nextInt();
                                entrada.nextLine();
                                System.out.println("Digite o novo nome:");
                                String novoNome = entrada.nextLine();
                                System.out.println("Digite o novo telefone:");
                                String novoTelefone = entrada.nextLine();
                                System.out.println("Digite o novo endereço:");
                                String novoEndereco = entrada.nextLine();
                                banco.atualizarTitular(idTitular, novoNome, novoTelefone, novoEndereco);
                                break;
                            case 4:
                                System.out.println("Digite o ID do titular que deseja remover:");
                                idTitular = entrada.nextInt();
                                entrada.nextLine();
                                banco.removerTitular(idTitular);
                                break;
                            case 0:
                                submenuAtivo = false;
                                break;
                            default:
                                System.out.println("Opção inválida no submenu.");
                                break;
                                }
                        }
                        break;

                        case 2:
                        submenuAtivo = true;
                        while (submenuAtivo){
                        System.out.println("---------------------------------------");
                        System.out.println("Submenu - Cadastro de Conta:");
                        System.out.println("1 - Cadastre nova conta");
                        System.out.println("2 - Mostrar todas as contas");
                        System.out.println("3 - Atualizar conta");
                        System.out.println("4 - Remover conta");
                        System.out.println("0 - Voltar ao menu principal");
                        System.out.println("---------------------------------------");
                        int submenuOpcao = entrada.nextInt();
                        entrada.nextLine();
                        switch (submenuOpcao) {
                                case 1:
                        System.out.println("---------------------------------------");
                        System.out.println("Digite o Id do titular da conta: ");
                        id = entrada.nextInt();
                        Titular titular = banco.encontraTitularPorId(id);
                        if (titular == null) {
                            System.out.println("Titular não encontrado.");
                            break;
                        }
                        entrada.nextLine();
                        double saldo = 0;  
                        banco.adicionaConta(titular, saldo);
                        System.out.println("Conta cadastrada com sucesso.");
                        System.out.println("---------------------------------------");
                                break;
                                case 2:
                                banco.exibirTodasAsContas();
                                break;
                                case 3:
                                System.out.println("Digite o ID da conta que deseja atualizar:");
                                int idConta = entrada.nextInt();
                                entrada.nextLine();
                                banco.atualizarConta(idConta);
                                break;
                                case 4:
                                System.out.println("Digite o ID da conta que deseja remover:");
                                idConta = entrada.nextInt();
                                entrada.nextLine();
                                banco.removerTitular(idConta);                               
                                break;
                                case 0:
                                submenuAtivo = false;
                                break;
                                default:
                                System.out.println("Opção inválida no submenu.");
                                break;
                        }
                        }
                        break;
                        case 3:
                        submenuAtivo = true;
                        while (submenuAtivo){
                        System.out.println("---------------------------------------");
                        System.out.println("Submenu - Operar a conta:");
                        System.out.println("1 - Depositar");
                        System.out.println("2 - Sacar");
                        System.out.println("3 - Transferir");
                        System.out.println("4 - Mostrar saldo");
                        System.out.println("0 - Voltar ao menu principal");
                        System.out.println("---------------------------------------");
                        int submenuOpcao = entrada.nextInt();
                        entrada.nextLine();
                        switch(submenuOpcao){
                            case 1:
                            System.out.println("---------------------------------------");
                            System.out.println("Digite o Id da conta: ");
                            id = entrada.nextInt();
                            Conta conta = banco.encontrarContaPorId(id);
                            if (conta == null) {
                                System.out.println("Conta não encontrado.");
                            break;
                            }

                            System.out.println("Digite o valor que deseja depositar: ");
                            valor = entrada.nextDouble();
                            conta.depositar(valor);          
                            break;
                            case 2:
                            System.out.println("---------------------------------------");
                            System.out.println("Digite o Id da conta: ");
                            id = entrada.nextInt();
                            conta = banco.encontrarContaPorId(id);
                            if (conta == null) {
                                System.out.println("Conta não encontrado.");
                            break;                           
                            }     
                            System.out.println("Digite o valor que deseja sacar: ");
                            valor = entrada.nextDouble();
                            conta.sacar(valor);                             
                            break;
                            case 3:
                            System.out.println("Digite o ID da conta de origem:");
                            int idContaOrigem = entrada.nextInt();
                            System.out.println("Digite o ID da conta de destino:");
                            int idContaDestino = entrada.nextInt();
                            System.out.println("Digite o valor a ser transferido:");
                            double valorTransferencia = entrada.nextDouble();
        
                            Conta contaOrigem = banco.encontrarContaPorId(idContaOrigem);
                            Conta contaDestino = banco.encontrarContaPorId(idContaDestino);
        
                            if (contaOrigem == null || contaDestino == null) {
                                System.out.println("Conta de origem ou destino não encontrada.");
                            } else {
                                contaOrigem.transferir(contaDestino, valorTransferencia);
                            }
                            break;
                            case 4:
                            System.out.println("---------------------------------------");
                            System.out.println("Digite o Id da conta: ");
                            id = entrada.nextInt();
                            conta = banco.encontrarContaPorId(id);
                            if (conta == null) {
                                System.out.println("Conta não encontrado.");
                            break;                           
                            }
                            System.out.println(conta.toString());                        
                            break;
                            case 0:
                            
                            submenuAtivo = false;
                            break;
                            default:
                            System.out.println("Opção inválida no submenu.");
                            break;
                        }

                        }
                        break;
                        case 0:
                        entrada.close();
                        System.out.println("Saindo...");
                        break;
                        default:
                        System.out.println("O número escolhido é inválido! Digite um número entre 1 a 3.");
                }
        } while(i!= 0);
        
	}
}
