//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Pokeball: UIImageView!
    @IBOutlet weak var Sprite: UIImageView?
    @IBOutlet weak var ID: UILabel?
    @IBOutlet weak var Name: UILabel?
    @IBOutlet weak var Type1: UILabel?
    @IBOutlet weak var Type2: UILabel?
    
    var networkManager: NetworkManager?
    var type1: String?
    var type2: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(index: Int, pokemon: BasicData, spritePath: String) {
        self.reset()
        
        self.Name?.text = pokemon.name.capitalized
        self.Name?.font = UIFont.systemFont(ofSize: 25)
        
        let url = pokemon.url
        let popList = fetchDetails(url: url)
        guard var list = popList?.types.map({ $0.type.name }) else { return }
        if list.count <= 2 {
            list.append("placeholder")
        }
        type1 = list[0]
        type2 = list[1]
        self.Type1?.text = type1?.capitalized
        self.Type1?.font = UIFont.boldSystemFont(ofSize: 18)
        self.Type2?.text = type2?.capitalized
        self.Type2?.font = UIFont.boldSystemFont(ofSize: 18)
        if (list[1] == "placeholder") {
            self.Type2?.backgroundColor = .clear
            self.Type2?.text = ""
        }
        typeColour()

        if let imageData = ImageCache.sharedCache.getImageData(key: popList?.sprites.frontDefault ?? "") {
            print("Point: ImageCache Data")
            self.Sprite?.image = UIImage(data: imageData)
            return
        }
        
        print("Point: Fetching Image From Network")
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
    }
    
    private func reset() {
        self.Sprite?.image = UIImage(named: "missingno")
        self.Pokeball?.image = UIImage(named: "pokeball")
        self.Sprite?.layer.borderWidth = 5.0
        self.Sprite?.layer.backgroundColor = UIColor.white.cgColor
        self.Sprite?.layer.borderColor = UIColor.lightGray.cgColor
        self.Name?.text = "MissingNo"
        self.Type1?.text = "Flying"
        self.Type1?.backgroundColor = UIColor.flying()
        self.Type2?.text = "Normal"
        self.Type2?.backgroundColor = UIColor.normal()
    }
    
    func typeColour() {
        // Type 1
        if type1 == "fire" {
            self.Type1?.backgroundColor = UIColor.fire()
            self.Sprite?.layer.borderColor = UIColor.fire().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.fire().cgColor
            }
        }
        else if type1 == "water" {
            self.Type1?.backgroundColor = UIColor.water()
            self.Sprite?.layer.borderColor = UIColor.water().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.water().cgColor
            }
        }
        else if type1 == "grass" {
            self.Type1?.backgroundColor = UIColor.grass()
            self.Sprite?.layer.borderColor = UIColor.grass().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.grass().cgColor
            }
        }
        else if type1 == "fairy" {
            self.Type1?.backgroundColor = UIColor.fairy()
            self.Sprite?.layer.borderColor = UIColor.fairy().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.fairy().cgColor
            }
        }
        else if type1 == "steel" {
            self.Type1?.backgroundColor = UIColor.steel()
            self.Sprite?.layer.borderColor = UIColor.steel().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.steel().cgColor
            }
        }
        else if type1 == "psychic" {
            self.Type1?.backgroundColor = UIColor.psychic()
            self.Sprite?.layer.borderColor = UIColor.psychic().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.psychic().cgColor
            }
        }
        else if type1 == "ghost" {
            self.Type1?.backgroundColor = UIColor.ghost()
            self.Sprite?.layer.borderColor = UIColor.ghost().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.ghost().cgColor
            }
        }
        else if type1 == "poison" {
            self.Type1?.backgroundColor = UIColor.poison()
            self.Sprite?.layer.borderColor = UIColor.poison().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.poison().cgColor
            }
        }
        else if type1 == "bug" {
            self.Type1?.backgroundColor = UIColor.bug()
            self.Sprite?.layer.borderColor = UIColor.bug().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.bug().cgColor
            }
        }
        else if type1 == "normal" {
            self.Type1?.backgroundColor = UIColor.normal()
            self.Sprite?.layer.borderColor = UIColor.normal().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.normal().cgColor
            }
        }
        else if type1 == "flying" {
            self.Type1?.backgroundColor = UIColor.flying()
            self.Sprite?.layer.borderColor = UIColor.flying().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.flying().cgColor
            }
        }
        else if type1 == "fighting" {
            self.Type1?.backgroundColor = UIColor.fighting()
            self.Sprite?.layer.borderColor = UIColor.fighting().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.fighting().cgColor
            }
        }
        else if type1 == "rock" {
            self.Type1?.backgroundColor = UIColor.rock()
            self.Sprite?.layer.borderColor = UIColor.rock().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.rock().cgColor
            }
        }
        else if type1 == "ground" {
            self.Type1?.backgroundColor = UIColor.ground()
            self.Sprite?.layer.borderColor = UIColor.ground().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.ground().cgColor
            }
        }
        else if type1 == "dragon" {
            self.Type1?.backgroundColor = UIColor.dragon()
            self.Sprite?.layer.borderColor = UIColor.dragon().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.dragon().cgColor
            }
        }
        else if type1 == "electric" {
            self.Type1?.backgroundColor = UIColor.electric()
            self.Sprite?.layer.borderColor = UIColor.electric().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.electric().cgColor
            }
        }
        else if type1 == "ice" {
            self.Type1?.backgroundColor = UIColor.ice()
            self.Sprite?.layer.borderColor = UIColor.ice().cgColor
            if type2 == "placeholder" {
                self.Sprite?.layer.backgroundColor = UIColor.ice().cgColor
            }
        }
        // Type 2
        if type2 == "fire" {
            self.Type2?.backgroundColor = UIColor.fire()
            self.Sprite?.layer.backgroundColor = UIColor.fire().cgColor
        }
        else if type2 == "water" {
            self.Type2?.backgroundColor = UIColor.water()
            self.Sprite?.layer.backgroundColor = UIColor.water().cgColor
        }
        else if type2 == "grass" {
            self.Type2?.backgroundColor = UIColor.grass()
            self.Sprite?.layer.backgroundColor = UIColor.grass().cgColor
        }
        if type2 == "fairy" {
            self.Type2?.backgroundColor = UIColor.fairy()
            self.Sprite?.layer.backgroundColor = UIColor.fairy().cgColor
        }
        if type2 == "steel" {
            self.Type2?.backgroundColor = UIColor.steel()
            self.Sprite?.layer.backgroundColor = UIColor.steel().cgColor
        }
        else if type2 == "psychic" {
            self.Type2?.backgroundColor = UIColor.psychic()
            self.Sprite?.layer.backgroundColor = UIColor.psychic().cgColor
        }
        else if type2 == "ghost" {
            self.Type2?.backgroundColor = UIColor.ghost()
            self.Sprite?.layer.backgroundColor = UIColor.ghost().cgColor
        }
        else if type2 == "poison" {
            self.Type2?.backgroundColor = UIColor.poison()
            self.Sprite?.layer.backgroundColor = UIColor.poison().cgColor
        }
        else if type2 == "bug" {
            self.Type2?.backgroundColor = UIColor.bug()
            self.Sprite?.layer.backgroundColor = UIColor.bug().cgColor
        }
        else if type2 == "normal" {
            self.Type2?.backgroundColor = UIColor.normal()
            self.Sprite?.layer.backgroundColor = UIColor.normal().cgColor
        }
        else if type2 == "flying" {
            self.Type2?.backgroundColor = UIColor.flying()
            self.Sprite?.layer.backgroundColor = UIColor.flying().cgColor
        }
        else if type2 == "fighting" {
            self.Type2?.backgroundColor = UIColor.fighting()
            self.Sprite?.layer.backgroundColor = UIColor.fighting().cgColor
        }
        else if type2 == "rock" {
            self.Type2?.backgroundColor = UIColor.rock()
            self.Sprite?.layer.backgroundColor = UIColor.rock().cgColor
        }
        else if type2 == "ground" {
            self.Type2?.backgroundColor = UIColor.ground()
            self.Sprite?.layer.backgroundColor = UIColor.ground().cgColor
        }
        else if type2 == "dragon" {
            self.Type2?.backgroundColor = UIColor.dragon()
            self.Sprite?.layer.backgroundColor = UIColor.dragon().cgColor
        }
        else if type2 == "electric" {
            self.Type2?.backgroundColor = UIColor.electric()
            self.Sprite?.layer.backgroundColor = UIColor.electric().cgColor
        }
        else if type2 == "ice" {
            self.Type2?.backgroundColor = UIColor.ice()
            self.Sprite?.layer.backgroundColor = UIColor.ice().cgColor
        }
    }
}
