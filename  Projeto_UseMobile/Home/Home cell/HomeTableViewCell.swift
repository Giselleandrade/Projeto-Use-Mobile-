//
//  HomeTableViewCell.swift
//  Projeto_UseMobile
//
//  Created by Giselle Andrade on 29/06/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var isFavorited: Bool = false
    
    
    
    private let userDefaults = UserDefaults.standard
    private var favoritesDict: [String: Any] = [:]
    private var favoritesArray: [[String: Any]] = []
    private var imageString: String?
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBAction func favoriteButton(_ sender: Any){
        if isFavorited {
            buttonStarNoColor()
            removeFavorites()
            
            
            
        } else {
            buttonStarColor()
            saveFavorites()
        }
    }
    
    
    private func buttonStarColor() {
        
        guard let imageColor: UIImage = UIImage(named: "Vector") else { return }
        
        favoriteButton.setImage(imageColor, for: .normal)
        isFavorited = true
        
    }
    
    private func buttonStarNoColor() {
        
        guard let imageNoColor: UIImage = UIImage(named: "Vector-2") else { return }
        
        favoriteButton.setImage(imageNoColor, for: .normal)
        isFavorited = false
    }
    
    private func saveFavorites() {
        
        guard let name = nameLabel.text, let description = descriptionLabel.text else { return }
        favoritesArray = userDefaults.value(forKey: "favoritesArray") as? [[String: Any]] ?? []
        favoritesDict = ["name": name, "description": description, "image": imageString]
        favoritesArray.append(favoritesDict)
        userDefaults.set(favoritesArray, forKey: "favoritesArray")
    }
    
    private func removeFavorites() {
        
        favoritesArray = userDefaults.value(forKey: "favoritesArray") as? [[String: Any]] ?? []
        
        favoritesArray.removeAll { name in
            
            return name["name"] as? String == nameLabel.text
        }
        userDefaults.set(favoritesArray, forKey: "favoritesArray")
    }
    
    
    func setupUI(items: Items) {
        
        animalImage.layer.cornerRadius = 8
        
        nameLabel.text = items.name
        descriptionLabel.text = items.description
        
        guard let url = URL(string: items.image ?? "fotoBranca") else { return }
        animalImage.loadImage(url: url)
        
        imageString = items.image
        
        if verificaFavorito(items: items){
            buttonStarColor()
        } else {
            buttonStarNoColor()
        }
        
        
    }
    
    
    
    func verificaFavorito(items: Items) -> Bool {
        
        favoritesArray = userDefaults.value(forKey: "favoritesArray") as? [[String: Any]] ?? []
        return favoritesArray.contains { name in
            return name["name"] as? String == items.name
        }
    }
    
}
