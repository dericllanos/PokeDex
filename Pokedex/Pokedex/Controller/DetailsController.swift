//
//  DetailsController.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var MovesView: UIView?
    @IBOutlet weak var DescView: UIView?
    @IBOutlet weak var NameView: UIView?
    @IBOutlet weak var TypeView: UIView?
    @IBOutlet weak var ImageView: UIView?
    
    @IBOutlet weak var Sprite: UIImageView?
    @IBOutlet weak var Name: UILabel?
    @IBOutlet weak var Type1: UILabel?
    @IBOutlet weak var Type2: UILabel?
    @IBOutlet weak var Description: UILabel?
    @IBOutlet weak var Moves: UILabel?
    
    var dexTitle: String?
    var pokeImage: UIImage?
    var pokeName: String?
    var type1: String?
    var color1: UIColor?
    var type2: String?
    var color2: UIColor?
    var desc: String?
    var pokeMoves: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        self.curvedBorders()
        self.itemValues()
    }
    
    private func itemValues() {
        self.title = dexTitle
        self.Sprite?.image = pokeImage
        self.Name?.text = pokeName
        self.Type1?.text = type1
        self.Type1?.backgroundColor = color1
        self.Type2?.text = type2
        self.Type2?.backgroundColor = color2
        self.Description?.text = desc
        self.Moves?.text = pokeMoves
    }
    
    private func curvedBorders() {
        self.ImageView?.layer.cornerRadius = 20.0
        self.Sprite?.layer.cornerRadius = 20.0
        
        self.NameView?.layer.cornerRadius = 20.0
        self.NameView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.TypeView?.layer.cornerRadius = 20.0
        self.TypeView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.Type1?.layer.masksToBounds = true
        self.Type1?.layer.borderWidth = 3.0
        self.Type1?.layer.borderColor = UIColor.white.cgColor
        self.Type1?.layer.cornerRadius = 10.0
        self.Type1?.layer.maskedCorners = .layerMinXMaxYCorner
        
        self.Type2?.layer.masksToBounds = true
        self.Type2?.layer.borderWidth = 3.0
        self.Type2?.layer.borderColor = UIColor.white.cgColor
        self.Type2?.layer.cornerRadius = 10.0
        self.Type2?.layer.maskedCorners = .layerMaxXMaxYCorner
        
        self.DescView?.layer.cornerRadius = 20.0
        
        self.MovesView?.layer.cornerRadius = 20.0
    }
}
