//
//  TableViewCell.swift
//  OnlineStore
//
//  Created by Артур Фомин on 31.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
