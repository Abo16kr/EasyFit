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

    @EnvironmentObject var vmUser : UserInfoViewModel
    @EnvironmentObject var healthManger :  HealthManger
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
                ScrollView {
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
                            Text("Your daily health statistics")
                                .font(.system(size: 15, weight: .regular))

                            Chart {
                                ForEach(healthData) { data in
                                    // Steps line
                                    LineMark(
                                        x: .value("Date", data.date, unit: .day),
                                        y: .value("Steps", data.steps)
                                    )
                                    .foregroundStyle(.blue)
                                    
                                    // Calories line
                                    LineMark(
                                        x: .value("Date", data.date, unit: .day),
                                        y: .value("Calories", data.calories)
                                    )
                                    .foregroundStyle(.red)
                                    
                                    // Sleep hours line
                                    LineMark(
                                        x: .value("Date", data.date, unit: .day),
                                        y: .value("Sleep Hours", data.sleepHours)
                                    )
                                    .foregroundStyle(.green)
                                }
                            }.frame(height: 200)
                            
                            
                        }.padding(.horizontal)
                        
                        
                        
                        LazyVGrid(columns: columns,alignment: .center){
                            ForEach(healthManger.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key) { item in
                                ActivtyCstmesView(activty: item.value)
                            }
                        }
                        
                    }
                    
                }
            }
            .onAppear {
                vmUser.loadImage(forKey: "imagePrilesKeySaved")
                healthManger.fetchTodaySteps()
                healthManger.fetchTodayCalories()
                healthManger.fetchTodaySleep()
                vmUser.exteactCuetData()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserInfoViewModel())
        .environmentObject(HealthManger())
}

extension HomeView  {
    
    private var SectionTabBar: some View {
        HStack {
            NavigationLink {
                AccountView()
            } label: {
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
                    .frame(width: 20, height: 20)
                    .frame(width: 45, height: 45)
                    .background(RoundedRectangle(cornerRadius: .infinity)
                        .stroke(lineWidth: 1.0).foregroundStyle(Color.gray.opacity(0.5)))
            }

        }.padding(.horizontal)
    }
    
}



struct DailyHealthData: Identifiable {
    let id = UUID()
    let date: Date
    var steps: Int
    var calories: Int
    var sleepHours: Double
}
