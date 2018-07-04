//
//  String+Localized.swift
//  contato
//
//  Created by Leonardo Zanela Dias on 03/07/2018.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
