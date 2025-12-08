//
//  ContentView.swift
//  cc90
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @StateObject private var progressStore = JourneyProgressStore()
    @StateObject private var appViewModel = AppViewModel()
    @State private var showOnboarding = false
    
    var body: some View {
        ZStack {
            if appViewModel.isCheckingAttribution {
                // Показываем загрузку пока проверяем атрибуцию AppsFlyer
                LoadingView()
            } else if appViewModel.shouldShowWebView, let campaignURL = appViewModel.campaignURL {
                // Неорганическая установка - показываем WebView с кампанией
                CampaignWebView(campaignURL: campaignURL)
            } else {
                // Органическая установка - показываем обычное приложение
                ZStack {
                    if showOnboarding {
                        OnboardingView(progressStore: progressStore) {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showOnboarding = false
                            }
                        }
                        .transition(.opacity)
                    } else {
                        MainTabView(progressStore: progressStore)
                            .transition(.opacity)
                    }
                }
                .onAppear {
                    showOnboarding = !progressStore.hasCompletedOnboarding
                }
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("PrimaryBackground")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentGreen")))
                    .scaleEffect(1.5)
                
                Text("Crystal Pathways")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("TextPrimary"))
            }
        }
    }
}
