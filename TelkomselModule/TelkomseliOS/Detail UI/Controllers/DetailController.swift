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

    public var item: FeedItem!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.setImageFromURL(stringUrl: item.productLogo)
        backgroudView.backgroundColor = UIColor.hexStringToUIColor(hex: "#\(item.colorTheme)")
        detailNameLabel.text = item.productName
        detailDescriptionLabel.text = item.description
        detailRatingLabel.text = "Rating: \(item.rating)"
        detailPublisherLabel.text = item.publisher
        detailLatestVersionLabel.text = "Version: \(item.latestVersion)"
    }
}

