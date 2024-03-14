//
//  HomeView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State private var averageIsShown = false
    @State var showAccountInfo: Bool = false
    
    @EnvironmentObject var vmTabBar: ModleViewTabBar
    @EnvironmentObject var vmUser : UserInfoViewModel
    @EnvironmentObject var healthManger :  HealthManger
    @EnvironmentObject var vmFood: FoodMoldeView

    let columns = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
    ]
    
    var healthData: [DailyHealthData] = [
         DailyHealthData(date: Date().addingTimeInterval(-86400 * 2), steps: 3000, calories: 400, sleepHours: 5),
         DailyHealthData(date: Date().addingTimeInterval(-86400), steps: 6500, calories: 700, sleepHours: 6.5),
         DailyHealthData(date: Date(), steps: 5000, calories: 450, sleepHours: 7)
     ]
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        
                        SectionTabBar
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hey, \(vmUser.currentUserName)!")
                                .font(.system(size: 22, weight: .regular))
                            Text("You have two workouts scheduled today")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.gray.opacity(0.8))
                        }.padding(.all)
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            LazyVGrid(columns: columns,alignment: .center){
                                ForEach(healthManger.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key) { item in
                                    ActivtyCstmesView(activty: item.value)
                                }
                            }.padding(.top)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Your daily body")
                                .font(.system(size: 15, weight: .regular))
                                .padding(.all)
                            
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 10) {
                                    NavigationLink { DailyWaterDitelsView() } label: {
                                        DailyWaterView()
                                            .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                                    }
                                    
                                }.padding(.horizontal)
                            }
                        }
                    }.padding(.bottom,80)
                    
                }
                .navigationTitle("EasyFit").navigationBarTitleDisplayMode(.inline)
                
                if showAccountInfo {
                    ZStack {
                        Color.black.opacity(0.7).ignoresSafeArea(.all)
                        if let image = vmUser.imageProfiles {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .background(Color.gray.opacity(0.5))
                                .clipShape(Circle())
                        } else if vmUser.imageProfiles == nil {
                           Image(systemName: "person.and.background.dotted")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(Color.gray.opacity(0.5))
                                .frame(width: 200, height: 200)
                                .background(Color.gray.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }.onTapGesture {
                        withAnimation(.spring){
                            showAccountInfo.toggle()
                        }
                    }
                }
            }
            .onAppear {
                vmUser.loadImage(forKey: "imagePrilesKeySaved")
                healthManger.fetchTodaySteps()
                healthManger.fetchTodayCalories()
                healthManger.fetchTodaySleep()
                vmTabBar.dissmisBarSaerch = false
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserInfoViewModel())
        .environmentObject(HealthManger())
        .environmentObject(FoodMoldeView())
        .environmentObject(ModleViewTabBar())
    
}

extension HomeView  {
    
    private var SectionTabBar: some View {
        HStack {
            Button(action: {
                withAnimation(.spring){
                    showAccountInfo.toggle()
                }
            }) {
                if let image = vmUser.imageProfiles {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                } else if vmUser.imageProfiles == nil {
                   Image(systemName: "person.and.background.dotted")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .frame(width: 45, height: 45)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                }
            }
           
            Spacer()

            NavigationLink {
                Text("No Nativations")
            } label: {
                Image(systemName: "bell.badge")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color.theme.ColorCaredsSwiftch)
                    .frame(width: 15, height: 15)
                    .frame(width: 45, height: 45)
                    .background(RoundedRectangle(cornerRadius: .infinity)
                        .stroke(lineWidth: 1.0).foregroundStyle(Color.gray.opacity(0.5)))
            }

        }.padding(.horizontal)
    }
    
}


