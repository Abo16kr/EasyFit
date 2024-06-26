//
//  UserInfoViewModel.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation
import SwiftUI

class UserInfoViewModel: ObservableObject {
    
    @Published var cruuentWeek: [Date] = []
    @Published var cruuentDay: Date = Date()
    
    @Published var wakeUpTime: Date = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date ?? Date() {
            didSet {
                UserDefaults.standard.set(self.wakeUpTime, forKey: "wakeUpTime")
            }
        }
    @Published  var age: DateComponents = DateComponents()
    
    
    // MARK: User Info Save
    @AppStorage("NAMEUSER_KEY") var currentUserName: String = ""
    @AppStorage("AGE_KEY") var currentUserAge: Int = 18
    @AppStorage("GENDER_KEY") var currentUserGender: String = "man"
    @AppStorage("HEIGHT_KEY") var currentUserHeight: Double = 160
    @AppStorage("WEIGHT_KEY") var currentUserWeight: Int = 60
    @AppStorage("NUMBER_KEY") var currentUserCaloresDay: Int = 1250
    @AppStorage("waterIntake") var waterIntake: Double = 700

    
    @Published var imageProfiles: UIImage?
    @Published var savedimages: Bool = false
    
    @Published var selectedImage: UIImage? = nil
    
    func saveImage(imageName: String, image: UIImage,key: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        do {
            try data.write(to: fileURL)
            UserDefaults.standard.set(fileURL, forKey: key)
            savedimages = true
        } catch {
            print("Unable to write image data to disk", error)
        }
    }
    
    func loadImage(forKey: String) {
        guard let fileURL = UserDefaults.standard.url(forKey: forKey) else { return }
        do {
            let imageData = try Data(contentsOf: fileURL)
            if let uiImage = UIImage(data: imageData) {
                self.imageProfiles = uiImage
            } else {
                print("Unable to convert data to UIImage")
            }
        } catch {
            print("Unable to load image data from disk", error)
        }
    }
    
}

extension NSNotification.Name {
    static let saveVenueProfileImage = Notification.Name("imagePrilesKeySaved")
}
