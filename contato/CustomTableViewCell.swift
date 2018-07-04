//
//  CustomTableViewCell.swift
//  contato
//
//  Created by Leonardo Zanela Dias on 04/07/2018.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // Criando uma classe cutomizada de table view

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var labelImageView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //profileImageView.layer.cornerRadius = layer.bounds.height / 2
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
