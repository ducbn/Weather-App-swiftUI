//
//  weatherApp.swift
//  weather
//
//  Created by Bui Ngoc Duc on 19/7/24.
//

import SwiftUI

@main
struct weatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ListViewModel())
            
        }
    }
}
