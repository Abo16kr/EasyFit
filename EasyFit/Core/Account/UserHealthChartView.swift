//
//  UserHealthChartView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 14.03.2024.
//

import SwiftUI
import Charts

struct HealthChartView: View {
    @ObservedObject var healthManager = HealthManger()
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]),
                                         startPoint: .top,
                                         endPoint: .bottom)
    
    var body: some View {
        VStack {
            Text("Health Chart")
                .font(.title)
                .padding()
            
            Chart {
                ForEach(Array(healthManager.activities.values), id: \.id) { activity in
                    LineMark(
                        x: .value("Activity", activity.title),
                        y: .value("Amount", activity.amount)
                    )
                    .interpolationMethod(.cardinal)
                    .symbol(by: .value("Activity", activity.title))
                }
                ForEach(Array(healthManager.activities.values), id: \.id) { activity in
                    AreaMark(
                        x: .value("Activity", activity.title),
                        y: .value("Amount", activity.amount)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(linearGradient)
                }
            }
            .frame(height: 300)
            .padding()
        }
        .onAppear {
            healthManager.fetchTodaySteps()
            healthManager.fetchTodayCalories()
            healthManager.fetchTodaySleep()
        }
    }
}



#Preview {
    HealthChartView()
}
