//
//  ContentView.swift
//  Shared
//
//  Created by Katelyn Lydeen on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    // Initialize an instance of the Sphere class called sphereModel
    @ObservedObject private var sphereModel = Sphere()
    
    // Initialize a default radius shown in the UI
    @State var radiusString = "1.0"
    
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
                    TextField("", text: $sphereModel.sphereVolText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Sphere surface area")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sphereModel.sphereSAText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Bounding box volume")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sphereModel.boxVolText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                VStack{
                    Text("Bounding box surface area")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sphereModel.boxSAText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            
            // Add calculate button that will run the calculations once pressed
            Button("Calculate", action: {Task.init {await calculateSphere()}})
                    .padding(.top)
                    .padding(.top)
                    .padding(.bottom)
                    .padding()
                    .disabled(sphereModel.enableButton == false)
            }
        }
    }
        /// calculateSphere
        /// Disables the calculate button and calls the initWithRadius function for sphereModel. This calculates the values of the volume and surface area for a sphere and its bounding box. The radius of this sphere is given through the UI
        func calculateSphere() async {
            sphereModel.setButtonEnable(state: false)
            let _ : Bool = await sphereModel.initWithRadius(passedRadius: Double(radiusString)!)
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
