//
//  ViewController.swift
//  FirebaseTry2
//
//  Created by Ryan Cox on 4/11/22.
//

import UIKit
import Firebase

class ViewController: UIViewController {
   
   
   var userEmail = ""
   let userRef = Database.database().reference(withPath: "user")
   let groupRef = Database.database().reference(withPath: "group")
   let userOfGroupRef = Database.database().reference(withPath: "userHasGroup")
   let eventRef = Database.database().reference(withPath: "event")
   var refObservers: [DatabaseHandle] = []
   var currentUser: String = ""
   var currentGroup: String = "Astronomy"
   
   @IBOutlet var nameLabel: UILabel?
   @IBOutlet weak var emailAddress: UITextField!
   
//   let userNameDis: UILabel
//   yourLabelName.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

   override func viewDidLoad() {
      super.viewDidLoad()
      self.nameLabel?.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
      // Do any additional setup after loading the view.
      }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      updateUser()
   }
   

   func updateUser() {
//      let completed = userRef.observe(.value) { snapshot in ##This was a relic from Grocr, idk what it does
      _ = userRef.observe(.value) { snapshot in
         for child in snapshot.children {
            if
               let snapshot = child as? DataSnapshot,
               let item = UserInfo(snapshot: snapshot) {
               if item.email == self.userEmail {
                  self.nameLabel?.text = "\(item.fName) \(item.lName)"
                  self.currentUser = item.key
               }
            }
         }
      }
   }
   
   
   @IBAction func deleteUser(_ sender: Any) {
      let completed = userRef.observe(.value) { snapshot in
         for child in snapshot.children {
            if
               let snapshot = child as? DataSnapshot,
               let item = UserInfo(snapshot: snapshot) {
               if item.key == self.currentUser {
                  let ref = self.userRef.child(self.currentUser)
                  ref.removeValue { error, _ in
                     print(error)
                  }
               }
            }
         }
      }
   }
   
   @IBAction func emailChange(_ sender: Any) {
      self.userEmail = self.emailAddress.text ?? "nothing"
      updateUser()
   }
   
   @IBAction func addEvent(_ sender: Any) {
      
      let alert = UIAlertController(title: "Event", message: "Add Event", preferredStyle: .alert)
      
      let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
         let key = self.userRef.child("event").childByAutoId().key
         guard let eventName = alert.textFields?[0].text,
               let eventLocation = alert.textFields?[1].text,
               let eventTime = alert.textFields?[2].text,
               let eventPrice = alert.textFields?[3].text
         else { return }
      
         let event = Event(key: key ?? "", eventName: eventName, eventLoc: eventLocation, eventTime: eventTime, eventPrice: eventPrice, groupId: "-N-hxQ2VIyE2WJUGPEfM")
      let eventInfo = self.eventRef.child(key ?? "")
      eventInfo.setValue(event.toAnyObject())
      }
      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: .cancel)

      alert.addTextField { textField in
         textField.placeholder = "Event Name"
      }
      alert.addTextField { textField in
         textField.placeholder = "Event Location"
      }
      alert.addTextField { textField in
         textField.placeholder = "Event Time"
      }
      alert.addTextField { textField in
         textField.placeholder = "Event Price"
      }
      
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true, completion: nil)
      
   }
   
   @IBAction func addGroup(_ sender: AnyObject) {
      
      let alert = UIAlertController(title: "Group", message: "Add Group", preferredStyle: .alert)
      
    
      let saveAction = UIAlertAction(
         title: "Save",
         style: .default) {_ in
            let key = self.userRef.child("group").childByAutoId().key
            guard let groupName = alert.textFields?[0].text,
                  let groupLink = alert.textFields?[1].text,
                  let groupDescription = alert.textFields?[2].text
            else { return }
            
            let group = GroupInfo(key: key ?? "", groupName: groupName, groupLink: groupLink, groupDescription: groupDescription)
            let groupInfo = self.groupRef.child(key ?? "")
            groupInfo.setValue(group.toAnyObject())
            
            let userOfGroup = UserHasGroup(userId: self.currentUser, groupId: key ?? "")
            let userOfGroupInfo = self.userOfGroupRef.child("\(self.currentUser)\(key!)")
            userOfGroupInfo.setValue(userOfGroup.toAnyObject())
         }
      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: .cancel)

      alert.addTextField { textField in
         textField.placeholder = "Group Name"
      }
      alert.addTextField { textField in
         textField.placeholder = "Group Link"
      }
      alert.addTextField { textField in
         textField.placeholder = "Group Description"
      }
      
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true, completion: nil)
   }
   
   @IBAction func addItemDidTouch(_ sender: AnyObject) {
      let alert = UIAlertController(
         title: "User", message: "Add User", preferredStyle: .alert
      )
      
      let saveAction = UIAlertAction(
         title: "Save",
         style: .default) {_ in
            let key = self.userRef.child("user").childByAutoId().key
            guard let firstName = alert.textFields?[0].text,
                  let lastName = alert.textFields?[1].text,
                  let userName = alert.textFields?[2].text,
                  let password = alert.textFields?[3].text,
                  let email = alert.textFields?[4].text
            else { return }
            
            let user = UserInfo(key: key ?? "", fName: firstName, lName: lastName, userName: userName, password: password, email: "\(email)@byui.edu", completed: false)
            
            let userInfo = self.userRef.child(key ?? "")
            userInfo.setValue(user.toAnyObject())
         }
      
      
      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: .cancel)

      alert.addTextField { textField in
         textField.placeholder = "First Name"
      }
      alert.addTextField { textField in
         textField.placeholder = "Last Name"
      }
      alert.addTextField { textField in
         textField.placeholder = "User Name"
      }
      alert.addTextField { textField in
         textField.placeholder = "Password"
         textField.isSecureTextEntry = true
      }
      alert.addTextField { textField in
         textField.placeholder = #"Confirmation Email (Don't include "@byui.edu""#
      }
      
      alert.addTextField { textField in
         textField.placeholder = "Tags (separate by commas)"
      }
      alert.addAction(saveAction)
      alert.addAction(cancelAction)
      
      present(alert, animated: true, completion: nil)
   }


}

