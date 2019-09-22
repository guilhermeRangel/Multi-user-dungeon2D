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

    @IBOutlet weak var label: UILabel!
    
    var server: UDPServer?
    var client: UDPClient?
    var gameViewController : GameViewController?
    
    @IBAction func server(_ sender: UIButton) {
        label.text = "SERVER"
        // SERVER
        server = UDPServer()
        
        
    }
    
    @IBAction func client(_ sender: UIButton) {
        label.text = "CLIENT"
        // CLIENT
         
        gameViewController = GameViewController()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        

        
    }


}




