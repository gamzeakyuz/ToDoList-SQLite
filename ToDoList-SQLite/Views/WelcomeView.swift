//
//  WelcomeView.swift
//  ToDoList-SQLite
//
//  Created by Gamze Akyüz on 10.05.2025.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var launchManager: AppLaunchManager
    @State private var animate = false
    @State private var fadeIn = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.orange]),
                           startPoint: .bottom,
                           endPoint: .topLeading)
                .ignoresSafeArea()

            VStack(spacing: 25) {
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.white)
                    .scaleEffect(animate ? 1.1 : 0.9)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animate)

                Text("Bugün Yeni Bir Başlangıç.")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeOut(duration: 1.2).delay(0.3), value: fadeIn)

                Text("Görevlerini sırala, öncelik ver ve zihnini hafiflet. Kontrol artık sende.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeOut(duration: 1.2).delay(0.6), value: fadeIn)
                
                Text("Haydi başlayalım..")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(fadeIn ? 1 : 0)
                    .animation(.easeOut(duration: 1.2).delay(0.6), value: fadeIn)

                Spacer()

                Button(action: {
                    launchManager.markWelcomeSeen()
                }) {
                    Text("Başlayalım")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                .opacity(fadeIn ? 1 : 0)
                .animation(.easeOut(duration: 1.2).delay(1.2), value: fadeIn)
            }
            .padding(.top, 60)
        }
        .onAppear {
            animate = true
            fadeIn = true
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(launchManager: AppLaunchManager())
    }
}
