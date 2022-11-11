//
//  TabBarController.swift
//  TelkomselApp
//
//  Created by Amin faruq on 11/11/22.
//

import os
import UIKit
import Combine
import CoreData
import TelkomseliOS
import TelkomselModule

class TabBarController: UITabBarController {
    
    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "co.id.aminfaruq.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var baseURL = URL(string: "https://apimocha.com")!

    convenience init(httpClient: HTTPClient, scheduler: AnyDispatchQueueScheduler) {
        self.init()
        self.httpClient = httpClient
        self.scheduler = scheduler
    }
    
    private lazy var logger = Logger(subsystem: "co.id.aminfaruq.TelkomselApp", category: "main")
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        do {
            return try CoreDataFeedStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("feed-store.sqlite"))
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    internal lazy var feedController = FeedUIComposer.feedComposedWith(
        feedLoader: makeRemoteFeedLoader,
        imageLoader: makeImageLoaderWithRemoteFallback,
        selection: showDetail)
  
    private func showDetail(for item: FeedItem) {
        let detail = DetailUIComposer.detailComposedWith(item: item)
        feedController.navigationController?.pushViewController(detail, animated: true)
    }
    
    private func makeRemoteFeedLoader() -> AnyPublisher<MapperItem<FeedItem>, Error> {
        makeRemoteItemFeedLoader()
            .map(makeFirstPage)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    private func makeRemoteItemFeedLoader() -> AnyPublisher<[FeedItem], Error> {
        let url = FeedEndpoint.post.url(baseURL: baseURL)
        return httpClient
            .postPublisher(url: url)
            .tryMap(FeedItemsMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func makeImageLoaderWithRemoteFallback(url: URL) -> FeedImageDataLoader.Publisher {
        return httpClient
            .postPublisher(url: url)
            .tryMap(FeedImageDataMapper.map)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    private func makeFirstPage(items: [FeedItem]) -> MapperItem<FeedItem> {
        makePage(items: items)
    }
    
    private func makePage(items: [FeedItem]) -> MapperItem<FeedItem> {
        MapperItem(items: items)
    }
}

extension TabBarController {
    func setupVCs() {
        viewControllers = [
            createNavController(for: feedController,
                                title: NSLocalizedString("My Feed", comment: ""),
                                image: UIImage(systemName: "house")!),
            
            createNavController(for: ViewController(),
                                title: NSLocalizedString("My Product", comment: ""),
                                image: UIImage(systemName: "person")!)
        ]
    }
}

extension TabBarController {
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}

