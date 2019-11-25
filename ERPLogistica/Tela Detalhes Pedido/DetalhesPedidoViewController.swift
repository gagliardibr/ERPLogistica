//
//  DetalhesPedidoViewController.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/22/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

class DetalhesPedidoViewController: UIViewController {
    
    @IBOutlet weak var nomeCliente: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var nroNota: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeCliente.text = pedidoArray[indexTelaPedido!.item].nomeCliente
        endereco.text = pedidoArray[indexTelaPedido!.item].endereco
        nroNota.text = pedidoArray[indexTelaPedido!.item].notaFiscal
        
        let nibName = UINib(nibName: "ProdutosCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ProdutosCell")
    }
    
}

extension DetalhesPedidoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pedidoArray[indexTelaPedido!.item].produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutosCell", for: indexTelaPedido!) as! ProdutosCell
        
        let pedidosArray = pedidoArray[indexTelaPedido!.item]
        
        cell.produtoNome.text = pedidosArray.produtos[indexPath.row].nomeProduto
        cell.quantidade.text = pedidosArray.produtos[indexPath.row].quantidade
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = UIColor.lightGray
        
        let labelNome = UILabel()
        labelNome.frame = CGRect.init(x: 3, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
        labelNome.text = "Nome produto"
        
        let labelQuantidade = UILabel()
           labelQuantidade.frame = CGRect.init(x: 250, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
           labelQuantidade.text = "Quantidade"
        
        headerView.addSubview(labelNome)
        headerView.addSubview(labelQuantidade)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension DetalhesPedidoViewController: UITableViewDelegate {
    
}
