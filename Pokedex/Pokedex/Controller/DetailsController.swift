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
    var type2: String?
    var desc: String?
    var pokeMoves: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curvedBorders()
        
        self.title = dexTitle
        self.Sprite?.image = pokeImage
        self.Name?.text = pokeName
        self.Type1?.text = type1
        self.Type2?.text = type2
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
        self.Type1?.layer.cornerRadius = 10.0
        self.Type1?.layer.maskedCorners = .layerMinXMaxYCorner
        self.Type2?.layer.masksToBounds = true
        self.Type2?.layer.cornerRadius = 10.0
        self.Type2?.layer.maskedCorners = .layerMaxXMaxYCorner
        
        self.DescView?.layer.cornerRadius = 20.0
        
        self.MovesView?.layer.cornerRadius = 20.0
    }
}
