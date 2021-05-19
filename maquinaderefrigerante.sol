// SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.8.4;

contract MaquinaDeRefrigerante {
        string private cocaCola;
        string private pepsiCola;
        string private primeiraOpcao;
        string private segundaOpcao;
        uint constant public valorCocaCola = 5;
        uint constant public valorPepsiCola = 4;
        
        constructor () {

            primeiraOpcao = "cocaCola";
            segundaOpcao = "pepsiCola";
        }
        
    function obtemPrimeiraOpcaoDisponivel() public view returns (string memory) {
        return primeiraOpcao;
    }
    
    function obtemSegundaOpcaoDisponivel() public view returns (string memory) {
        return segundaOpcao;
    }

    function verificaQualRefrigeranteEntrega(uint valorDepositado) public view returns (string memory) {
        string memory result;
        
        if (valorDepositado == valorCocaCola) {
            result = "Entregar CocaCola";
        } else if (valorDepositado == valorPepsiCola) {
            result = "Entregar PepsiCola";
        } else if (valorDepositado < valorPepsiCola) {
            result = "Valor Insuficiente";
        } else if (valorDepositado > valorCocaCola) {
            result = "Valor Excedente";
        }
    }
}
