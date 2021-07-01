//
//  SignUpViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/23/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        if(notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            view.frame.origin.y = -200
        } else if(notification.name == UIResponder.keyboardWillHideNotification) {
            view.frame.origin.y = 0
        }
        
    }
    
    
    // Function that designs the toast notifications that appear
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 175, y: self.view.frame.size.height-self.view.frame.size.height/2, width: 350, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func verifyForm() -> Bool {
        if(usernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            self.showToast(message: "Please fill out all fields!", font: .systemFont(ofSize: 18))
            return false
        } else {
            return true
        }
    }
    

    @IBAction func onSignUpTapped(_ sender: Any) {
        
        //Ensure that all elements on the form are filled out before continuing
        if(!verifyForm()) {
            return
        }
        
        //Creates a user in Firebase
        Auth.auth().createUser(withEmail: emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)) {
            (authResult, error) in
          //If there is no error, add username and uid info into the Database
            if(error == nil) {
                let ref = Database.database().reference()
                ref.child("users").child(authResult!.user.uid).updateChildValues(["username": self.usernameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)])
                ref.child("users").child(authResult!.user.uid).updateChildValues(["initial": 0.0])
                ref.child("users").child(authResult!.user.uid).updateChildValues(["share": 0.0])
                
                self.showToast(message: "Signed Up Successfully!", font: .systemFont(ofSize: 18))
               
                //Afterwards, sign in the user and open up the home screen
                Auth.auth().signIn(withEmail: self.emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: self.passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (authResult, error) in
                    if(error == nil) {
                        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarView") as! UITabBarController
                        viewController.modalPresentationStyle = .fullScreen
                        self.navigationController!.pushViewController(viewController, animated:true)
                    } else {
                        print(error!)
                    }
                }
            } else {
                print(error!)
            }
        }
        
        
    }
    
    func formatViews() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
