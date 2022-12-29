//
//  RMTabViewController.swift
//  RickAndMorty
//
//  Created by Thuta sann on 12/29/22.
//

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    // MARK: - Tabs Set Up Function
    private func setupTabs(){
        
        let charactersVC = RMCharacterViewController();
        let locationVC = RMLocationViewController();
        let episodesVC = RMEpisodeViewController();
        let settingsVC = RMSettingViewController();
        
        // MARK: Large Title Display Mode
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic;
        locationVC.navigationItem.largeTitleDisplayMode = .automatic;
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic;
        settingsVC.navigationItem.largeTitleDisplayMode  = .automatic;

        // MARK: UINavigation Controller
        let nav1 = UINavigationController(rootViewController: charactersVC);
        let nav2 = UINavigationController(rootViewController: locationVC);
        let nav3 = UINavigationController(rootViewController: episodesVC);
        let nav4 = UINavigationController(rootViewController: settingsVC);
        
        // MARK: Tab bar Items
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        // MARK: Prefers Large Titles
        for nav in [nav1, nav2, nav3, nav4]{
            nav.navigationBar.prefersLargeTitles = true;
        }
        
        // MARK: Set View Controllers
        setViewControllers([
            nav1, nav2, nav3, nav4
        ], animated: true)
        
        
    }


}

