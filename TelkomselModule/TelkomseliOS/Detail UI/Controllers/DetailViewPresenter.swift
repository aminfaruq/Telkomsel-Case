//
//  DetailControllerVM.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 13/11/22.
//

import Foundation
import TelkomselModule

public protocol DetailViewDelegate: NSObjectProtocol {
    func didShowItem(item: FeedItem)
    func didSaveProduct(item: FeedItem)
    func didDeleteProduct(productName: String)
    func didShowProductByName(productName: String) -> Bool?
}

class DetailViewPresenter {
    weak private var delegate : DetailViewDelegate?

    init(delegate: DetailViewDelegate){
        self.delegate = delegate
    }
    
    func showItem(item: FeedItem){
        delegate?.didShowItem(item: item)
    }
    
    func saveProduct(item: FeedItem) {
        delegate?.didSaveProduct(item: item)
    }
    
    func deleteProduct(productName: String) {
        delegate?.didDeleteProduct(productName: productName)
    }
    
    func showProductByName(productName: String) -> Bool {
        delegate?.didShowProductByName(productName: productName) ?? false
    }
}
