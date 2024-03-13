//
//  FoodView.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI
import Combine


struct FoodView: View {
    
    @EnvironmentObject var vmUser: UserInfoViewModel
    @EnvironmentObject var vmFood: FoodMoldeView
    @EnvironmentObject var vmTabBar: ModleViewTabBar

    @State private var input = ""
    @State private var isScannerPresented = false
    @State private var showDetail = false
    @State private var showBarSearch: Bool = false
    
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.ColorBagronedSwich.ignoresSafeArea(.all)
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            ScrollDate(selectedDate: $selectedDate)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Consumed on \(selectedDate, style: .date)")
                                    .font(.system(size: 15, weight: .regular))
                                HStack {
                                    Text("\(Int(vmFood.totalCalories(for: selectedDate)))")
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
                                        .frame(width: (vmFood.totalCalories(for: selectedDate) / 1854) * UIScreen.main.bounds.width, height: 10)
                                        .clipShape(.rect(cornerRadius: 5))
                                        .foregroundStyle(Color.theme.Green2manColor)
                                }
                                
                                HStack {
                                    // Protein
                                    nutrientProgressView(
                                        nutrientName: "Protein",
                                        total: vmFood.totalProtein(for: selectedDate),
                                        goal: vmFood.proteinGoal)
                                    
                                    // Carbs
                                    nutrientProgressView(
                                        nutrientName: "Carbs",
                                        total: vmFood.totalCarbs(for: selectedDate),
                                        goal: vmFood.carbsGoal)
                                    
                                    // Fats
                                    nutrientProgressView(
                                        nutrientName: "Fats",
                                        total: vmFood.totalFats(for: selectedDate),
                                        goal: vmFood.fatsGoal)
                                }

                            }
                            .padding(.all)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.theme.ColorCareds)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Text("Meals Day")
                                        .font(.system(size: 15, weight: .semibold))
                                    Spacer()
                                    Text("See all")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(Color.gray.opacity(0.5))
                                }.padding(.bottom)


                                if let dailyProducts = vmFood.fetchList(for: selectedDate), !dailyProducts.items.isEmpty {
                                    VStack(spacing: 13) {
                                        ForEach(dailyProducts.items, id: \.id) { product in
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
                                                        Text("\(vmFood.calculateCalories(for: product))")
                                                            .font(.system(size: 16, weight: .regular))
                                                        Text("cal")
                                                            .font(.system(size: 14, weight: .regular))
                                                            .foregroundStyle(Color.gray)
                                                        Spacer()

                                                    Button(action: {
                                                        if let index = vmFood.addedProducts.firstIndex(where: { $0.id == product.id }) {
                                                                vmFood.deleteProduct(at: index)
                                                            }
                                                        }) {Image(systemName: "trash")
                                                                .foregroundColor(.red)}
                                                    }.padding(.trailing)
                                                }
                                            }
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 80)
                                            .background(Color.theme.ColorCareds)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                } else {
                                    Text("No items for this date")
                                }

                            }.padding(.horizontal)
                        }.padding(.bottom,180)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut){
                        vmTabBar.dissmisBarSaerch = true
                        vmTabBar.dissmisBarSaerchFeed = false
                    }
                    vmFood.loadProducts()
                   
                    
                }
                .sheet(isPresented: $isScannerPresented) {
                    BarcodeScannerView { scannedBarcode in
                        vmFood.fetchProduct(barcode: scannedBarcode)
                        isScannerPresented = false
                        showDetail = true
                    }
                }
                .overlay { SearchBarInfo }
            }
            .navigationTitle("Daily progress")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
            .environmentObject(FoodMoldeView())
            .environmentObject(ModleViewTabBar())
        
    }
}

@ViewBuilder
private func nutrientProgressView(nutrientName: String, total: Double, goal: Double) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text(nutrientName)
            .font(.system(size: 15, weight: .regular))
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 5)
                .clipShape(.rect(cornerRadius: 5))
                .foregroundStyle(Color.gray.opacity(0.5))
            Rectangle()
                .frame(width: max((total / goal) * 100, 5), height: 5)
                .clipShape(.rect(cornerRadius: 5))
                .foregroundStyle(Color.theme.Green2manColor)
        }
    }
}



extension FoodView  {
 
    private var SearchBarInfo: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    if input.allSatisfy(\.isNumber) {
                        vmFood.fetchProduct(barcode: input)
                    } else {
                        vmFood.searchProductByName(input)
                    }
                    if !input.isEmpty {
                        showDetail = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.theme.GreenColorMain)
                }
                TextField("Search Food or product", text: $input)
                Button(action: { isScannerPresented = true }) {
                    Image(systemName: "barcode.viewfinder")
                        .foregroundStyle(Color.theme.GreenColorMain)
                }
            }.padding(.all)
                .background(Color.theme.ColorCareds)
                .padding(.bottom, showBarSearch ? 0 : (isKeyboardShown() ? 50 : 0))
                .sheet(isPresented: $showDetail) {
                    FoodDetailView(viewModel: vmFood)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                           self.showBarSearch = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                           self.showBarSearch = false
                    }
        }.offset(y: vmTabBar.dissmisBarSaerch ? 0 : 50)
    }
    func isKeyboardShown() -> Bool {
         guard let currentWindow = UIApplication.shared.windows.first else {
             return false
         }
         return currentWindow.safeAreaInsets.bottom > 0
     }
    
}

struct DayView: View {
    var date: Date
    var isSelected: Bool
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("d") // "31"
        return formatter
    }
    
    private var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE") // "W" for Wednesday
        return formatter
    }
    
    var body: some View {
        VStack {
            Text(weekdayFormatter.string(from: date))
                .font(.system(size: 14,weight:.regular))
            Text(dayFormatter.string(from: date))
                .font(.system(size: 18,weight: .regular))
        }
        .padding(.all,10)
        .foregroundColor(isSelected ? .theme.ColorCareds : .theme.ColorCaredsSwiftch)
        .background(isSelected ? Color.theme.GreenColorMain : Color.clear)
        .clipShape(.rect(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.gray.opacity(0.5), lineWidth: isSelected ? 0 : 1)
        )
        .frame(width: 45,height: 90)
    }
}


struct ScrollDate: View {
    @Binding  var selectedDate : Date
    private let daysOffset = Array(-4...30)
    private let dayInSeconds = 86400.0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                LazyHStack {
                    ForEach(daysOffset, id: \.self) { offset in
                        let date = Date().addingTimeInterval(Double(offset) * dayInSeconds)
                        DayView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                            .id(offset)
                            .onTapGesture { self.selectedDate = date }
                    }
                }
                .onAppear {
                    value.scrollTo(2)
                }
            }
        }
    }
}

