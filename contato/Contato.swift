//
//  Contato.swift
//  contato
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class Contato: CustomStringConvertible {
    
    var nome: String!
    var endereco: String!
    var telefone: String!
    var site: String!
    
    var description: String {
        return "Nome: \(nome!), Endereço: \(endereco!), Telefone: \(telefone!), Site: \(site!)"
    }

}
