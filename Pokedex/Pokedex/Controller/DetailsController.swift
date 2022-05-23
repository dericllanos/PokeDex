//
//  DetailsController.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView?
    @IBOutlet weak var MovesView: UIView?
    @IBOutlet weak var NameView: UIView?
    @IBOutlet weak var TypeView: UIView?
    @IBOutlet weak var ImageView: UIView?
    @IBOutlet weak var Shiny: UIImageView?
    @IBOutlet weak var ImageSwitch: UISwitch?
    
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
    var ability1: String = ""
    var ability2: String = ""
    var pokeMoves: String?
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemOrange
        self.Shiny?.isHidden = true
        self.Sprite?.isHidden = false
        
        self.curvedBorders()
        self.itemValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    @IBAction func spriteSwitch(_ sender: Any) {
        self.Shiny?.isHidden = !(self.Shiny?.isHidden ?? false)
    }
    
    private func itemValues() {
        self.title = dexTitle

        self.Name?.text = pokeName
        self.Name?.font = UIFont.boldSystemFont(ofSize: 25)
        
        self.Type1?.text = type1?.capitalized
        self.Type1?.font = UIFont.systemFont(ofSize: 20)
        self.Type2?.text = type2?.capitalized
        self.Type2?.font = UIFont.systemFont(ofSize: 20)
        typeColour()
        
        var slash = "/"
        
        if ability2 == "N/A" {
            ability2 = ""
            slash = ""
        }
        self.Description?.text = ("\(ability1.capitalized) \(slash) \(ability2.capitalized)")
        self.Description?.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.Moves?.text = pokeMoves?.capitalized
    }
    
    private func curvedBorders() {
        self.ImageView?.layer.cornerRadius = 20.0
        self.Sprite?.layer.cornerRadius = 20.0
        self.Shiny?.layer.cornerRadius = 20.0
        
        self.NameView?.layer.cornerRadius = 20.0
        self.NameView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.TypeView?.layer.cornerRadius = 20.0
        self.TypeView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.Type1?.layer.masksToBounds = true
        self.Type1?.layer.borderColor = UIColor.white.cgColor
        self.Type1?.layer.cornerRadius = 20.0
        self.Type1?.layer.maskedCorners = .layerMinXMaxYCorner
        
        self.Type2?.layer.masksToBounds = true
        self.Type2?.layer.borderColor = UIColor.white.cgColor
        self.Type2?.layer.cornerRadius = 20.0
        self.Type2?.layer.maskedCorners = .layerMaxXMaxYCorner
        
        self.MovesView?.layer.cornerRadius = 20.0
        self.MovesView?.layer.borderWidth = 5.0
    }
    
    func setValues(pokemon: BasicData, spritePath: String) {
        let url = pokemon.url
        let popList = fetchDetails(url: url)
        
        self.pokeName = pokemon.name.capitalized
        
        guard var pokeType = popList?.types.map({ $0.type.name }) else { return }
        if pokeType.count <= 2 {
            pokeType.append("N/A")
        }
        type1 = pokeType[0]
        type2 = pokeType[1]
        
        guard var pokeAbilities = popList?.abilities.map({$0.ability.name}) else { return }
        if pokeAbilities.count <= 2 {
            pokeAbilities.append("N/A")
        }
        ability1 = pokeAbilities[0]
        ability2 = pokeAbilities[1]
        
        guard let moves = popList?.moves.map({$0.move.name}) else { return }
        for _ in moves {
            pokeMoves = "Moves: \n \(moves.joined(separator: ", "))"
        }
        
        NetworkManager.shared.fetchSprites(spritePath: spritePath, completion: { [weak self] result in
            switch result {
            case .success(let imageData):

                ImageCache.sharedCache.setImageData(key: popList?.sprites.frontDefault ?? "", data: imageData)

                DispatchQueue.main.async {
                    self?.Sprite?.image = UIImage(data: imageData)
                }
            case .failure(let err):
                print(err)
            }
        })
        
        // Make Lazy
        NetworkManager.shared.fetchShiny(spritePath: spritePath, completion: { [weak self] result in
            switch result {
            case .success(let imageData):

                ImageCache.sharedCache.setImageData(key: popList?.sprites.frontShiny ?? "", data: imageData)

                DispatchQueue.main.async {
                    self?.Shiny?.image = UIImage(data: imageData)
                }
            case .failure(let err):
                print(err)
            }
        })
    }
    
    func typeColour() {
        if type2 == "N/A" {
            self.Type2?.backgroundColor = UIColor.lightGray
            self.Type2?.isEnabled = false
        }
        // Type 1
        if type1 == "fire" {
            self.Type1?.backgroundColor = UIColor.fire()
            self.ImageView?.layer.backgroundColor = UIColor.fire().cgColor
            self.MovesView?.layer.borderColor = UIColor.fire().cgColor
        }
        else if type1 == "water" {
            self.Type1?.backgroundColor = UIColor.water()
            self.ImageView?.layer.backgroundColor = UIColor.water().cgColor
            self.MovesView?.layer.borderColor = UIColor.water().cgColor
        }
        else if type1 == "grass" {
            self.Type1?.backgroundColor = UIColor.grass()
            self.ImageView?.layer.backgroundColor = UIColor.grass().cgColor
            self.MovesView?.layer.borderColor = UIColor.grass().cgColor
        }
        else if type1 == "fairy" {
            self.Type1?.backgroundColor = UIColor.fairy()
            self.ImageView?.layer.backgroundColor = UIColor.fairy().cgColor
            self.MovesView?.layer.borderColor = UIColor.fairy().cgColor
        }
        else if type1 == "steel" {
            self.Type1?.backgroundColor = UIColor.steel()
            self.ImageView?.layer.backgroundColor = UIColor.steel().cgColor
            self.MovesView?.layer.borderColor = UIColor.steel().cgColor
        }
        else if type1 == "psychic" {
            self.Type1?.backgroundColor = UIColor.psychic()
            self.ImageView?.layer.backgroundColor = UIColor.psychic().cgColor
            self.MovesView?.layer.borderColor = UIColor.psychic().cgColor
        }
        else if type1 == "ghost" {
            self.Type1?.backgroundColor = UIColor.ghost()
            self.ImageView?.layer.backgroundColor = UIColor.ghost().cgColor
            self.MovesView?.layer.borderColor = UIColor.ghost().cgColor
        }
        else if type1 == "poison" {
            self.Type1?.backgroundColor = UIColor.poison()
            self.ImageView?.layer.backgroundColor = UIColor.poison().cgColor
            self.MovesView?.layer.borderColor = UIColor.poison().cgColor
        }
        else if type1 == "bug" {
            self.Type1?.backgroundColor = UIColor.bug()
            self.ImageView?.layer.backgroundColor = UIColor.bug().cgColor
            self.MovesView?.layer.borderColor = UIColor.bug().cgColor
        }
        else if type1 == "normal" {
            self.Type1?.backgroundColor = UIColor.normal()
            self.ImageView?.layer.backgroundColor = UIColor.normal().cgColor
            self.MovesView?.layer.borderColor = UIColor.normal().cgColor
        }
        else if type1 == "flying" {
            self.Type1?.backgroundColor = UIColor.flying()
            self.ImageView?.layer.backgroundColor = UIColor.flying().cgColor
            self.MovesView?.layer.borderColor = UIColor.flying().cgColor
        }
        else if type1 == "fighting" {
            self.Type1?.backgroundColor = UIColor.fighting()
            self.ImageView?.layer.backgroundColor = UIColor.fighting().cgColor
            self.MovesView?.layer.borderColor = UIColor.fighting().cgColor
        }
        else if type1 == "rock" {
            self.Type1?.backgroundColor = UIColor.rock()
            self.ImageView?.layer.backgroundColor = UIColor.rock().cgColor
            self.MovesView?.layer.borderColor = UIColor.rock().cgColor
        }
        else if type1 == "ground" {
            self.Type1?.backgroundColor = UIColor.ground()
            self.ImageView?.layer.backgroundColor = UIColor.ground().cgColor
            self.MovesView?.layer.borderColor = UIColor.ground().cgColor
        }
        else if type1 == "dragon" {
            self.Type1?.backgroundColor = UIColor.dragon()
            self.ImageView?.layer.backgroundColor = UIColor.dragon().cgColor
            self.MovesView?.layer.borderColor = UIColor.dragon().cgColor
        }
        else if type1 == "electric" {
            self.Type1?.backgroundColor = UIColor.electric()
            self.ImageView?.layer.backgroundColor = UIColor.electric().cgColor
            self.MovesView?.layer.borderColor = UIColor.electric().cgColor
        }
        else if type1 == "ice" {
            self.Type1?.backgroundColor = UIColor.ice()
            self.ImageView?.layer.backgroundColor = UIColor.ice().cgColor
            self.MovesView?.layer.borderColor = UIColor.ice().cgColor
        }
        // Type 2
        if type2 == "fire" {
            self.Type2?.backgroundColor = UIColor.fire()
        }
        else if type2 == "water" {
            self.Type2?.backgroundColor = UIColor.water()
        }
        else if type2 == "grass" {
            self.Type2?.backgroundColor = UIColor.grass()
        }
        if type2 == "fairy" {
            self.Type2?.backgroundColor = UIColor.fairy()
        }
        if type2 == "steel" {
            self.Type2?.backgroundColor = UIColor.steel()
        }
        else if type2 == "psychic" {
            self.Type2?.backgroundColor = UIColor.psychic()
        }
        else if type2 == "ghost" {
            self.Type2?.backgroundColor = UIColor.ghost()
        }
        else if type2 == "poison" {
            self.Type2?.backgroundColor = UIColor.poison()
        }
        else if type2 == "bug" {
            self.Type2?.backgroundColor = UIColor.bug()
        }
        else if type2 == "normal" {
            self.Type2?.backgroundColor = UIColor.normal()
        }
        else if type2 == "flying" {
            self.Type2?.backgroundColor = UIColor.flying()
        }
        else if type2 == "fighting" {
            self.Type2?.backgroundColor = UIColor.fighting()
        }
        else if type2 == "rock" {
            self.Type2?.backgroundColor = UIColor.rock()
        }
        else if type2 == "ground" {
            self.Type2?.backgroundColor = UIColor.ground()
        }
        else if type2 == "dragon" {
            self.Type2?.backgroundColor = UIColor.dragon()
        }
        else if type2 == "electric" {
            self.Type2?.backgroundColor = UIColor.electric()
        }
        else if type2 == "ice" {
            self.Type2?.backgroundColor = UIColor.ice()
        }
    }
}
