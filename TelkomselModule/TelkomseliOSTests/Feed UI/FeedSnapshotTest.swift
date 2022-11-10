//
//  FeedSnapshotTest.swift
//  FeedSnapshotTest
//
//  Created by Amin faruq on 02/10/22.
//

import XCTest
import TelkomseliOS
@testable import TelkomselModule

class FeedSnapshotTest: XCTestCase {
    
    func test_feedWithContent() {
        let sut = makeSUT()
        
        sut.display(feedWithContent())
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "FEED_WITH_CONTENT_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "FEED_WITH_CONTENT_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "FEED_WITH_CONTENT_light_extraExtraExtraLarge")
    }
    
    func test_feedWithFailedImageLoading() {
        let sut = makeSUT()
        
        sut.display(feedWithFailedImageLoading())
        
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "FEED_WITH_FAILED_IMAGE_LOADING_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "FEED_WITH_FAILED_IMAGE_LOADING_dark")
    }
    
    
    // MARK: - Helpers
    private func makeSUT() -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.loadViewIfNeeded()
        controller.tableView.showsVerticalScrollIndicator = false
        controller.tableView.showsHorizontalScrollIndicator = false
        return controller
    }
    
    private func feedWithContent() -> [ImageStub] {
        return [
            ImageStub(productName: "Indihome", description: "Layanan Wifi", rating: 4.0, latestVersion: "4.0.1", publisher: "Telkomsel", colorTheme: "B25068", image:  UIImage.make(withColor: .red)),
            
            ImageStub(productName: "UseeTV GO", description: "UseeTV GO menayangkan live streaming channel TV Indonesia atau internasional", rating: 4.0, latestVersion: "4.0.1", publisher: "Telkomsel", colorTheme: "51557E", image:  UIImage.make(withColor: .red)),
        ]
    }
    
    private func feedWithFailedImageLoading() -> [ImageStub] {
        return [
            ImageStub(productName: "Indihome", description: "Layanan Wifi", rating: 4.0, latestVersion: "4.0.1", publisher: "Telkomsel", colorTheme: "B25068", image:  nil),
            
            ImageStub(productName: "UseeTV GO", description: "UseeTV GO menayangkan live streaming channel TV Indonesia atau internasional", rating: 4.0, latestVersion: "4.0.1", publisher: "Telkomsel", colorTheme: "51557E", image: nil),
        ]
    }

}

private extension ListViewController {
    func display(_ stubs: [ImageStub]) {
        let cells: [CellController] = stubs.map { stub in
            let cellController = FeedImageCellController(viewModel: stub.viewModel, delegate: stub/*, selection: {}*/)
            stub.controller = cellController
            return CellController(id: UUID(), cellController)
        }
        
        display(cells)
    }
}

private class ImageStub: FeedImageCellControllerDelegate {
    let viewModel: FeedImageViewModel
    let image: UIImage?
    weak var controller: FeedImageCellController?
    
    init(productName: String, description: String, rating: Double, latestVersion: String, publisher: String, colorTheme: String, image: UIImage?) {
        self.viewModel = FeedImageViewModel(productName: productName, description: description, rating: rating, latestVersion: latestVersion, publisher: publisher, colorTheme: colorTheme)
        self.image = image
    }
    
    func didRequestImage() {
        controller?.display(ResourceLoadingViewModel(isLoading: false))
        
        if let image = image {
            controller?.display(image)
            controller?.display(ResourceErrorViewModel(message: .none))
        } else {
            controller?.display(ResourceErrorViewModel(message: "any"))
        }
    }
    
    func didCancelImageRequest() {}
}
