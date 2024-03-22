//
//  NotificationCollectionViewCell.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 21/03/2024.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func setup(new: Article) {
        nameLabel.text = new.source.name
        titleLabel.text = new.title
        publishedDate.text = new.publishedAt.convertDateStringToDate()
        hourLabel.text = new.publishedAt.formatDate()
    }
    
    private func configureUI() {
        clipsToBounds = false
        lineView.backgroundColor = .nlightcolor
        configureLabelsUI()
    }
    
    private func configureLabelsUI() {
        nameLabel.textColor = .darkGray
        nameLabel.font = .medium
        
        titleLabel.textColor = .nprimarycolor
        titleLabel.font = .h3
        
        publishedDate.textColor = .darkGray
        publishedDate.font = .medium
        
        hourLabel.textColor = .darkGray
        hourLabel.font = .h1
    }

}
