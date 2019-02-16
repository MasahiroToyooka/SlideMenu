//
//  HomeController.swift
//  SlideMenu
//
//  Created by 豊岡正紘 on 2019/02/16.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupNavigationItems()
    }
    
    fileprivate func setupNavigationItems() {
        
        navigationItem.title = "ホーム"
        
        let image = #imageLiteral(resourceName: "image").withRenderingMode(.alwaysOriginal)
        let customView = UIButton(type: .system)
        
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        customView.layer.borderWidth = 0.5
        customView.layer.borderColor = UIColor.lightGray.cgColor
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
}
