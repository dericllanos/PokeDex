//
//  PokedexController.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class PokedexController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokédex"
        self.view.backgroundColor = .red
        
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PokedexController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsController else { return }
        
        vc.self.dexTitle = ""
        let rowCount = String(indexPath.row).count
        
        if rowCount < 2 {
            vc.self.dexTitle? = "#00" + String(indexPath.row + 1)
        }
        else if rowCount < 3 {
            vc.self.dexTitle? = "#0" + String(indexPath.row + 1)
        }
        else {
            vc.self.dexTitle? = "#" + String(indexPath.row + 1)
        }
        vc.self.pokeImage = UIImage(named: "missingno")
        vc.self.pokeName = "MissingNo"
        vc.self.type1 = "???"
        vc.self.type2 = "???"
        vc.self.desc = "MissingNo.'s Red and Blue normal form is a dual-type Bird/Normal glitch Pokémon. It has a sprite that is a strange block of glitched pixels in a backward-L shape. Due to the larger number of characters that can be used to make it appear, it is the most common form. Normal form is exclusive to Pokémon Red and Blue."
        vc.self.pokeMoves = "tackle, sand-attack, leer, scratch"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokedexController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 151
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath)
        if let cell = cell as? PokemonTableViewCell {
            
            cell.Sprite?.layer.cornerRadius = 20.0
            cell.Type1?.layer.masksToBounds = true
            cell.Type1?.layer.cornerRadius = 10.0
            cell.Type2?.layer.masksToBounds = true
            cell.Type2?.layer.cornerRadius = 10.0
            
            let rowCount = String(indexPath.row).count
            if rowCount < 2 {
                cell.ID?.text = "#00" + String(indexPath.row + 1)
            }
            else if rowCount < 3 {
                cell.ID?.text = "#0" + String(indexPath.row + 1)
            }
            else {
                cell.ID?.text = "#" + String(indexPath.row + 1)
            }
            
            cell.Sprite?.backgroundColor = .gray
            return cell
        }
        return cell
    }
}

