//
//  ViewController.swift
//  contato
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     *
     *
     *
     */

    @IBOutlet weak var TextFildName: UITextField!
    @IBOutlet weak var FTextTelefone: UITextField!
    @IBOutlet weak var FtextEndereco: UITextField!
    @IBOutlet weak var FtextSite: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    
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
        
        photoImageView.image = contact.photo
        
    }
    
    private func fillContact() {
        contact?.nome = TextFildName.text!
        contact?.telefone = FTextTelefone.text!
        contact?.endereco = FtextEndereco.text!
        contact?.site = FtextSite.text!
        
        if let photo = photoImageView.image {
            contact?.photo = photo
        }
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
    
    @IBAction func choosePhoto(_ sender: UITapGestureRecognizer) {
        
        imageLoader.startAnimating()
        photoImageView.isUserInteractionEnabled = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alerta = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Take Photo", style: .default) { (action) in
                self.showImage(from: .camera)
            }
            let library = UIAlertAction(title: "Photo Libary", style: .default) { (action) in
                self.showImage(from: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) {(action) in self.stopImageLoader()}
            
            alerta.addAction(camera)
            alerta.addAction(library)
            alerta.addAction(cancel)
            
            present(alerta, animated: true, completion: nil)
        }else{
           showImage(from: .photoLibrary)
        }
        
        
    }
    
    private func showImage(from source: UIImagePickerControllerSourceType){
        
        let imageController = UIImagePickerController()
        imageController.allowsEditing = true
        imageController.delegate = self
        imageController.sourceType = source
        
        present(imageController, animated: true, completion: nil)
        
        
    }

}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        defer { // Executa antes do retorno
            stopImageLoader()
            picker.dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        
        
        photoImageView.image = image

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        stopImageLoader()
    }
    
    fileprivate func stopImageLoader() {
        imageLoader.stopAnimating()
        photoImageView.isUserInteractionEnabled = true
    }
    
}

