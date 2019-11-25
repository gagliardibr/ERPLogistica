//
//  Pedido.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 01/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import Foundation

struct Pedido {
    
    //Pedido
    let codVenda: String
    let notaFiscal: String
    let data: String

    //cliente
    let nomeCliente: String
    let endereco: String
    
    init(codVenda: String = " ", notaFiscal: String = " ",  endereco: String = " ",
         nomeCliente: String = " ", data: String = " ") {
        
        self.codVenda = codVenda
        self.notaFiscal = notaFiscal
        self.endereco = endereco
        self.nomeCliente = nomeCliente
        self.data = data
    }
    
}
