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
}
