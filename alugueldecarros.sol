/*
SPDX-License-Identifier: CC-BY-4.0
Smart contract para atribuição de nota - Feito por Wallace Vieira
*/
pragma solidity 0.8.4;

contract AluguelDeCarros {

    struct Locador {
        string nome;
        address payable enderecoCarteira;
        uint idade;
        bool jaLocouAntes;
    }

    uint constant public idadeMinima = 21;

    mapping (string => uint) public potenciaCarrosEmCv;
    
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

    address payable contaLocadoraSoCarrao;
    uint prazoFinalLocacao = block.timestamp + 84600; //a locação é padronizada em um dia

    event novoCadastroUsuario(string Locador);

    modifier verificaIdade {
        require(msg.value <= idadeMinima, "Somente Pessoas com Mais de 21 Anos Podem Alugar Carros");
        _;
    }
   
    function incluirCarros(string memory _novoCarro) public {
        ordemDeChegadaDosCarros.push(_novoCarro);
    }
    
    function consultarOrdemDeChegadaDosCarros(uint _ordemChegadaCarro) public view returns (string memory) {
        return ordemDeChegadaDosCarros[_ordemChegadaCarro];
    }
    
    function atribuirPotenciaAtualDoCarro(string memory _carro, uint _novaPotencia) public {
        potenciaCarrosEmCv[_carro] = _novaPotencia;
    }
    
    function consultarPotenciaAtualDoCarro (string memory _carro) public view returns (uint) {
        return potenciaCarrosEmCv[_carro];
    }
   
    function consultaTerminoLocacao() public payable verificaIdade {
       
        require(block.timestamp >= prazoFinalLocacao, "Locacao em andamento.");
        require(block.timestamp <= prazoFinalLocacao, "Locacao Encerrada. Devolva o Veiculo.");

        contaLocadoraSoCarrao.transfer(address(this).balance);
    }
}
