//
//  SettingsController.swift
//  Tinber
//
//  Created by Xiaoping Weng on 2/4/20.
//  Copyright © 2020 Xiaoping. All rights reserved.
//

import UIKit

class CustomPickerViewController: UIImagePickerController {
    var imageButton: UIButton?
}

class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // instance properties
    lazy var image1button = createButton(selecter: #selector(handleSelectPhoto))
    lazy var image2button = createButton(selecter: #selector(handleSelectPhoto))
    lazy var image3button = createButton(selecter: #selector(handleSelectPhoto))

    @objc func handleSelectPhoto(button: UIButton) {
        print("Select photo with button", button)
        
        let imagePicker = CustomPickerViewController()
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            (picker as? CustomPickerViewController)?.imageButton?.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func createButton(selecter: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: selecter, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.addSubview(image1button)
        let padding: CGFloat = 16
        
        image1button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))

        image1button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [image2button, image3button])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: nil, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: 0, bottom: padding, right: padding))
        stackView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive =  true
        
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    fileprivate func setupNavigationItems() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleCancel)),
                                              UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleCancel))]
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
   

}
