//
//  UITableView+Dequeueing.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 21/09/22.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
