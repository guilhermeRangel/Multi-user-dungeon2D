//
//  Servidor.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 16/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network

class UDPServer {

    var listener : NWListener
    var queue : DispatchQueue
    var connected : Bool = false
    
    init?() {
        queue = DispatchQueue(label: "UDP Server Queue")
        //create the listener
        listener = try! NWListener(using: .udp, on: .http)
        
        
        //listen to changes in the service registration
        listener.service = NWListener.Service(type: "test")
        listener.serviceRegistrationUpdateHandler = { (serviceChange) in
            
            switch (serviceChange) {
            case .add(let endpoint):
                switch endpoint {
                    case let .service(name, _, _, _):
                        print("Listening as \(name)")
                case .hostPort(let host, let port):
                    print("host \(host)")
                case .unix(let path):
                    print("path \(path)")
                @unknown default:
                    break
                }
            default:
                break
            }
            
        }
        
        
        //handle incoming connections
        listener.newConnectionHandler = { [weak self] (newConnection) in
            if let strongSelf = self {
                newConnection.start(queue: strongSelf.queue)
                strongSelf.receive(on: newConnection)
            }
            
        }
        
        //handle listener state changes
        listener.stateUpdateHandler = { [weak self] (newState) in
            switch (newState) {
            case .ready:
                print("listening on port \(String(describing: self?.listener.port))")
            case .failed(let error):
                print("Listener failed with error: \(error)")
            default:
                break
            }
        }
        
        //start the listener
        listener.start(queue: queue)
        
    }
    
    //receive packets from the other side and push to scren as videos
    func receive(on connection: NWConnection){
        connection.receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            if let frame = content {
                if !self.connected {
                    connection.send(content: frame, completion: .idempotent)
                    print("echoed initial content: \(frame)")
                    self.connected = true
                }else {
                    print("nao deu")
                }
                
                if error == nil {
                    self.receive(on: connection)
                }
            }
            
        }
    }
}

