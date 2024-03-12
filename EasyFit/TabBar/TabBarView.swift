//
//  TabBarView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct TabBarView: View {
    @State var sectionTabBar: tabBarView = .home
    var body: some View {
        ZStack {
            
            Group {
                switch sectionTabBar {
                case .home:
                    HomeView()
                case .food:
                    FoodView()
                case .newsFeed:
                    Text("newsFeedView")
                case .profile:
                    ProfileView()
                }
            }
            VStack {
                HStack {
                    ForEach(moldeTabBar) { items in
                        Button(action: {
                            sectionTabBar = items.tabBar
                        }){
                            VStack(alignment: .center, spacing: 5) {
                                Image(items.icone)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(sectionTabBar == items.tabBar ? Color.theme.GreenColorMain : Color.gray)
                                Text(items.name)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(sectionTabBar == items.tabBar ? Color.theme.GreenColorMain : Color.gray)
                            }.frame(maxHeight: .infinity,alignment: .bottom)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
                
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.theme.ColorTabBarSwitch)
            .background(RoundedRectangle(cornerRadius: 0)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(Color.gray.opacity(0.2)))
            .frame(maxHeight: .infinity,alignment: .bottom)

            
        }
        .ignoresSafeArea(.keyboard)

    }
}

#Preview {
    TabBarView()
        .environmentObject(UserInfoViewModel())
        .environmentObject(HealthManger())
        .environmentObject(FoodMoldeView())

}



struct MoldeTabBar: Identifiable {
    let id = UUID().uuidString
    let name: String
    let icone: String
    let tabBar: tabBarView
}

enum tabBarView {
    case home
    case food
    case newsFeed
    case profile
}

let moldeTabBar : [MoldeTabBar] = [
    MoldeTabBar(name: "Home", icone: "iconhome", tabBar: .home),
    MoldeTabBar(name: "Food", icone: "IconeFood", tabBar: .food),
    MoldeTabBar(name: "News", icone: "IconNews", tabBar: .newsFeed),
    MoldeTabBar(name: "Profile", icone: "iconProfile", tabBar: .profile),
]



