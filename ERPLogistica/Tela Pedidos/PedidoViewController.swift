//
//  PedidoViewController.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/1/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit
import Firebase

class PedidoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var pedidoArray : [Pedido] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PedidosCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        
        getFromFirebase()
    }
    
    func getFromFirebase() {
        ref = Database.database().reference().child("Pedido")
        //Observa qualquer dado no firebase
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                
                for pedido in snapshot.children.allObjects as! [DataSnapshot] {
                    let pedidoObject = pedido.value as? [String: AnyObject] // Pega todos os objects
                    
                    let codEnvio = pedidoObject?["codEnvio"]
                    let codVenda = pedidoObject?["codVenda"]
                    let dataEnvio = pedidoObject?["dataEnvio"]
                    let endereco = pedidoObject?["endereco"]
                    let nomeCliente = pedidoObject?["nomeCliente"]
                    let notaFiscal = pedidoObject?["notaFiscal"]
                    let produtos = pedidoObject?["produtos"] as! [String]
                    let quantidade = pedidoObject
//                    let shwo = quantidade.
                    
                    
                    let statusPedido = pedidoObject?["statusPedido"]
              
                    
                    print(produtos)
                  //  let pedidos = Pedido(codVenda: codVenda as! String, notaFiscal: notaFiscal as! String, codEnvio: codEnvio as! String, dataEnvio: Date(milliseconds: 0), statusPedido: statusPedido as! String, nomeCliente: nomeCliente as! String, endereco: endereco as! String, produto: [Produto(nome: produto as! String, quantidade: quantidade as! String)])
                    
                  //  self.pedidoArray.append(pedidos)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        
    }
}

extension PedidoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PedidosCell
        
        let showPedidos: Pedido
        showPedidos = pedidoArray[indexPath.row]
        
        cell.nomeCliente.text = showPedidos.nomeCliente
        cell.codVenda.text = showPedidos.codVenda
        //cell.qtdeProd?.text = showPedidos.produto![indexPath.row]
        cell.data?.text = showPedidos.dataEnvio as! String
        cell.status?.text = showPedidos.statusPedido
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetalhesPedidoViewController") as! DetalhesPedidoViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
}

extension PedidoViewController: UITableViewDelegate {
    
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
