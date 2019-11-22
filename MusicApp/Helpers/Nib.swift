//
//  Nib.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 22.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
