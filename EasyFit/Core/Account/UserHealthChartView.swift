//
//  UserHealthChartView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 14.03.2024.
//

import SwiftUI


struct HealthChartView: View {
    @EnvironmentObject var healthManager: HealthManger
    @EnvironmentObject var vmFood: FoodMoldeView
    
    @State private var showShareSheet = false
    @State private var pdfURL: URL? = nil
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    @State private var shareImage: UIImage?
    @Environment(\.dismiss) var dismiss
    @State var swiftcText = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.all)
                        .onTapGesture {
                            dismiss()
                        }
                    ScrollView {
                        VStack(alignment: .center) {
                            SectionDitelsFood
                            
                            HStack(spacing: 10) {
                                ForEach(Array(healthManager.activities.values), id: \.id) { activity in
                                    VStack {
                                        Image(systemName: activity.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 15, height: 15)
                                            .padding()
                                        VStack(alignment: .center) {
                                            Text(activity.title)
                                                .font(.system(size: 14, weight: .regular))
                                                .multilineTextAlignment(.leading)
                                            Text(activity.subtitle)
                                                .font(.system(size: 14, weight: .regular))
                                            Text(activity.amount)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                      
                                    }
                                }
                              
                            }.padding(.all)
                                .background(Color.theme.ColorCareds)
                                .clipShape(.rect(cornerRadius: 20))
                            VStack {
                                if let dailyProducts = vmFood.fetchList(for: Date.now), !dailyProducts.items.isEmpty {
                                    VStack(spacing: 13) {
                                        ForEach(dailyProducts.items, id: \.id) { product in
                                            ProductRow(product: product, vmFood: vmFood)
                                        }
                                    }
                                } else {
                                    Text("No items for this Meals")
                                }
                            }.padding(.all)
                        }
                    }
                        Button(action: {
                            shareImage = captureScreen()
                            showShareSheet = true
                        }, label: {
                            Text("EasyFit Share")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.all)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.theme.ColorCareds)
                                .background(Color.theme.ColorCaredsSwiftch)
                                .clipShape(.rect(cornerRadius: 10))
                                .padding(.horizontal)
                        })
                     
                    
                }
                .sheet(isPresented: $showShareSheet) {
                    if let shareImage = shareImage {
                        ActivityViewController(activityItems: [shareImage], applicationActivities: nil)
                    }
                }
            }
            
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
        .environmentObject(FoodMoldeView())
        .environmentObject(HealthManger())
}

extension HealthChartView {
    
    private var SectionDitelsFood: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Consumed on \(Date.now, style: .date)")
                .font(.system(size: 15, weight: .regular))
            HStack {
                Text("\(Int(vmFood.totalCalories(for: Date.now)))")
                    .font(.system(size: 22, weight: .regular))
                Text("/")
                Text("1854 Kcal")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(Color.gray)
            }

            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 10)
                    .clipShape(.rect(cornerRadius: 5))
                    .foregroundStyle(Color.gray.opacity(0.5))
                Rectangle()
                    .frame(width: (vmFood.totalCalories(for: Date.now) / 1854) * UIScreen.main.bounds.width, height: 10)
                    .clipShape(.rect(cornerRadius: 5))
                    .foregroundStyle(Color.theme.Green2manColor)
            }
            
            HStack {
                // Protein
                nutrientProgressView(
                    nutrientName: "Protein",
                    total: vmFood.totalProtein(for: Date.now),
                    goal: vmFood.proteinGoal)
                
                // Carbs
                nutrientProgressView(
                    nutrientName: "Carbs",
                    total: vmFood.totalCarbs(for: Date.now),
                    goal: vmFood.carbsGoal)
                
                // Fats
                nutrientProgressView(
                    nutrientName: "Fats",
                    total: vmFood.totalFats(for: Date.now),
                    goal: vmFood.fatsGoal)
            }

        }
        .padding(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.ColorCareds)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.bottom)

    }
}
struct ProductRow: View {
    let product: ProductDetail
    @ObservedObject var vmFood: FoodMoldeView
    
    var body: some View {
        HStack(alignment: .center) {
            LoadingImage(urlImage: product.imageUrl ?? "")
                .scaledToFill()
                .background(Color.gray.opacity(0.5))
                .frame(width: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 20) {
                Text(product.name ?? "N/A")
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .semibold))
                HStack(alignment: .bottom, spacing: 10) {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(Color.theme.GreenColorMain)
                    Text("\(String(format: "%.2f", vmFood.calculateCalories(for: product, gramsConsumed: vmFood.gramsConsumed)))")
                        .font(.system(size: 16, weight: .regular))
                    Text("cal")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.gray)
                    Spacer()
                }.padding(.trailing)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(Color.theme.ColorCareds) // Ensure you have this color defined
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

import UIKit

extension UIView {
    func snapshot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}


func captureScreen() -> UIImage? {
    guard let window = UIApplication.shared.windows.first else { return nil }
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    window.layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
