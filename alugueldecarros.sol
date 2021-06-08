/*
SPDX-License-Identifier: CC-BY-4.0
Smart contract para atribuição de nota - Feito por Wallace Vieira
*/
pragma solidity 0.8.4;

//Este contrato visa proporcionar a facilitação de aluguel de carros por um dia inteiro mediante
//cadastro de usuarios com mais de 21 anos de idade.
//No contrato, eh possivel adicionar carros, atribuir e mudar potencia
//consultar em que ordem foram incluidos (para saber se sao mais novos ou mais velhos)
//e por fim consultar se o prazo de locacao acabou ou se ainda esta vigente

//OBS> nao consegui atribuir valores em Eter aos carros
//OBS2> nao consegui proporcionar o cadastro efetivo de novos utilizadores (clientes)
//OBS3> nao consegui tornar o carro indisponivel pelo tempo alugado

contract AluguelDeCarros {

    //essa struct seria para a coleta de dados de novos utilizadores (clientes)
    struct Locador {
        string nome;
        address payable enderecoCarteira;
        uint idade;
        bool jaLocouAntes;
    }

    //essa uint seria para definir a idade minima de novos clientes
    uint constant public idadeMinima = 21;

    //o mapping foi elaborado para cadastrar e fichar os novos carros, alem de etiquetar
    //e atribuir potencia aos carros
    mapping (string => uint) public potenciaCarrosEmCv;
    
    //a array seria para uma consulta de ordem de chegada dos carros
    //de modo a tornar possivel consultar os carros mais novos e mais antigos
    string[] public ordemDeChegadaDosCarros;
    
    constructor () {
        potenciaCarrosEmCv ["Gol"] = 100;
        potenciaCarrosEmCv ["Jetta"] = 200;
        potenciaCarrosEmCv ["Golf"] = 300;
        // ETC
        ordemDeChegadaDosCarros.push("Gol"); // 0 
        ordemDeChegadaDosCarros.push("Jetta"); // 1
        ordemDeChegadaDosCarros.push("Golf"); // 2
        // ETC
    }

    //essa seria a carteira (wallet) da locadora, a qual deveria receber o pagamento pela Locacao
    address payable contaLocadoraSoCarrao;
    
    //essa uint seria para estabelecer o prazo de locacao (sempre por 1 dia/24 horas)
    uint prazoFinalLocacao = block.timestamp + 84600; //a locação é padronizada em um dia

    //esse evento foi construido para avisar o cadastro de novos usuarios
    event novoCadastroUsuario(string Locador);

    //o modifier tem a funcao de verificar a idade quando os usuarios tentam checar o prazo de locacao
    modifier verificaIdade {
        require(msg.value <= idadeMinima, "Somente Pessoas com Mais de 21 Anos Podem Alugar Carros");
        _;
    }
   
    //essa funcao serve para incluir novos carros a serem alugados
    function incluirCarros(string memory _novoCarro) public {
        ordemDeChegadaDosCarros.push(_novoCarro);
    }
    
    //essa funcao serve para consultar a ordem de chegada dos carros, consultando os mais velhos e mais novos
    function consultarOrdemDeChegadaDosCarros(uint _ordemChegadaCarro) public view returns (string memory) {
        return ordemDeChegadaDosCarros[_ordemChegadaCarro];
    }
    
    //essa funcao serve para atribuir potencia aos carros, caso haja manutencao ou modificacao
    function atribuirPotenciaAtualDoCarro(string memory _carro, uint _novaPotencia) public {
        potenciaCarrosEmCv[_carro] = _novaPotencia;
    }
    
    //essa funcao serve para consultar a potencia atual de cada carro
    function consultarPotenciaAtualDoCarro (string memory _carro) public view returns (uint) {
        return potenciaCarrosEmCv[_carro];
    }
   
    //essa funcao serve para consultar o tempo de locacao, se ja terminou ou nao o periodo
    function consultaTerminoLocacao() public payable verificaIdade {
       
        require(block.timestamp >= prazoFinalLocacao, "Locacao em andamento.");
        require(block.timestamp <= prazoFinalLocacao, "Locacao Encerrada. Devolva o Veiculo.");
    
        contaLocadoraSoCarrao.transfer(address(this).balance);
    }
}
