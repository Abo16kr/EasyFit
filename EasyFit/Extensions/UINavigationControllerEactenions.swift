//
//  UINavigationControllerEactenions.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation
import SwiftUI

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

