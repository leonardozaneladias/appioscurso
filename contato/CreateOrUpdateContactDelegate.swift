//
//  CreateOrUpdateContactDelegate.swift
//  contato
//
//  Created by Leonardo Zanela Dias on 03/07/2018.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

protocol CreateOrUpdateContactDelegate {
    
    func created(contact: Contato)
    func updated(contact: Contato)
    
}
