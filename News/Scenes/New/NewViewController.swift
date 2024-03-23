//
//  NewViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 20/03/2024.
//

import UIKit

class NewViewController: UIViewController {

    // MARK: - Properties
    let viewModel: NewViewModel
    var bookmarkButton: UIBarButtonItem!

    // MARK: - IBOutlets
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Initialization
    init(viewModel: NewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showNewsDetails()
    }
    
    // MARK: - Private Methods
    private func showNewsDetails() {
        let news = viewModel.article
        nameLabel.text = news.source.name
        publishedDate.text = news.publishedAt.convertDateStringToDate()
        titleLabel.text = news.title
        authorLabel.text = news.author
        let imageURL = news.urlToImage ?? ""
        titleImage.load(urlString: imageURL)
        descriptionLabel.text = news.description
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        titleImage.layer.cornerRadius = 50
        configureHeadersUI()
        configureTitleLabelUI()
        addingRightBarButtonItems()
    }
    
    private func configureHeadersUI() {
        labelBackgroundView.backgroundColor = .nsecondarycolor
        nameLabel.textColor = .white
        nameLabel.font = .medium
        nameLabel.layer.cornerRadius = 4
        publishedDate.textColor = .nlightcolor
        publishedDate.font = .medium
    }
    
    private func configureTitleLabelUI() {
        titleLabel.textColor = .nprimarycolor
        titleLabel.font = .h2
        
        authorLabel.textColor = .nlightcolor
        authorLabel.font = .medium
    }
    
    @objc func rightButtonAction() {
        viewModel.addToBookMarks()
        updateBookMarksButtonUI()
    }
    
    @objc func anotherButtonAction() {
        viewModel.webSiteLinkTapped()
    }
    
    private func addingRightBarButtonItems() {
        navigationItem.backButtonTitle = ""
        bookmarkButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .done,
            target: self,
            action: #selector(rightButtonAction))
        
        let linkButton = UIBarButtonItem(
            image: UIImage(systemName: "link"),
            style: .plain,
            target: self,
            action: #selector(anotherButtonAction))
        
        navigationItem.rightBarButtonItems = [bookmarkButton, linkButton]
    }
    
    private func updateBookMarksButtonUI() {
        if PTabBarViewModel.shared.bookMarks.contains(where: {$0 == viewModel.article }) {
            bookmarkButton.tintColor = .nsecondarycolor
            bookmarkButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            bookmarkButton.tintColor = .darkGray
            bookmarkButton.image = UIImage(systemName: "bookmark")
        }
    }
}
