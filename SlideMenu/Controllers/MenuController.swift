//
//  MenuController.swift
//  SlideMenu
//
//  Created by 豊岡正紘 on 2019/02/15.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import UIKit

struct MenuItem {
    let image: UIImage
    let title: String
}

extension MenuController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.didSelectMenuItem(indexPath: indexPath)
    }
}

class MenuController: UITableViewController {
    
    let menuItems = [
        MenuItem(image: #imageLiteral(resourceName: "profile"), title: "ホーム"),
        MenuItem(image: #imageLiteral(resourceName: "lists"), title: "リスト"),
        MenuItem(image: #imageLiteral(resourceName: "bookmarks"), title: "ブックマーク"),
        MenuItem(image: #imageLiteral(resourceName: "moments"), title: "モーメント")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let menuHeaderVIew = MenuHeaderView()
        return menuHeaderVIew
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        
        let menuItem = menuItems[indexPath.row]
        cell.iconImageView.image = menuItem.image
        cell.titleLabel.text = menuItem.title
        return cell
    }
}
