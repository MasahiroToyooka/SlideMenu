//
//  TableViewCell.swift
//  SlideMenu
//
//  Created by 豊岡正紘 on 2019/02/16.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Masa"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@mass_ssa"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let statementLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "70 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "フォロー  ", attributes: [.foregroundColor: UIColor.darkGray]))
        attributedText.append(NSAttributedString(string: "40 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "フォロワー", attributes: [.foregroundColor: UIColor.darkGray]))
        
        label.attributedText = attributedText
        return label
    }()
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "image").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
//        button.contentHorizontalAlignment = .fill
//        button.contentVerticalAlignment = .fill
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 50/2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClose() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileButton, UIView()]),
            UIView(),
            nameLabel,
            userNameLabel,
            UIView(),
            UIView(),
            UIView(),
            statementLabel]
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
