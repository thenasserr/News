//
//  PoliticsCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

class PoliticsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func setup(new: Article) {
        let imageURL = new.urlToImage ?? ""
        titleImage.load(urlString: imageURL)
        descriptionLabel.text = new.description
        publishedDate.text = new.publishedAt.convertDateStringToDate()
    }
    
    private func configureUI() {
        clipsToBounds = false
        titleImage.layer.cornerRadius = 10
        configureLabelsUI()
    }
    
    private func configureLabelsUI() {
        descriptionLabel.textColor = .nprimarycolor
        descriptionLabel.font = .medium
        
        publishedDate.textColor = .nlightcolor
        publishedDate.font = .medium
    }
}
