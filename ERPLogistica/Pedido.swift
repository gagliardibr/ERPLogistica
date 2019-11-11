//
//  Pedido.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 01/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

struct Pedido: Codable {
    
    //Pedido
    let codVenda: String?
    let notaFiscal: String?
    
    //Envio
    let codEnvio: String?
    let dataEnvio: Date?
    let statusPedido: String?
    
    //cliente
    let nomeCliente: String?
    let endereco: String?
    
    //produto
    let produto: [Produto]?
    
    init(codVenda: String, notaFiscal: String, codEnvio: String, dataEnvio: Date, statusPedido: String, nomeCliente: String, endereco: String, produto: [Produto]) {
        
        self.codVenda = codVenda
        self.notaFiscal = notaFiscal
        self.codEnvio = codEnvio
        self.dataEnvio = dataEnvio
        self.statusPedido = statusPedido
        self.nomeCliente = nomeCliente
        self.endereco = endereco
        self.produto = produto
    }
}
