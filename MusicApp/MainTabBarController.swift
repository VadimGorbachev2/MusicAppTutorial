//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 15.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit

protocol MainTabBarControllerDelegate: class {
    
    func minimizeTrackDetailController()
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    // Constraints for setupTrackDetailView
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorContsraint: NSLayoutConstraint!
    // SearchViewController
    let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.9725490196, green: 0.2509803922, blue: 0.3725490196, alpha: 1)
        
        setupTrackDetailView()
        searchViewController.tabBarDekegate = self          // !!!
        
        viewControllers = [
            generateViewController(rootViewController: searchViewController, image: #imageLiteral(resourceName: "ios10-apple-music-search-5nav-icon") , title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "ios10-apple-music-library-5nav-icon")  , title: "Library")
        ]
    }
    
    // MARK: create new ViewController
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
       
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    // MARK: TrackDetailView logic
    
    private func setupTrackDetailView() {
        
        
        trackDetailView.backgroundColor = .white
        view.insertSubview(trackDetailView, belowSubview: tabBar)  // вместо addSubview, чтобы было над tabBar
        // Delegates !!
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchViewController
        // Autolayout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorContsraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        bottomAnchorContsraint.isActive = true
        maximizedTopAnchorConstraint.isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
}


// MARK: MainTabBarController extension for a trackDetailView animation

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func minimizeTrackDetailController() {
        
        maximizedTopAnchorConstraint.isActive = false               // !!! важен порядок установки констрейнтов !!!
        bottomAnchorContsraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                            self.view.layoutIfNeeded()
                            self.tabBar.alpha = 1
                        },
                       completion: nil)
    }
    
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        maximizedTopAnchorConstraint.isActive = true
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorContsraint.constant = 0
        
        UIView.animate(withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 1,
        options: .curveEaseOut,
        animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
        },
        completion: nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
        
    }
}

