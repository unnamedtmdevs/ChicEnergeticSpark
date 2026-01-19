//
//  AppViewModel.swift
//  cc90
//
//  Created by Simon Bakhanets
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    // Убрали всю логику AppsFlyer
    // Теперь приложение всегда показывает обычный интерфейс (игры)
    @Published var isCheckingAttribution = false
    @Published var shouldShowWebView = false
    @Published var campaignURL: URL?
    
    init() {
        // Больше нет проверки AppsFlyer
        // Приложение сразу показывает обычный интерфейс
    }
}
