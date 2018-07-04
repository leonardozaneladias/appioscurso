//
//  ContatoDAO.swift
//  contato
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ContatoDAO: NSObject {
    
    private var contatos: [Contato]
    static let shared = ContatoDAO()
    
    /*
    static var instance: ContatoDAO!
    static func shareInstance() -> ContatoDAO {
        if instance == nil{
            instance = ContatoDAO()
        }
        return instance
    }
    */
    
    override private init() {
        contatos = Array()
    }
    
    func add(newContact contato: Contato) {
        contatos.append(contato)
        print(contatos)
    }
    
    func getPosition(by contact: Contato) -> Int? {
        return contatos.index(where: { other in return other.nome == contact.nome })
    }

    func size() -> Int {
        return contatos.count
    }
    
    func findByPosition(position: Int) -> Contato {
        return contatos[position]
    }
    
    func remove(byId id: Int) {
        contatos.remove(at: id)
    }
}
