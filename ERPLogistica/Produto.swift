//
//  Produto.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 04/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

struct Produto: Codable {
    
    let nome: String?
    let quantidade: String?
    
    init(nome: String, quantidade: String){
        self.nome = nome
        self.quantidade = quantidade
        
    }
}
