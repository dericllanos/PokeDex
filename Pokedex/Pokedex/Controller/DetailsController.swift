//
//  DetailsController.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var Sprite: UIImageView?
    @IBOutlet weak var Name: UILabel?
    @IBOutlet weak var Type1: UILabel?
    @IBOutlet weak var Type2: UILabel?
    @IBOutlet weak var Description: UILabel?
    
    var dexTitle: String?
    var pokeImage: UIImage?
    var pokeName: String?
    var type1: String?
    var type2: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = dexTitle ?? "Details"
        self.Sprite?.image = pokeImage ?? UIImage(named: "missingno")
        self.Name?.text = pokeName ?? "Pokemon-Name"
        self.Type1?.text = type1 ?? "Type-1"
        self.Type2?.text = type2 ?? "Type-2"
        self.Description?.text = desc ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}
