//
//  HomeView.swift
//  testapp
//
//  Created by Elise Green on 2024-07-07.
//

//
// OpeningSurvey.swift
// testapp
//
// Created by Anusha Thukral on 2024-07-11.
//
import Foundation
import SwiftUI
struct HomeView: View {
    var body: some View {
        NavigationView {
            SkinTypeQuestionView()
        }
    }
    
}
struct SkinTypeQuestionView: View {
    @State private var selectedSkinType = ""
    let skinTypes = ["Oily", "Combination", "Normal", "Dry", "Sensitive"]
    var body: some View {
        VStack {
            Text("Hello, welcome!")
                .font(.title)
                .foregroundColor(.pink)
                .bold()
            
            
            Text("What is your skin type?")
                .font(.headline)
                .padding()
            Picker("Skin Type", selection: $selectedSkinType) {
                ForEach(skinTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            NavigationLink(destination: SkinIssuesQuestionView(selectedSkinType:
                                                                selectedSkinType)) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
                                                                .padding()
        }
    }
    
}
struct SkinIssuesQuestionView: View {
    let selectedSkinType: String
    @State private var selectedSkinIssues = Set<String>()
    let skinIssues = ["Acne", "Wrinkles", "Dryness", "Redness", "Dark Spots", "Other"]
    var body: some View {
        
        VStack {
            Text("What skin issues do you have?")
                .font(.headline)
                .padding()
            List(skinIssues, id: \.self) { issue in
                MultipleChoiceRow(title: issue, isSelected: selectedSkinIssues.contains(issue)) {
                    if selectedSkinIssues.contains(issue) {
                        selectedSkinIssues.remove(issue)
                    } else {
                        selectedSkinIssues.insert(issue)
                    }
                }
            }
            NavigationLink(destination: SummaryView(selectedSkinType: selectedSkinType,
                                                    selectedSkinIssues: Array(selectedSkinIssues))) {
                
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
                                                    .padding()
        }
    }
    
}
struct MultipleChoiceRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.pink)
                }
            }
        }
    }
    
}
struct SummaryView: View {
    let selectedSkinType: String
    let selectedSkinIssues: [String]
    var body: some View {
        VStack {
            Text("Survey Summary")
                .font(.headline)
                .padding()
            
            Text("Skin Type: \(selectedSkinType)")
                .padding()
            Text("Skin Issues: \(selectedSkinIssues.joined(separator: ", "))")
                .padding()
            Button(action: submitSurvey) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    func submitSurvey() {
        // Handle survey submission, e.g., save the data, move to the next screen, etc.
        print("Selected Skin Type: \(selectedSkinType)")
        print("Selected Skin Issues: \(selectedSkinIssues.joined(separator: ", "))")
    }
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
    
}
