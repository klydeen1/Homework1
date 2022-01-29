//
//  Sphere.swift
//  Homework1
//
//  Created by Katelyn Lydeen on 1/28/22.
//

import Foundation
import SwiftUI

class Sphere: NSObject, ObservableObject {
    var radius = 0.0
    @Published var radiusString = "1.0"
    @Published var sphereVol = 0.0
    @Published var sphereVolText = ""
    @Published var sphereSA = 0.0
    @Published var sphereSAText = ""
    @Published var boxVol = 0.0
    @Published var boxVolText = ""
    @Published var boxSA = 0.0
    @Published var boxSAText = ""
    @Published var enableButton = true
    
    /// initWithRadius
    /// Initializes a sphere of a given radius, running the functions to calculate its volume and surface area as well as the volume and surface area of its bounding box
    /// - Parameter passedRadius: the radius of the sphere
    func initWithRadius(passedRadius: Double) async -> Bool {
        radius = passedRadius
        let _ = await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {let _ = await self.calculateSphereVol(radius: self.radius)}
            taskGroup.addTask {let _ = await self.calculateSphereSA(radius: self.radius)}
            taskGroup.addTask {let _ = await self.calculateBoxVol(radius: self.radius)}
            taskGroup.addTask {let _ = await self.calculateBoxSA(radius: self.radius)}
        }
        await setButtonEnable(state: true)
        return true
    }
    
    /// calculateSphereVol
    /// Calculates the volume of a sphere with set radius
    /// Parameters:
    /// - Parameter radius: radius of the sphere (units of length)
    func calculateSphereVol(radius: Double) async -> Double {
        // Vol = (4/3) * pi * radius^3
            
        let calculatedSphereVol = (4/3) * Double.pi * pow(radius,3)
        let newSphereVolText = String(format: "%7.5f", calculatedSphereVol)
            
        await updateSphereVol(sphereVolTextString: newSphereVolText)
        await newSphereVolValue(sphereVolValue: calculatedSphereVol)
            
        return calculatedSphereVol
    }
    
    /// calculateSphereSA
    /// Calculates the surface area of a sphere with set radius
    /// Parameters:
    /// - Parameter radius: radius of the sphere (units of length)
    func calculateSphereSA(radius: Double) async -> Double {
        // SA = 4 * pi * radius^2
            
        let calculatedSphereSA = 4 * Double.pi * pow(radius,2)
        let newSphereSAText = String(format: "%7.5f", calculatedSphereSA)
            
        await updateSphereSA(sphereSATextString: newSphereSAText)
        await newSphereSAValue(sphereSAValue: calculatedSphereSA)
            
        return calculatedSphereSA
    }
    
    /// calculateBoxVol
    /// Calculates the volume of a bounding box of a sphere (i.e. cube)
    /// Parameters:
    /// - Parameter radius: radius of the sphere that defines the bounding box (units of length)
    func calculateBoxVol(radius: Double) async -> Double {
        // Vol = radius^3
            
        let calculatedBoxVol = pow(radius,3)
        let newBoxVolText = String(format: "%7.5f", calculatedBoxVol)
            
        await updateBoxVol(boxVolTextString: newBoxVolText)
        await newBoxVolValue(boxVolValue: calculatedBoxVol)
            
        return calculatedBoxVol
    }
    
    /// calculateBoxSA
    /// Calculates the surface area of a bounding box of a sphere (i.e. cube)
    /// Parameters:
    /// - Parameter radius: radius of the sphere that defines the bounding box (units of length)
    func calculateBoxSA(radius: Double) async -> Double {
        // SA = 6 * radius^2
            
        let calculatedBoxSA = 6 * pow(radius,2)
        let newBoxSAText = String(format: "%7.5f", calculatedBoxSA)
            
        await updateBoxSA(boxSATextString: newBoxSAText)
        await newBoxSAValue(boxSAValue: calculatedBoxSA)
            
        return calculatedBoxSA
    }
    
    /// setButtonEnable
    /// Toggles the state of the Enable button
    /// - Parameter state: Boolean indicating whether the button should be enabled or not
    @MainActor func setButtonEnable(state: Bool) {
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }

    }
    
    /// updateSphereVol
    /// Executes on the main thread to update the text that gives the sphere's volume
    /// - Parameter sphereVolTextString: Text describing the value of the sphere's volume
    @MainActor func updateSphereVol(sphereVolTextString: String){
        sphereVolText = sphereVolTextString
    }
    
    /// newSphereVolValue
    /// Updates the value of the sphere's volume
    /// - Parameter sphereVolValue: Double describing the value of the sphere volume
    @MainActor func newSphereVolValue(sphereVolValue: Double){
        self.sphereVol = sphereVolValue
    }
    
    /// Same as above functions for the sphere's surface area instead of volume
    @MainActor func updateSphereSA(sphereSATextString: String){
        sphereSAText = sphereSATextString
    }
   @MainActor func newSphereSAValue(sphereSAValue: Double){
        self.sphereSA = sphereSAValue
    }
    
    /// Same as above functions for the volume of the bounding box/cube
    @MainActor func updateBoxVol(boxVolTextString: String){
        boxVolText = boxVolTextString
    }
    @MainActor func newBoxVolValue(boxVolValue: Double){
        self.boxVol = boxVolValue
    }
    
    /// Same as  above functions for the surface area of the bounding box/cube
    @MainActor func updateBoxSA(boxSATextString: String){
        boxSAText = boxSATextString
    }
   @MainActor func newBoxSAValue(boxSAValue: Double){
        self.boxSA = boxSAValue
    }
}
