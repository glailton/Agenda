//
//  ContactViewController.swift
//  Agenda
//
//  Created by Glailton Costa on 12/15/16.
//  Copyright © 2016 Glailton Costa. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    @IBAction func saveAction(_ sender: AnyObject) {
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The ContactViewController is not inside a navigation controller.")
        }
    }
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        if let contact = contact {
            navigationItem.title = contact.name
            nameTextField.text   = contact.name
            phoneTextField.text = contact.phone
        }
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let button = sender as? UIBarButtonItem
        
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        
        contact = Contact(name: name, phone: phone)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
}
