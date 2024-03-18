//
//  NotificationView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 18.03.2024.
//

import SwiftUI

struct NotificationView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false

    let notificationHandler = NotificationHandler()
    @Environment(\.dismiss) var dismiss
    @State private var isDisplayed = false
    @State var selectedDate = Date()
    
    
    var body: some View {
        ZStack {
            Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
            VStack {
                sectionNavigtionBar
                ScrollView {
                    VStack {
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Enable Notifications")
                        }
                        .padding()
                        .onChange(of: notificationsEnabled) { isEnabled in
                            if isEnabled {
                                notificationHandler.enableNotifications()
                            } else {
                                notificationHandler.disableNotifications()
                            }
                        }
                    }
                }
            }
            
            .onAppear {
                if notificationsEnabled {
                    notificationHandler.enableNotifications()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    NotificationView()
}

extension NotificationView {
    private var sectionNavigtionBar: some View {
        HStack {
            Button(action: {dismiss()}) {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color.theme.ColorCaredsSwiftch)
            }
            Spacer()
            Text("Notification")
            Spacer()
        }.padding(.horizontal)
        .padding(.top,10)
    }
    
}
