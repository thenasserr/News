//
//  BreakingNewsCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 19/03/2024.
//

import UIKit

class BreakingNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func setup(new: Article) {
        let imageURL = new.urlToImage ?? ""
        titleImage.load(urlString: imageURL)
        name.text = new.source.name
        publishedDate.text = new.publishedAt.convertDateStringToDate()
        descriptionLabel.text = new.description
    }
    
    private func configureUI() {
        titleImage.layer.cornerRadius = 15
        clipsToBounds = false
        configureLabelsUI()
    }
    
    private func configureLabelsUI() {
        name.textColor = .nprimarycolor
        name.font = .h3
        
        publishedDate.textColor = .nprimarycolor
        publishedDate.font = .h3
        
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .regular
        
    }
}
