//
//  SettingsViewController.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import UIKit
import SnapKit

class SettingsViewController: ViewController<SettingsViewModel> {
    
    // MARK: UI
    override func makeUI() {
        super.makeUI()
        
        hideBackButtonIfNeeded = true
        navigationItem.title = "Settings"
    }
    
}

