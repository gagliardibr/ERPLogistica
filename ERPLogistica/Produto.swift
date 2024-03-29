//
//  Produto.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 04/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

struct Produto {
    
    let nomeProduto: String
    let quantidade: String
    
    init(nomeProduto: String = " ",
            quantidade: String = " ") {
           
        self.nomeProduto = nomeProduto
        self.quantidade = quantidade
       }
}
