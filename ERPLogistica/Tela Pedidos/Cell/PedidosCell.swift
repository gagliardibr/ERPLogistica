//
//  PedidosCell.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/4/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

class PedidosCell: UITableViewCell {
    
    @IBOutlet weak var codVenda: UILabel!
    @IBOutlet weak var data: UILabel?
    @IBOutlet weak var qtdeProd: UILabel?
    @IBOutlet weak var status: UILabel?
    @IBOutlet weak var nomeCliente: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 10
        cellView.layer.backgroundColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

