//
//  UDPClient.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 18/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network

class UDPClient {
    var connection: NWConnection
    var queue: DispatchQueue
    
    init(name: String) {
        queue = DispatchQueue(label: "UDP Client Queue")
        
        //cria a coneccao
        connection = NWConnection(to: .service(name: name, type: "_http._udp", domain: "local", interface: nil), using: .udp)
        
        
        
        //status update handler
        connection.stateUpdateHandler = { [weak self] (newState) in
            
            switch (newState) {
            case .ready:
                print("pronto para enviar")
                self?.sendInitialFrame()
            case .failed(let error) :
                print("falhor \(error)")
            default:
                break
            }
            
        }
        
        //inicia a conecxao
        connection.start(queue: queue)
    }
        //envia o inicio "hello world"
    func sendInitialFrame() {
        let helloMessage = "olaMundo".data(using: .utf8)
        connection.send(content: helloMessage, completion: .contentProcessed({ (error)  in
            if let error = error {
                print("erro ao enviar \(error)")
            }
        }))
        
       
        
        connection.receiveMessage { (content, context, isComplete, error) in
            print("got cinnected")
            // Extract your message type from the received context.
            if content != nil {
                print(content?.description)
                
            }
            
        }
    }
    
    //send frames data
    
    func send(frames: [Data]) {
        connection.batch {
            for frame in frames {
                connection.send(content: frame, completion: .contentProcessed({(error) in
                    if let error = error {
                        print("Send error: \(error)")
                    }
                }))
            }
        }
    }
        
    
}
