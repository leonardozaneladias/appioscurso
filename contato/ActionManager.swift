//
//  ActionManager.swift
//  contato
//
//  Created by Leonardo Zanela Dias on 04/07/2018.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class AcitionManager {
    
    let controller: UIViewController
    
    init(presentIn controller: UIViewController) {
        self.controller = controller
    }
    
    func showAction(of contact: Contato) {
        let alert = UIAlertController(title: "message.action.contact".localized, message: contact.nome, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "message.action.cancel".localized, style: .cancel, handler: nil)
        let call = UIAlertAction(title: "message.action.call".localized, style: .default) { (action) in
            self.call(phone: contact.telefone)
        }
        
        let browse = UIAlertAction(title: "message.action.browse".localized, style: .default) { (action) in
            self.browse(site: contact.site)
        }
        
        let maps = UIAlertAction(title: "message.action.maps".localized, style: .default) { (action) in
            self.maps(address: contact.endereco)
        }
        
        alert.addAction(cancel)
        alert.addAction(call)
        alert.addAction(browse)
        alert.addAction(maps)
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    private func OpenApp(by url: String){
        
        guard let appUrl = URL(string: url) else {
            return
        }
        UIApplication
            .shared
            .open(appUrl, options:[:], completionHandler: nil)
    }
    
    private func call(phone: String) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            OpenApp(by: "tel:" + phone)
            
        } else {
            
            let alert = UIAlertController(title: "Sorry", message: "You can't call", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Back", style: .cancel, handler: nil)
            alert.addAction(cancel)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func browse(site: String){
        if site.hasPrefix("http") {
            OpenApp(by: site)
        } else {
            OpenApp(by: "http://" + site)
        }
    }
    
    private func maps(address: String){
//        guard let url = "https://maps.google.com/maps?q=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            return
//        }
        guard let url = "maps://?q=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        OpenApp(by: url)
    }
    
    
    
    
    
}
