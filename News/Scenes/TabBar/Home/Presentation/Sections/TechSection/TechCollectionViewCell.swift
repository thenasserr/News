//
//  TechCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

class TechCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsContainer: UIStackView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func setup(new: Article) {
        let imageURL = new.urlToImage ?? ""
        titleImage.load(urlString: imageURL)
        nameLabel.text = new.source.name
        descriptionLabel.text = new.description
    }
    
    private func configureUI() {
        clipsToBounds = false
        configureNewsContainerUI()
        configureLabelsUI()
    }
    
    private func configureNewsContainerUI() {
        newsContainer.backgroundColor = .nlightercolor
        newsContainer.isLayoutMarginsRelativeArrangement = true
        newsContainer.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    private func configureLabelsUI() {
        nameLabel.textColor = .black
        nameLabel.font = .h3
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = .medium
        
    }
}
