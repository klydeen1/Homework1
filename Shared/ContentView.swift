//
//  ContentView.swift
//  Shared
//
//  Created by Katelyn Lydeen on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    // Initialize values
    @State var radiusString = "1.0"
    @State var calculatedSphereVol = 0.0
    @State var sphereVolText = ""
    @State var calculatedSphereSA = 0.0
    @State var sphereSAText = ""
    @State var calculatedBoxVol = 0.0
    @State var boxVolText = ""
    @State var calculatedBoxSA = 0.0
    @State var boxSAText = ""
    @State var enableButton = true
    
    var body: some View {
        // Display outputs on the UI
        VStack {
            HStack {
                VStack {
                    Text("Radius")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("Enter Radius", text: $radiusString, onCommit: {Task.init {await self.calculateSphere()}})
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom, 30)
                }
                VStack{
                    Text("Sphere volume")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sphereVolText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Sphere surface area")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sphereSAText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Bounding box volume")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $boxVolText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Bounding box surface area")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $boxSAText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            
            // Add calculate button that will run the calculations once pressed
            Button("Calculate", action: {Task.init {await calculateSphere()}})
                    .padding(.top)
                    .padding(.bottom)
                    .padding()
                    .disabled(enableButton == false)
            }
        }
    }
        // Function to calculate the volume and surface area of the sphere and the volume and surface area of the sphere's bounding box
        @Sendable func calculateSphere() async -> Double {
            let radius = Double(radiusString)!
            let calculatedSphereVol = (4/3) * Double.pi * pow(radius,3)
            let newSphereVolText = String(format: "%7.5f", calculatedSphereVol)
            let calculatedSphereSA = 4 * Double.pi * pow(radius,2)
            let newSphereSAText = String(format: "%7.5f", calculatedSphereSA)
            let calculatedBoxVol = pow(radius,3)
            let newBoxVolText = String(format: "%7.5f", calculatedBoxVol)
            let calculatedBoxSA = 6 * pow(radius,2)
            let newBoxSAText = String(format: "%7.5f", calculatedBoxSA)
            
        // Send the updated text values
        await updateSphere(sphereVolTextString: newSphereVolText,sphereSATextString: newSphereSAText, boxVolTextString: newBoxVolText, boxSATextString: newBoxSAText)
        
        return calculatedSphereVol
    }
        
    // Function to update the text values in the UI
    @Sendable @MainActor func updateSphere(sphereVolTextString: String,sphereSATextString: String, boxVolTextString: String, boxSATextString: String){
        sphereVolText = sphereVolTextString
        sphereSAText = sphereSATextString
        boxVolText = boxVolTextString
        boxSAText = boxSATextString
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
