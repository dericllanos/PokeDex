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
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsController else { return }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PokedexController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath)
        if let cell = cell as? PokemonTableViewCell {
            if String(indexPath.row).count < 2 {
//                cell.myLabel?.text = " 0" + String(indexPath.row)
            }
            else {
//                cell.myLabel?.text = " " + String(indexPath.row)
            }
            
//            cell.myLabel?.font = .boldSystemFont(ofSize: fontSize)
            cell.Sprite?.backgroundColor = .gray
            return cell
        }
        return cell
    }
}

