//
//  LoginViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/23/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
    //Ensure all fields in form are filled out
    func verifyForm() -> Bool {
        if(emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        //If all fields are filled out, attempt to sign in the user
        if(verifyForm()) {
            Auth.auth().signIn(withEmail: self.emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: self.passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (authResult, error) in
                if(error == nil) {
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarView") as! UITabBarController
                    viewController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(viewController, animated:true)
                } else {
                    print(error!)
                    self.showToast(message: "Something went wrong", font: .systemFont(ofSize: 18))
                }
            }
        } else {
            showToast(message: "Please fill out all fields!", font: .systemFont(ofSize: 18))
        }
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
