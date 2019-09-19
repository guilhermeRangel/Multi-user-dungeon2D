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
    
    init() {
        queue = DispatchQueue(label: "UDP Client Queue")
        //cria a coneccao
        connection = NWConnection(to: .service(name: "serverMUD", type: "_http._udp", domain: "local", interface: nil), using: .udp)

        //status update handler
        connection.stateUpdateHandler = { [weak self] (newState) in
            print("estado: \(newState)")
            switch (newState) {
            case .ready:
                print("pronto para enviar dados")
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
//        let helloMessage = "ola mundo 123".data(using: .utf8)
        let helloMsg : UDPServer.sendAndReceiveMsgsCodable = UDPServer.sendAndReceiveMsgsCodable(msgObj: "ola mundo")
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(helloMsg) else {return print("erro Encode")}
        
        connection.send(content: data, completion: .contentProcessed({ (error)  in
            

            
            print("Dados enviados com sucesso!")
            if let error = error {
                print("erro ao enviar dados\(error)")
            }
        }))
        
       
        //eu acho q isso é tipo um ack
        connection.receiveMessage { (content, context, isComplete, error) in
            print("got cinnected")
            // Extract your message type from the received context.
            if content != nil {
                print("dados \(content?.description)")
                
            }
            
        }
    }
    
    //send  data
    
    func send(frames: [Data]) {
        connection.batch {
            for frame in frames {
                connection.send(content: frame, completion: .contentProcessed({(error) in
                   print("empacotando data \(frame)")
                    if let error = error {
                        print("Send error: \(error)")
                    }
                }))
            }
        }
    }
        
    
}
