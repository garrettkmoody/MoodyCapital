//
//  ViewController.swift
//  MoodyCapital
//
//  Created by Garrett Moody on 6/22/21.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    let ref = Database.database().reference()
    
    @IBOutlet weak var navStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref.child("users").child("4455").setValue(["username": "bimbo"])
        
        navStackView.layer.cornerRadius = 20
                
        
    }
    
    


}

