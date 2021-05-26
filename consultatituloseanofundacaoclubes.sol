//SPDX-License-Identifier: NONE
//Contrato criado inicialmente por Claudio Girao
//Funcoes alteradas por Wallace Vieira

pragma solidity 0.8.4;

//Permite consultar ano de fundacao dos clubes e titulos dos clubes ao longo dos anos

contract ChecaAnosETitulosDosClubes {
    
    //mapeamento de clube e ano de fundacao
    mapping (string => uint) private anoFundacao;
    //etiqueta ou chave ou key -> nome do clube
    //e dentro do item será armazenado uint (numero -> ano de fundacao)
    
    
    //Array de strins
    string[] private trofeus;
    //Atribuicao da chave eh feita automaticamente pelo solidity
    //A chave eh um numero inteiro sequencial
    
    constructor () {
        anoFundacao ["Corinthians"] = 1910;
        // ETC
        trofeus.push("Ano de 2010 -> Corinthians"); // 0 
        trofeus.push("Ano de 2011 -> Corinthians"); // 1
        trofeus.push("Ano de 2012 -> Corinthians"); // 2
    
    }
    
    function incluirTrofeus(string memory _anoDoTrofeuEClube) public {
        trofeus.push(_anoDoTrofeuEClube);
    }
    
    function consultarAnoEClubeVencedor(uint _numeroDoTrofeu) public view returns (string memory) {
        return trofeus[_numeroDoTrofeu];
    }
    
    //permite vincular no mapping o ano de fundacao aos clubes
    
    function incluirAnoDeFundacaoDosClubes(string memory _clube, uint _anoDeFundacao) public {
        anoFundacao[_clube] = _anoDeFundacao;
    }
    
    //consultar o ano em que o clube foi fundado
    
    function consultarAnoDeFundacaoDosClubes (string memory _clube) public view returns (uint) {
        return anoFundacao [_clube];
    }
    
}
