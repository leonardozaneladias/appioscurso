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
    fileprivate var selectedIndexPath: IndexPath?
    
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
        tableview.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(actionSheet(gesture:)))
        
        //tableview.gestureRecognizers = [longPress]
        tableview.addGestureRecognizer(longPress)

//          Modelo Internacionalização
//        let message = "save".localized
//        print(message)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if dao.size() > 0 {
//            let indexPath = IndexPath(row: 0, section: 0)
//            tableview.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
//        }
        
        if let indexPath = selectedIndexPath {
            tableview.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                self.tableview.deselectRow(at: indexPath, animated: true)
                self.selectedIndexPath = nil
            }
            
        }
    }
    
    //@objc indicador usado para orientar que terá código em objective-c
    @objc func actionSheet(gesture: UIGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }
        let point = gesture.location(in: tableview)
        
        guard let indexPath = tableview.indexPathForRow(at: point) else {
            return
        }
        
        let contact = dao.findByPosition(position: indexPath.row)
        AcitionManager(presentIn: self).showAction(of: contact)
   
    }
    
}

extension ContactTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell_ID", for: indexPath) as? CustomTableViewCell else {
            fatalError()
        }
        let contato = dao.findByPosition(position: indexPath.row)
        
        // Configure the cell...
        cell.labelImageView?.text = contato.nome
        cell.profileImageView?.image = contato.photo
        
        //cell.profileImageView?.layer.borderWidth = 3.0 // Cria borda
        //cell.profileImageView?.layer.borderColor = UIColor.red
        //cell.profileImageView?.layer.cornerRadius = 10.0 // Borda arredondada
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let contact = dao.findByPosition(position: indexPath.row)
            let title = "message.delete.header".localized
            let message = String(format: "message.delete".localized, arguments: [contact.nome])
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
            
            let removeAction = UIAlertAction(title: "remove".localized, style: .destructive){
                (acition) in
                self.dao.remove(byId: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .fade)
            }
            
            alert.addAction(removeAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}


extension ContactTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contato = dao.findByPosition(position: indexPath.row)
        
        performSegue(withIdentifier: "Update", sender: contato)
//
//        if let form = storyboard?.instantiateViewController(withIdentifier: "Form") as? ViewController {
//            form.contact = contato
//            navigationController?.pushViewController(form, animated: true)
//        }
        
    }
}

extension ContactTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let form = segue.destination as? ViewController
        form?.delegate = self
        
        if segue.identifier == "Update" {
            let contact = sender as? Contato
            form?.contact = contact
            
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

}

extension ContactTableViewController: CreateOrUpdateContactDelegate {
    func updated(contact: Contato) {
        if let row = dao.getPosition(by: contact){
            selectedIndexPath = IndexPath(row: row, section: 0)
        }
    }
    
    func created(contact: Contato) {
        if let row = dao.getPosition(by: contact){
            selectedIndexPath = IndexPath(row: row, section: 0)
        }
        
    }
}
