//
//  Pedido.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 01/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

struct Pedido {
    
    //Pedido
    let codVenda: String
    let notaFiscal: String

    //cliente
    let nomeCliente: String
    let endereco: String
    
    //Data do pedido
    let data: String
    let status: String
    
    //Produto
    let produtos: [Produto]
    
    init(codVenda: String = " ", notaFiscal: String = " ",  endereco: String = " ",
         nomeCliente: String = " ", data: String = " ", status: String, produtos: [Produto] ) {
        
        self.codVenda = codVenda
        self.notaFiscal = notaFiscal
        self.endereco = endereco
        self.nomeCliente = nomeCliente
        self.data = data
        self.status = status
        self.produtos = produtos
    }
}
