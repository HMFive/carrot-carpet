//
//  UsersVC.swift
//  CTIS480_Project
//
//  Created by Yusuf Çiftci on 27.12.2022.
//

import UIKit
import CoreData
import AVFoundation


class UsersVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        getAllUsers()
        fetchData()
        // Do any additional setup after loading the view.
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.separatorStyle = .none
        usersTableView.showsVerticalScrollIndicator = false
        usersTableView.addGestureRecognizer(longPressGesture)
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "gra")!).withAlphaComponent(1)

    }
    
    
    let trashSoundURL =  Bundle.main.url(forResource: "empty", withExtension: "mp3")
    var beepPlayer = AVAudioPlayer()
    
    func playMySound(){
        if let soundGo = trashSoundURL {
            do {
               try beepPlayer = AVAudioPlayer(contentsOf: soundGo, fileTypeHint: AVFileType.mp3.rawValue)
              
            } catch {
                print("errors")
            }
        }
     
        beepPlayer.prepareToPlay()
        beepPlayer.play()

    }
    
    var users = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var usersTableView: UITableView!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yolla" {
            if let controller = segue.destination as? DashboardVC {
                let cell = sender as! UserTVC
                controller.cal = Double(cell.userLabel.text!)
            }
        }
    }
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            let results = try context.fetch(request) as! [User]
        } catch {
            // handle error
        }
    }
    
    func getAllUsers() {
        do {
            users = try context.fetch(User.fetchRequest())
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        } catch {
            //efrr
        }
    }
    
    func createUser(name: String, age: Int, gender: String, height: Int, weight: Int) {
        let newUser = User(context: context)
        newUser.name = localUser.name
        newUser.age = Int32(localUser.age)
        newUser.height = Int32(localUser.height)
        newUser.weight = Int32(localUser.weight)
        newUser.gender = localUser.gender
        newUser.bmr = localUser.bmr
        fetchData()
        do {
            try context.save()
        }
        catch {

        }
    }
    
    func deleteUser(user: User) {
        context.delete(user)
        
        do {
            try context.save()
            getAllUsers()
            playMySound()
        }
        catch {
            // error
        }
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let location = gesture.location(in: usersTableView)
            if let indexPath = usersTableView.indexPathForRow(at: location) {
                let user = users[indexPath.row]
                let sheet = UIAlertController(title:"Edit", message: nil, preferredStyle: .actionSheet)
                
                sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
                    _ in self.deleteUser(user: user)
                } ))
                sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                    action in
                    sheet.dismiss(animated: true)
                }))
                
                present(sheet, animated: true)
            }
        }

    }

}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTVC
        let user = users[indexPath.row]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        cell.userView.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.nameLabel.text = user.name! + "             Calories:"
        cell.userLabel.text = String(user.bmr)
        if user.gender == "male" {
            cell.userImage.image = UIImage(named: "male")
        } else {
            cell.userImage.image = UIImage(named: "female")
        }
        cell.userView.layer.cornerRadius = cell.userView.frame.height / 5
        cell.blurView.layer.cornerRadius = cell.userView.frame.height / 5
        return cell
    }
}
