//
//  CadastraProdutoViewController.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 01/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit
import Firebase

class CadastraProdutoViewController: UIViewController {
    
    @IBOutlet weak var btnSalvar: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var idPedido: Pedido?
    var prodArray: [Produto]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSalvar.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "CadastroProdutoCell", bundle: nil), forCellReuseIdentifier: "CadastroProdutoCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduto))
    }
    
    @IBAction func addProduto() {
        
        let alert = UIAlertController(title: "Cadastro Produto", message: "Preencher os campos corretamente.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Produto"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Quantidade"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0]
            let textField2 = alert?.textFields![1]
            
            if (textField?.text!.isEmpty)! || (textField2?.text!.isEmpty)! {
                let alert = UIAlertController(title: "Produto não adicionado.", message: "Favor preencher todos os campos corretamente.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let produto = Produto(nomeProduto: textField!.text!, quantidade: textField2!.text!)
                self.prodArray?.append(produto)
                let alert = UIAlertController(title: "Produto adicionado com sucesso!", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionSalvar(_ sender: Any) {
        var ref: DatabaseReference
        ref = Database.database().reference()
        
        if prodArray!.isEmpty {
            let alert = UIAlertController(title: "Pedidos sem produtos.", message: "Favor adicionar produtos no pedido.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                       self.present(alert, animated: true, completion: nil)
        } else {
            ref.child("Pedido").child(idPedido!.codVenda).setValue(["codVenda": idPedido!.codVenda, "notaFiscal": idPedido!.notaFiscal,"endereco": idPedido!.endereco,"nomeCliente": idPedido!.nomeCliente, "statusPedido": "Em Separação", "dataPedido": idPedido!.data])
            
            for (index, pedido) in prodArray!.enumerated() {
                ref.child("Pedido").child(idPedido!.codVenda).child("produtos").child(String(index)).setValue(["nome": pedido.nomeProduto, "quantidade": pedido.quantidade])
            }
            
            self.dismiss(animated: true, completion: nil)
        }
}
    
}
extension CadastraProdutoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prodArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CadastroProdutoCell") as! CadastroPedidoTableViewCell
        
        print(prodArray![indexPath.row])
        cell.nomeProduto?.text = prodArray![indexPath.row].nomeProduto
        cell.quantidade?.text = prodArray![indexPath.row].quantidade
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            prodArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    
    
}

