//
//  DetailController.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit
import TelkomselModule

public final class DetailController: UIViewController {
    @IBOutlet private(set) public var detailImageView: UIImageView!
    @IBOutlet private(set) public var backgroudView: UIView!
    @IBOutlet private(set) public var detailNameLabel: UILabel!
    @IBOutlet private(set) public var detailDescriptionLabel: UILabel!
    @IBOutlet private(set) public var detailRatingLabel: UILabel!
    @IBOutlet private(set) public var detailPublisherLabel: UILabel!
    @IBOutlet private(set) public var detailLatestVersionLabel: UILabel!
    @IBOutlet private(set) public var detailActionBtn: UIButton!

    var viewModel: DetailControllerVM!

    public var item: FeedItem!
    private var buttonIsSelected = false

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DetailControllerVM()

        detailImageView.setImageFromURL(stringUrl: item.productLogo)
        backgroudView.backgroundColor = UIColor.hexStringToUIColor(hex: "#\(item.colorTheme)")
        detailNameLabel.text = item.productName
        detailDescriptionLabel.text = item.description
        detailRatingLabel.text = "Rating: \(item.rating)"
        detailPublisherLabel.text = item.publisher
        detailLatestVersionLabel.text = "Version: \(item.latestVersion)"
        
        bindAction()
    }
    
    private func bindAction() {
        if viewModel.isProductSaved(productName: item.productName) {
            detailActionBtn.backgroundColor = .red
            detailActionBtn.setTitle("Delete", for: .normal)
            buttonIsSelected = true
        } else {
            detailActionBtn.backgroundColor = .blue
            detailActionBtn.setTitle("Save", for: .normal)
            buttonIsSelected = false
        }
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        if buttonIsSelected {
            detailActionBtn.backgroundColor = .red
            detailActionBtn.setTitle("Delete", for: .normal)
            viewModel.deleteProduct(productName: item.productName)
        } else {
            detailActionBtn.backgroundColor = .blue
            detailActionBtn.setTitle("Save", for: .normal)
            viewModel.saveProduct(item: item)
        }
        bindAction()
    }
}

