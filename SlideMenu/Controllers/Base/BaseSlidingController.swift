//
//  BaseSlidingController.swift
//  SlideMenu
//
//  Created by 豊岡正紘 on 2019/02/15.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import UIKit

class BaseSlidingController: UIViewController {
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        closeMenu()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isOpened ? x + menuWith : x
        x = max(0, x)
        x = min(menuWith, x)
        
        redViewLeadingConstraint.constant = x
        redViewTraiingConstraint.constant = x
        
        darkCoverView.alpha = x/menuWith
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isOpened {
            
            if velocity.x < -500 {
                closeMenu()
                return
            }
            if translation.x < -menuWith/2 {
                closeMenu()
            }else{
                openMenu()
            }
            
        }else {
            if velocity.x > 500 {
                openMenu()
                return
            }
            if translation.x > menuWith/2 {
                openMenu()
            } else {
                closeMenu()
            }
        }
    }
    
    func openMenu() {
        redViewLeadingConstraint.constant = menuWith
        redViewLeadingConstraint.constant = menuWith
        darkCoverView.alpha = 1
        isOpened = true
        performAnimations()
    }
    
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTraiingConstraint.constant = 0
        darkCoverView.alpha = 0
        isOpened = false
        performAnimations()
    }
    
    fileprivate func performAnimations() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isOpened ? 1 : 0
        })
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTraiingConstraint: NSLayoutConstraint!
    fileprivate let menuWith: CGFloat = 300
    fileprivate var isOpened: Bool = false
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        closeMenu()
        
        switch indexPath.row {
        case 0:
            rigthViewController = UINavigationController(rootViewController: HomeController())
        case 1:
            rigthViewController = UINavigationController(rootViewController: ListViewController())
        case 2:
            rigthViewController = UINavigationController(rootViewController: BookmarkController())
        default:
            rigthViewController = UINavigationController(rootViewController: MomentController())
        }
        redView.addSubview(rigthViewController.view)
        addChild(rigthViewController)
        
        redView.bringSubviewToFront(darkCoverView)
    }
    
    var rigthViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    let menuController = MenuController()
    
    fileprivate func performRightViewCleanUp() {
        rigthViewController.view.removeFromSuperview()
        rigthViewController.removeFromParent()
    }
    
    
    
    fileprivate func setupViews() {
        
        view.addSubview(redView)
        view.addSubview(darkCoverView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueView.topAnchor.constraint(equalTo: redView.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWith),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
        ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        redViewTraiingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        redViewTraiingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let homeView = rigthViewController.view!
        let menuView = menuController.view!
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        blueView.addSubview(menuView)
        redView.addSubview(homeView)
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
            
        ])
        
        addChild(menuController)
        addChild(rigthViewController)
    }
}
