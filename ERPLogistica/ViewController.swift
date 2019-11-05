//
//  ViewController.swift
//  ERPLogistica
//
//  Created by Bruna Gagliardi on 01/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var btnProximo: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    
    @IBOutlet weak var lblPedido: UITextField!
    @IBOutlet weak var lblNotaFiscal: UITextField!
    @IBOutlet weak var lblNomeCliente: UITextField!
    @IBOutlet weak var lblEndereço: UITextField!
    var statusPedido: String = "Em Separação"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func btnProximo(_ sender: Any) {
        
        var ref: DatabaseReference
        ref = Database.database().reference()
        
        
        
        
//        ref.child("Pedido").child(lblPedido.text ?? " ").setValue(["numeroPedido": lblPedido.text ?? " ", "notaFiscal": lblNotaFiscal.text ?? " ", "nomeCliente": lblNomeCliente.text ?? " ", "endereco": lblEndereço.text ?? " "])
        
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "cadastroProduto") as! CadastraProdutoViewController
        self.navigationController!.present(secondViewController, animated: true, completion: nil)
    }
    
}

