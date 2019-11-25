//
//  PedidoViewController.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/1/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

var indexTelaPedido: IndexPath?
var pedidoArray : [Pedido] = []

class PedidoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let mail = MFMailComposeViewController()
    
    var ref: DatabaseReference!
    var arrayDosProdutos: [Produto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PedidosCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pedidoArray.removeAll()
        getFromFirebase()
    }
    
    
    @IBAction func geraRelatorioTapped(_ sender: Any) {
        sendEmail()
        
    }
    
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            
          
            for (index, _) in pedidoArray.enumerated() {
            
            let pedidoAtual = pedidoArray[index]
                
                print (index)
          
            mail.mailComposeDelegate = self
            mail.setPreferredSendingEmailAddress("logistica.erpp@gmail.com")
            mail.setSubject("Relatório de Pedidos")
            mail.setToRecipients(["giovane_barreira@hotmail.com"])
            
            
            var arrayStringPedido : [String] = []
            let arrayPedido = arrayStringPedido
            let separator = arrayPedido.joined(separator:"\n")
            let space = "--------------------------------------------"
            
            for (_, pedidos) in pedidoArray.enumerated() {
                
                let strings = "Nome: \(pedidoAtual.nomeCliente)\nCódVenda: \(pedidoAtual.codVenda)\nData do Pedido: \(pedidoAtual.data) \nEndereco: \(pedidoAtual.endereco)\nNota Fiscal: \(pedidoAtual.notaFiscal) \nProdutos:\n\(separator) \n\(space)"
                
                arrayStringPedido.append(strings)
            }
            
            
            var arrayString : [String] = []
            for (_, value) in pedidoAtual.produtos.enumerated() {
                
                let strings = "\nNome: \(value.nomeProduto) \nQuantidade: \(value.quantidade)"
                arrayString.append(strings)
            }
            
            let array = arrayString
            let separator2 = array.joined(separator:"\n")
    
            let messageBody = "Nome: \(pedidoAtual.nomeCliente)\nCódVenda: \(pedidoAtual.codVenda)\nData do Pedido: \(pedidoAtual.data) \nEndereco: \(pedidoAtual.endereco)\nNota Fiscal: \(pedidoAtual.notaFiscal) \nProdutos:\n\(separator2) \n\(space)"
                
                
            var arrayMsg: [String] = []
            arrayMsg.append(messageBody)
                
            let separadorMsg = arrayMsg.joined(separator: "\n")
                
            mail.setMessageBody(separadorMsg, isHTML: false)
            present(mail, animated: true)
                
            }
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    func getFromFirebase() {
        ref = Database.database().reference().child("Pedido")
        //Observa qualquer dado no firebase
        ref.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                
                for pedido in snapshot.children.allObjects as! [DataSnapshot] {
                    let pedidoObject = pedido.value as? [String: AnyObject] // Pega todos os objects
                    //Pedidos
                    let codVenda = pedidoObject?["codVenda"] as! String
                    let dataPedido = pedidoObject?["dataPedido"] as! String
                    let endereco = pedidoObject?["endereco"] as! String
                    let nomeCliente = pedidoObject?["nomeCliente"] as! String
                    let notaFiscal = pedidoObject?["notaFiscal"] as! String
                    let statusPedido = pedidoObject?["statusPedido"] as! String
                    
                    var nomeProduto: String = ""
                    var quantidade: Int = 0
                    
                    
                    //Pegar objetos produtos separadamente
                    if let snap = pedido.childSnapshot(forPath: "produtos").children.allObjects as? [DataSnapshot]{
                        
                        for (_,val) in snap.enumerated(){
                            
                            nomeProduto = val.childSnapshot(forPath: "nome").value as! String
                            quantidade = Int(val.childSnapshot(forPath: "quantidade").value as! String)!
                            
                            self.arrayDosProdutos.append(Produto(nomeProduto: nomeProduto, quantidade: "\(quantidade)"))
                            
                        }
                    }
                    
                    let pedidos = Pedido(codVenda: codVenda, notaFiscal: notaFiscal, endereco: endereco, nomeCliente: nomeCliente, data: dataPedido, status: statusPedido, produtos: self.arrayDosProdutos)
                    
                    pedidoArray.append(pedidos)
                    self.arrayDosProdutos.removeAll()
                }
                
            }
            self.tableView.reloadData()
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
        cell.data?.text = showPedidos.data
        cell.status?.text = showPedidos.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetalhesPedidoViewController") as! DetalhesPedidoViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
        
        indexTelaPedido = indexPath
    }
    
}

extension PedidoViewController: UITableViewDelegate {
    
}


extension PedidoViewController: UIPickerViewDelegate {
    
}


extension PedidoViewController: MFMailComposeViewControllerDelegate {
    
}
