//
//  MateriaTableViewCell.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 28/02/23.
//

import UIKit
import SwipeCellKit

class MateriaTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var materiaLbl: UILabel!
    @IBOutlet weak var precioLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
