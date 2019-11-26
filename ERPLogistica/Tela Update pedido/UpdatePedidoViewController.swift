//
//  UpdatePedidoViewController.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/25/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit
import Firebase
import MessageUI


var statusSelecionado: String = " "

class UpdatePedidoViewController: UIViewController {
    
    @IBOutlet weak var nomeCliente: UILabel!
    @IBOutlet weak var nroNota: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var ref: DatabaseReference!
    
    @IBOutlet weak var salvar: UIButton!
    @IBOutlet weak var email: UIButton!
    
    var pickerData: [String] = [" ", "Enviado", "Em Separação", "Aguardando Envio", "Cancelado"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salvar.layer.cornerRadius = 10
        email.layer.cornerRadius = 10
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        nomeCliente.text = pedidoArray[indexTelaPedido!.item].nomeCliente
        endereco.text = pedidoArray[indexTelaPedido!.item].endereco
        nroNota.text = pedidoArray[indexTelaPedido!.item].notaFiscal
        status.text = pedidoArray[indexTelaPedido!.item].status
        
    }
    @IBAction func emailBtnTapped(_ sender: Any) {
      sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            
            let index = (indexTelaPedido?.item)!
            let pedidoAtual = pedidoArray[index]
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setPreferredSendingEmailAddress("logistica.erpp@gmail.com")
            mail.setSubject("Solicitação de Envio de Pedido")
            mail.setToRecipients(["giovane_barreira@hotmail.com"])
            
            
            var arrayString : [String] = []
            for (_, value) in pedidoAtual.produtos.enumerated() {
              
                let strings = "\nNome: \(value.nomeProduto) \nQuantidade: \(value.quantidade)"
                arrayString.append(strings)
            }
            
            let array = arrayString
            let separator = array.joined(separator:"\n")
            let space = "--------------------------------------------"
            let messageBody = "Nome: \(pedidoAtual.nomeCliente)\nCódVenda: \(pedidoAtual.codVenda)\nData do Pedido: \(pedidoAtual.data) \nEndereco: \(pedidoAtual.endereco)\nNota Fiscal: \(pedidoAtual.notaFiscal) \nProdutos:\n\(separator) \n\(space)"
                      
            mail.setMessageBody(messageBody, isHTML: false)
            
            present(mail, animated: true)
            
        } else {
            fatalError("erro")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        let index = (indexTelaPedido?.item)!
        let path = pedidoArray[index].codVenda
        ref = Database.database().reference().child("Pedido")
        ref.child(path).updateChildValues(["statusPedido": statusSelecionado])
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}


extension UpdatePedidoViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusSelecionado = pickerData[row]
    }
}

extension UpdatePedidoViewController: UIPickerViewDelegate {
    
}


extension UpdatePedidoViewController: MFMailComposeViewControllerDelegate {
        
}

