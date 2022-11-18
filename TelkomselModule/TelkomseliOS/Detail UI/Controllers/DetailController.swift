//
//  DetailController.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit
import RealmSwift
import TelkomselModule

public final class DetailController: UIViewController  {
    private lazy var store: FeedStore = {
        let realm = try! Realm()
        return  RealmDataFeedStore(realm: realm)
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store )
    }()
    
    @IBOutlet private(set) public var detailImageView: UIImageView!
    @IBOutlet private(set) public var backgroudView: UIView!
    @IBOutlet private(set) public var detailNameLabel: UILabel!
    @IBOutlet private(set) public var detailDescriptionLabel: UILabel!
    @IBOutlet private(set) public var detailRatingLabel: UILabel!
    @IBOutlet private(set) public var detailPublisherLabel: UILabel!
    @IBOutlet private(set) public var detailLatestVersionLabel: UILabel!
    @IBOutlet private(set) public var detailActionBtn: UIButton!
    
    lazy var presenter = DetailViewPresenter(delegate : self)
    
    public var item: FeedItem!
    
    private var buttonIsSelected = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.showItem(item: item)
        bindAction()
    }
    
    private func bindAction() {
        if presenter.showProductByName(productName: item.productName) {
            detailActionBtn.backgroundColor = .systemRed
            detailActionBtn.setTitle("Delete", for: .normal)
            buttonIsSelected = true
        } else {
            detailActionBtn.backgroundColor = .systemBlue
            detailActionBtn.setTitle("Save", for: .normal)
            buttonIsSelected = false
        }
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        if buttonIsSelected {
            detailActionBtn.backgroundColor = .systemRed
            detailActionBtn.setTitle("Delete", for: .normal)
            presenter.deleteProduct(productName: item.productName)
        } else {
            detailActionBtn.backgroundColor = .systemBlue
            detailActionBtn.setTitle("Save", for: .normal)
            presenter.saveProduct(item: item)
        }
        
        bindAction()
    }
    
}

extension DetailController: DetailViewDelegate {
    
    public func didShowItem(item: FeedItem) {
        detailImageView.setImageFromURL(stringUrl: item.productLogo)
        backgroudView.backgroundColor = UIColor.hexStringToUIColor(hex: "#\(item.colorTheme)")
        detailNameLabel.text = item.productName
        detailDescriptionLabel.text = item.description
        detailRatingLabel.text = "Rating: \(item.rating)"
        detailPublisherLabel.text = item.publisher
        detailLatestVersionLabel.text = "Version: \(item.latestVersion)"
    }
    
    public func didSaveProduct(item: FeedItem) {
        try? localFeedLoader.save(item)
    }
    
    public func didDeleteProduct(productName: String) {
        try? localFeedLoader.deleteCacheFeed(productName)
    }
    
    public func didShowProductByName(productName: String) -> Bool {
        try! localFeedLoader.isProductSaved(productName)
    }
}
