//
//  ViewController.swift
//  contato
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextFildName: UITextField!
    @IBOutlet weak var FTextTelefone: UITextField!
    @IBOutlet weak var FtextEndereco: UITextField!
    @IBOutlet weak var FtextSite: UITextField!
    let dao = ContatoDAO.shared
    var contact: Contato?
    var isNew: Bool = true
    var delegate: CreateOrUpdateContactDelegate?
    
    var contatos = Array<Contato>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let contact = self.contact {
            fillForm(with: contact)
            isNew = false
        }else{
            contact = Contato()
        }
    }
    
    private func fillForm(with contact: Contato){
        TextFildName.text = contact.nome
        FTextTelefone.text = contact.telefone
        FtextEndereco.text = contact.endereco
        FtextSite.text = contact.site
    }
    
    private func fillContact() {
        contact?.nome = TextFildName.text!
        contact?.telefone = FTextTelefone.text!
        contact?.endereco = FtextEndereco.text!
        contact?.site = FtextSite.text!
    }
    
    @IBAction func Salvar(_ sender: AnyObject) {
        fillContact()
        
        if isNew {
            dao.add(newContact: contact!)
            delegate?.created(contact: contact!)
        }else{
            delegate?.updated(contact: contact!)
            
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
}

