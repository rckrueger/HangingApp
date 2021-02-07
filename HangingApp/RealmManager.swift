//
//  RealmManager.swift
//  Hanging App
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//  For questions about this license, you may write to mailto:info@cosync.io
//
//  Created by Richard Krueger on 12/20/20.
//  Copyright (C) 2020 Cosync. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
            
    var app : App! = nil
    var userRealm: Realm?
    var publicRealm: Realm?

    private init() {
        self.app = App(id: Constants.REALM_APP_ID)
    }
    
    deinit {
    }
    
    func login(_ email: String, password: String, onCompletion completion: @escaping (Error?) -> Void) {

        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { result in
            
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    self.initRealms(onCompletion: { (err) in
                        completion(err)
                    })
                }
            case .failure(let error):
                completion(error)
            }
            
        }
        
    }

    func initRealms(onCompletion completion: @escaping (Error?) -> Void) {
        if  let user = self.app.currentUser {
            
            let uid = user.id
            
            // open user realm
            Realm.asyncOpen(configuration: user.configuration(partitionValue: "user_id=\(uid)")) { result in
                
                switch result {
                case .success(let realm):
                    self.userRealm = realm
                    
                    Realm.asyncOpen(configuration: user.configuration(partitionValue: "public")) { result in
                        
                        switch result {
                        case .success(let realm):
                            self.publicRealm = realm
                            completion(nil)

                        case .failure(let error):
                            fatalError("Failed to open public realm: \(error)")
                        }
                        
                    }

                case .failure(let error):
                    fatalError("Failed to open user realm: \(error)")
                }
                
            }
        }
    }
    
}

