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
    
    @IBOutlet weak var codVendaTxt: UILabel!
    @IBOutlet weak var notaFiscalTxt: UILabel!
    @IBOutlet weak var nomeClienteTxt: UILabel!
    @IBOutlet weak var enderecoTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var buttom: NSLayoutConstraint!
    
    @IBOutlet weak var lblPedido: UITextField!
    @IBOutlet weak var lblNotaFiscal: UITextField!
    @IBOutlet weak var lblNomeCliente: UITextField!
    @IBOutlet weak var lblEndereco: UITextField!
    @IBOutlet weak var lblDate: UITextField!
    
    var pikerActive = false
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    lazy var datePicker: UIDatePicker = {
          let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
          
          return picker
      }()
    
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
            
           lblDate.text = dateFormatter.string(from: sender.date)
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if pikerActive {
            pikerActive = false
            top.constant += 80
            buttom.constant += 80
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
             btnProximo.layer.cornerRadius = 10
             btnCancelar.layer.cornerRadius = 10
        
        lblDate.inputView = datePicker
        setupKeyboardNotifications()
    }
    
    
    @IBAction func btnCancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        }
    
    
    @IBAction func btnProximo(_ sender: Any) {
        var ref: DatabaseReference
        ref = Database.database().reference()
        
        if lblEndereco.text!.isEmpty || lblNomeCliente.text!.isEmpty || lblNotaFiscal.text!.isEmpty || lblPedido.text!.isEmpty {
            
            showError()
            let alert = UIAlertController(title: "Error", message: "Favor preencher todos os campos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        } else {            
            let pedido = Pedido(codVenda: lblPedido.text ?? " ", notaFiscal: lblNotaFiscal.text ?? " ", endereco: lblEndereco.text ?? " ", nomeCliente: lblNomeCliente.text ?? " ", data: lblDate.text ?? " ")
                   
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "cadastroProduto") as! CadastraProdutoViewController
            secondViewController.idPedido = pedido
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func showError() {
        if lblPedido.text!.isEmpty {
            codVendaTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            codVendaTxt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        if lblNotaFiscal.text!.isEmpty {
            notaFiscalTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            notaFiscalTxt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        if lblNomeCliente.text!.isEmpty {
            nomeClienteTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            nomeClienteTxt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        if lblEndereco.text!.isEmpty {
            enderecoTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            enderecoTxt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        if lblDate.text!.isEmpty {
            dateTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            dateTxt.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
           
           guard let dataTxt = lblDate else { return }
           
           if dataTxt.isEditing {
            pikerActive = true
            top.constant -= 80
            buttom.constant -= 80
           }
       }
}

