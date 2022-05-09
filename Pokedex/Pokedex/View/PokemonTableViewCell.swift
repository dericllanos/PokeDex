//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var Sprite: UIImageView?
    @IBOutlet weak var ID: UILabel?
    @IBOutlet weak var Name: UILabel?
    @IBOutlet weak var Type1: UILabel?
    @IBOutlet weak var Type2: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        Sprite?.image = UIImage(named: "missingno")
        Name?.text = "MissingNo"
        Type1?.text = "Flying"
        Type1?.backgroundColor = UIColor.flying()
        Type2?.text = "Normal"
        Type2?.backgroundColor = UIColor.normal()
    }
    
}
