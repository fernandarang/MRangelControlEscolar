//
//  AlumnoTableViewCell.swift
//  MRangelControlEscolar
//
//  Created by MacBookMBA5 on 23/02/23.
//

import UIKit
import SwipeCellKit

class AlumnoTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var IdLbl: UILabel!
    @IBOutlet weak var NombreLbl: UILabel!
    @IBOutlet weak var ApellidoLbl: UILabel!
    @IBOutlet weak var ApellidoMLbl: UILabel!
    @IBOutlet weak var FechaNacimientoLbl: UILabel!
    @IBOutlet weak var GeneroLbl: UILabel!
    @IBOutlet weak var TelefonoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
