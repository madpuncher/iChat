//
//  MainTabBarController.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 09.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        tabBar.tintColor = .purple
    }
    
    private func setupTabBar() {
        let listVC = ListViewController()
        let peopleVC = PeopleViewController()
        
        guard
            let listImage = UIImage(systemName: "bubble.left.and.bubble.right"),
            let peopleImage = UIImage(systemName: "person.2") else { return }
        
        viewControllers = [
            createdTabBarController(viewController: listVC, title: "Conversation", image: listImage),
            createdTabBarController(viewController: peopleVC, title: "People", image: peopleImage)
        ]
    }
    
    private func createdTabBarController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}

//MARK: Setup Canvas
import SwiftUI

struct MainTabBarControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            MainTabBarController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
