//
//  ProdutosCell.swift
//  ERPLogistica
//
//  Created by Giovane Barreira on 11/11/19.
//  Copyright © 2019 Bruna Gagliardi. All rights reserved.
//

import UIKit

class ProdutosCell: UITableViewCell {

    @IBOutlet weak var produtoNome: UILabel!
    @IBOutlet weak var quantidade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
