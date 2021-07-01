//
//  SettingsViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/29/21.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var signoutBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatViews()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignOutTapped(_ sender: Any) {
        logoutUser()
    }
    
    func logoutUser() {
        // call from any screen
        
        do { try Auth.auth().signOut() }
        catch { print("Already signed out") }
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func formatViews() {
        signoutBT.backgroundColor = .systemGray2
        signoutBT.layer.cornerRadius = 15
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
