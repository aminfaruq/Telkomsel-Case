//
//  FeedImageCell.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 10/11/22.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    @IBOutlet private(set) public var feedImageContainer: UIView!
    @IBOutlet private(set) public var feedImageView: UIImageView!
    @IBOutlet private(set) public var feedImageRetryButton: UIButton!
    @IBOutlet private(set) public var feedProductNameLabel: UILabel!
    
    var onRetry: (() -> Void)?
    
    @IBAction private func retryButtonTapped() {
        onRetry?()
    }
}
