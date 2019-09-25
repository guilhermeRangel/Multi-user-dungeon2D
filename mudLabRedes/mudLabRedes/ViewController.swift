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

    var story : UIStoryboard?
    
    @IBAction func btn(_ sender: UIButton) {
        story = UIStoryboard(name: "Main", bundle: nil)
        for l in logins {
            if ((l.key == login.text) && (l.value == password.text)){
                if login.text! == "p1" {
                    
                    guard let viewController = story?.instantiateViewController(withIdentifier: "p1") else { return  }
                    self.present(viewController, animated: true, completion: nil)
                    
                }else if login.text! == "p2" {
                    guard let viewController = story?.instantiateViewController(withIdentifier: "p2") else { return  }
                    self.present(viewController, animated: true, completion: nil)
               
                }else if login.text! == "admin"{
                    guard let viewController = story?.instantiateViewController(withIdentifier: "server") else { return  }
                    self.present(viewController, animated: true, completion: nil)
                }
                
                
            }
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}




