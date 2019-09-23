//
//  UDPClient.swift
//  mudLabRedes
//
//  Created by Guilherme Rangel on 18/09/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation
import Network
import SpriteKit

class UDPClient {
    var connection: NWConnection
    var queue: DispatchQueue
    var playerScene : GameScene?
    var playerScene2 : GameScene2?
    var modelServer : LogicGame?
    var modelPlayers : playersList? = playersList()
    
    
    init(scene: GameScene?, scene2: GameScene2?) {
        if scene != nil {
            playerScene = scene
        }else if scene2 != nil {
            playerScene2 = scene2
        }
        
        queue = DispatchQueue(label: "UDP Client Queue")
        //cria a coneccao
        connection = NWConnection(to: .service(name: "serverMUD", type: "_http._udp", domain: "local", interface: nil), using: .udp)

        //status update handler
        connection.stateUpdateHandler = { [weak self] (newState) in
            print("estado: \(newState)")
            switch (newState) {
            case .ready:
                print("pronto para enviar dados")

            case .failed(let error) :
                print("falhor \(error)")
            default:
                break
            }
            
        }
        
        //inicia a conecxao

       
        connection.start(queue: queue)
    }
  
    
    func sendInitialFrame(position : CGPoint, node : SKSpriteNode)  {
//        let helloMessage = "ola mundo 123".data(using: .utf8)
        let helloMsg : UDPServer.sendAndReceiveMsgsCodable = UDPServer.sendAndReceiveMsgsCodable(playerId: node.name, points: node.position)
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
            print("got connected")
            // Extract your message type from the received context.
            if content != nil {
                print("dados \(content?.description)")
                
            }
            
        }
    }
    
  
    
    
    func sendFrame(node : SKSpriteNode) {
        let idAndPosition : UDPServer.sendAndReceiveMsgsCodable = UDPServer.sendAndReceiveMsgsCodable(playerId: node.name, points: node.position)
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(idAndPosition) else {return print("erro Encode")}
            
            connection.send(content: data, completion: .contentProcessed({ (error)  in
                print("Enviado Position Player")
                if let error = error {
                    print("erro ao enviar dados\(error)")
                }
            }))
            
           
            //eu acho q isso é tipo um ack
            connection.receiveMessage { (content, context, isComplete, error) in
                print("got connected")
                
                // Extract your message type from the received context.
                if content != nil {
                           if let frame = content {
                        
                           // self.connection.send(content: frame, completion: .idempotent)
                                       let decoder = JSONDecoder()
                            if let dataReceived = try? decoder.decode(UDPServer.sendAndReceiveMsgsCodable.self, from: frame) {
                                          if let ObjId = dataReceived.playerId {
                                          
                                              print("msg recebida : \(ObjId)")
                                              
                                              if let ObjPosition = dataReceived.points {
                                                     print("msg recebida Points : \(ObjPosition)")
                                                  
                                                
                                                //logica para atualizar a localizacao do player 2
                                                if ObjId == "player1"{
                                                    print("p1")
                                                    
                                                    self.modelPlayers = self.modelServer?.instance()
                                                    print(self.modelPlayers?.players?.count)
//                                                    self.playerScene?.scene?.childNode(withName: "player1")?.run(SKAction.move(to: ObjPosition, duration: 3))
                                                   
                                                   
                                                    
                                                    
                                                }else if ObjId == "player2"{
                                                       print("p2")
                                                    print(self.playerScene2?.scene?.children.count)
                                                }
                                                
                                                
                                                  
                                              }
                                          }
                                      
                    
                                     // self.connected = true
                                  }else {
                                      print("nao deu")
                                  }
                                  
                    
                              }
                }
                
            }
        }
    
    //send  data
    //Define um bloco no qual as chamadas para enviar e receber são processadas como um lote para melhorar o desempenho.
    
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
