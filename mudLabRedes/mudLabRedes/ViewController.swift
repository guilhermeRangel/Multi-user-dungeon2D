//
//  ViewController.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 09/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit
import Network


class ViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var label: UILabel!
    var logins : [String : String] = ["admin": "admin",
                                      "p1" : "1234",
                                      "p2" : "1234",
                                      "p3" : "1234"]
    
    var gameViewController : GameViewController?
    var gameViewController2 : GameViewController2?
    var logicGameServer : GameServerViewController?
    
    
    
    
    @IBAction func server(_ sender: UIButton) {
        label.text = "SERVER"
        // SERVER
        logicGameServer = GameServerViewController()
    }
    
    @IBAction func player1(_ sender: UIButton) {
        label.text = "CLIENT"
        // CLIENT
        
       
      
            for l in logins {
                if ((l.key == login.text) && (l.value == password.text)){
                    
                    if l.key == "p1" {
                        gameViewController = GameViewController()
                    }else if l.key == "p2" {
                        
                        gameViewController2 = GameViewController2()
                    }
                }
                
            
            
        }
        
        
    }
    
    @IBAction func player2(_ sender: UIButton) {
        
        for l in logins {
                       if ((l.key == login.text) && (l.value == password.text)){
                           
                           if l.key == "p1" {
                               gameViewController = GameViewController()
                           }else if l.key == "p2" {
                               
                               gameViewController2 = GameViewController2()
                           }
                       }
                       
                   
                   
               }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
}




