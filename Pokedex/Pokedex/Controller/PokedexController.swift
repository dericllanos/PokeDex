//
//  PokedexController.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 08/05/2022.
//

import UIKit

class PokedexController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var pokemonSearch: UISearchBar?
    
    var pokemonArray: [BasicData] = []
    //var searchArray = [BasicData]()
    var nextPage = 30
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.fetchPage()
        //searchArray = pokemonArray
        //pokemonSearch?.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - SearchBar
    
//    @objc
//    private func showSearchBar() {
//        self.pokemonSearch?.isHidden = !(self.pokemonSearch?.isHidden ?? false)
//    }
//
//    func filter(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchArray = []
//
//        if (searchText == "") {
//            searchArray = pokemonArray
//        }
//        else {
//            for pokemon in pokemonArray {
//                if pokemon.name.lowercased().contains(searchText.lowercased()) {
//                    searchArray.append(pokemon)
//                }
//            }
//        }
//        self.tableView?.reloadData()
//    }
    
    private func setupUI() {
        self.title = "Pokédex"
        self.navigationController?.navigationBar.barTintColor = .systemOrange
        self.view.backgroundColor = .systemOrange
        
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")
        tableView?.delegate = self
        tableView?.dataSource = self
        
//        let leftNavItem = UIBarButtonItem(customView: pokemonSearch ?? UISearchBar())
//        self.navigationItem.leftBarButtonItem = leftNavItem
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
//        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func fetchPage() {
        self.networkManager.fetchData(page: self.nextPage) { [weak self] result in
            switch result {
            case .success(let page):
                self?.pokemonArray.append(contentsOf: page.results)
                self?.nextPage += 30
                DispatchQueue.main.async {
                    self?.tableView?.reloadData()
                }
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
                self?.presentErrorAlert(title: "NetworkError", message: err.localizedDescription)
            }
        }
    }
}

extension PokedexController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> () {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsController else { return }
        vc.self.dexTitle = ""
        
        let row = String(indexPath.row + 1)
        let rowCount = String(indexPath.row).count
        
        if rowCount < 2, row != "10" {
            vc.self.dexTitle? = "#00" + row
        }
        else if rowCount < 3, row != "100" {
            vc.self.dexTitle? = "#0" + row
        }
        else {
            vc.self.dexTitle? = "#" + row
        }
        vc.self.pokeName = "MissingNo"
        
        vc.self.desc = "rough-skin / blaze"
        vc.self.pokeMoves = "tackle, sand-attack, leer, scratch"
        
        vc.setValues(pokemon: self.pokemonArray[indexPath.row], spritePath: row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokedexController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        cell.Sprite?.layer.cornerRadius = 20.0
        cell.Type1?.layer.masksToBounds = true
        cell.Type1?.layer.cornerRadius = 10.0
        cell.Type2?.layer.masksToBounds = true
        cell.Type2?.layer.cornerRadius = 10.0
            
        cell.ID?.font = UIFont.boldSystemFont(ofSize: 25)
            
        let row = String(indexPath.row + 1)
        let rowCount = String(indexPath.row).count
            
        if rowCount < 2, row != "10" {
            cell.ID?.text = "#00" + row
        }
        else if rowCount < 3, row != "100" {
            cell.ID?.text = "#0" + row
        }
        else {
            cell.ID?.text = "#" + row
        }
            
        cell.Sprite?.backgroundColor = .lightGray
        if cell.networkManager == nil {
            cell.networkManager = self.networkManager
        }
            
        cell.configure(index: indexPath.row, pokemon: self.pokemonArray[indexPath.row], spritePath: row)
        return cell
    }
}

extension PokedexController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.pokemonArray.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
        self.fetchPage()
    }
}
