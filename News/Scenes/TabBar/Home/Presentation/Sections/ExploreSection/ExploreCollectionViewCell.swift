//
//  ExploreCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var exploreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func setup(explore: Explore) {
        title.text = explore.title
        exploreImage.image = UIImage(named: explore.image)
    }
    
    private func configureUI() {
        clipsToBounds = false
        exploreImage.layer.cornerRadius = 20
        configureLabelUI()
    }
    
    private func configureLabelUI() {
        title.textColor = .white
        title.font = .h2
    }
}
