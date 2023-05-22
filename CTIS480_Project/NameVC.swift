//
//  ViewController.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 26.12.2022.
//

import UIKit
import CoreData

class NameVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    var dest: WeightVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameField.backgroundColor = UIColor(patternImage: UIImage(named: "gra")!).withAlphaComponent(0.5)

    }
    
    func addToCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        user.name = nameField.text
        
        do {
            try context.save()
        } catch {
            // error
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if nameField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Name Cannot Be Empty", message: "Please Enter a Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
        else {
            if segue.identifier == "name" {
                localUser.name = nameField.text!
            }
        }
    }
}



