//
//  ContactTableViewController.swift
//  contato
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit


class ContactTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    fileprivate let dao = ContatoDAO.shared
    
    /*
    let fakeContact = Contato()
    fakeContact.nome = "Leo"
    fakeContact.endereco = "Rua"
    fakeContact.telefone = "119"
    fakeContact.site = ".com"
    
    dao.a
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
}

extension ContactTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("OKOK")
        return dao.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell_ID", for: indexPath)
        let contato = dao.findByPosition(position: indexPath.row)
        
        // Configure the cell...
        cell.textLabel?.text = contato.nome
        return cell
    }
    
    
}
