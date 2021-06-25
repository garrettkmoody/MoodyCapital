//
//  ViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/22/21.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var navStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatViews()
        
        
        //Check if a user is already logged in on the phone
        if Auth.auth().currentUser != nil {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarView") as! UITabBarController
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated:true)
        }
                
        
    }
    
    
    func formatViews() {
        navStackView.layer.cornerRadius = 20
    }
    
    


}

