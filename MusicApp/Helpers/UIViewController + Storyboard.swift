//
//  UIViewController + Storyboard.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 18.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // что за классные функции?? разобраться
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: no initial view controller in \(name) storyboard!")
        }
    }
}
