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
    
    var contatos = Array<Contato>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func Salvar(_ sender: AnyObject) {
        let contato = Contato()
    
        contato.nome = TextFildName.text!
        contato.telefone = FTextTelefone.text!
        contato.endereco = FtextEndereco.text!
        contato.site = FtextSite.text!
        
        dao.add(newContact: contato)
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
}

