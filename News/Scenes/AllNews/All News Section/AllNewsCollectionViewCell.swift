//
//  AllNewsCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

class AllNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func setup(new: Article) {
        let imageURL = new.urlToImage ?? ""
        titleImage.load(urlString: imageURL)
        titleLabel.text = new.title
        descriptionLabel.text = new.description
        nameLabel.text = new.source.name
        publishedDate.text = new.publishedAt.convertDateStringToDate()
    }
    
    func configureUI() {
        clipsToBounds = false
        titleImage.layer.cornerRadius = 10
        configureTopLabelsUI()
        configureBottomLabelsUI()
        configureBookMarkButtonUI()
    }
    
    private func configureTopLabelsUI() {
        titleLabel.textColor = .nprimarycolor
        titleLabel.font = .medium
        
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .regular
    }
    
    private func configureBottomLabelsUI() {
        nameLabel.textColor = .nsecondarycolor
        nameLabel.font = .medium
        
        publishedDate.textColor = .nlightcolor
        publishedDate.font = .medium
    }
    
    private func configureBookMarkButtonUI() {
        bookMarkButton.setTitle("", for: .normal)
        bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookMarkButton.tintColor = .nlightcolor
    }
}
