//
//  ViewController.swift
//  SkinDemo
//
//  Created by Benjamin Hendricks on 8/8/17.
//  Copyright © 2017 Creatubbles. All rights reserved.
//

import UIKit
import SwiftTheme

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var currentThemeIsBase: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        label.text = "Let's make a really long string, this string is really long and will either be truncated or multiple lines"
    }
    
    func setupTheme() {
        view.theme_backgroundColor = ThemeColorPicker(keyPath: "Colors.red")
        imageView.theme_image = ThemeImagePicker(keyPath: "Images.icon")
        let fontKeyPrefix = "Fonts.regularText"
        label.theme_font = ThemeFontPicker(nameKeyPath: "\(fontKeyPrefix).name", sizeKeyPath: "\(fontKeyPrefix).size", styleKeyPath: "\(fontKeyPrefix).style", map: {
            name, size, style in
            guard let name = name as? String,
                let style = style as? String,
                let size = size as? Int else {
                    return UIFont.systemFont(ofSize: 16)
            }
            return UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: name, UIFontDescriptorSizeAttribute: size, UIFontDescriptorFaceAttribute: style]), size: CGFloat(size))
        })
        `switch`.theme_backgroundColor = ThemeColorPicker(keyPath: "Colors.white")
        `switch`.theme_onTintColor = ThemeColorPicker(keyPath: "Colors.orange")
        view.layoutIfNeeded()
    }

    @IBAction func switchChanged(_ sender: Any) {
        if currentThemeIsBase {
            currentThemeIsBase = false
            ThemeManager.setTheme(plistName: "SkinConfiguration", path: .customBundle(type(of: self)))
        } else {
            currentThemeIsBase = true
            ThemeManager.setTheme(plistName: "BaseConfiguration", path: .customBundle(type(of: self)))
        }
        setupTheme()
    }
}

