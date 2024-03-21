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
        titleImage.layer.cornerRadius = 10
        configureLabelsUI()
    }
    
    private func configureLabelsUI() {
        nameLabel.textColor = .nprimarycolor
        nameLabel.font = .h3
        
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .regular
        
    }
}
