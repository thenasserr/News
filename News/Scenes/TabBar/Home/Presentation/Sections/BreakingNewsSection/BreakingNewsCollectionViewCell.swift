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
        publishedDate.text = convertDateStringToDate(new.publishedAt)
        descriptionLabel.text = new.description
    }
    
    private func configureUI() {
        titleImage.layer.cornerRadius = 15
        clipsToBounds = false
        configureLabelsUI()
    }
    
    private func configureLabelsUI() {
        name.textColor = .darkGray
        name.font = .h3
        
        publishedDate.textColor = .darkGray
        publishedDate.font = .h3
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = .regular
        
    }
    
    func convertDateStringToDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd, yyyy"
            dateFormatter.timeZone = TimeZone.current
            
            return dateFormatter.string(from: date)
        } else {
            print("Invalid date format")
            return nil
        }
    }
}
