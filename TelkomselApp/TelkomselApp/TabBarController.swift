//
//  TabBarController.swift
//  TelkomselApp
//
//  Created by Amin faruq on 11/11/22.
//

import os
import UIKit
import Combine
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: FeedUIComposer.feedComposedWith(
                feedLoader: makeRemoteFeedLoaderWithLocalFallback,
                imageLoader: makeLocalImageLoaderWithRemoteFallback),
                                title: NSLocalizedString("My Feed", comment: ""), image: UIImage(systemName: "house")!),
            
            createNavController(for: ViewController(), title: NSLocalizedString("My Product", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    private func makeRemoteFeedLoaderWithLocalFallback() -> AnyPublisher<MapperItem<FeedItem>, Error> {
        makeRemoteFeedLoader()
            .map(makeFirstPage)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    private func makeRemoteFeedLoader() -> AnyPublisher<[FeedItem], Error> {
        let url = FeedEndpoint.post.url(baseURL: baseURL)
        return httpClient
            .postPublisher(url: url)
            .tryMap(FeedItemsMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> FeedImageDataLoader.Publisher {
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

