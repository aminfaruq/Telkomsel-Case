//
//  UIRefreshControl+Helpers.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 25/09/22.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
