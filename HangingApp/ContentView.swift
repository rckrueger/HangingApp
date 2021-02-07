//
//  ContentView.swift
//  HangingApp
//
//  Created by Richard Krueger on 2/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            print("hang me")
            
            RealmManager.shared.login("john@doe.com", password: "mongodb", onCompletion: { (error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            NSLog("Login failed")
                        } else {
                            NSLog("Login success")
                        }
                    }
                }
            )
            
            
        }, label: {
            Text("Press to Hang")
        })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
