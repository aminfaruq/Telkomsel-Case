//
//  DetailUIComposer.swift
//  TelkomselApp
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit
import TelkomseliOS
import TelkomselModule

public final class DetailUIComposer {
    private init() {}
    
    public static func detailComposedWith(
        item: FeedItem
    ) -> DetailController {
        let detailController = makeDetailViewController(item: item)

        return detailController
    }
    
    private static func makeDetailViewController(item: FeedItem) -> DetailController {
        let bundle = Bundle(for: DetailController.self)
        let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
        let detailController = storyboard.instantiateInitialViewController() as! DetailController
        detailController.item = item
        detailController.hidesBottomBarWhenPushed = true
        return detailController
    }

}
