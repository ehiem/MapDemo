//
//  MapView.swift
//  Map
//
//  Created by Scholar on 6/28/23.
//
import MapKit
import SwiftUI

struct MAP: View {
    @StateObject private var viewModel = MAPModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .ignoresSafeArea()
                    .accentColor(Color.pink)
                    .onAppear {
                        viewModel.checkIfLocationServicesAreEnabled()
                    }
                   
                Button(action: {
                    
                    withAnimation {
                        viewModel.region.span = MKCoordinateSpan(
                        latitudeDelta: 5,
                        longitudeDelta: 5
                    )
                }
                    
                }, label: {
                    Text("+")
                        .bold()
                        .frame(width: 350, height: 50, alignment:.center)
                        .background(Color.pink)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                })
                Button(action: {
                    
                    withAnimation {
                        viewModel.region.span = MKCoordinateSpan(
                        latitudeDelta: 10,
                        longitudeDelta: 10
                    )
                }
                    
                }, label: {
                    Text("-")
                        .bold()
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                })
            }
        }
    }
}
struct MAP_Previews: PreviewProvider {
    static var previews: some View {
        MAP()
    }
}


final class MAPModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.7,
            longitude: -74),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 40
        )
    )
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesAreEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("Show an alert letting them know location services are blocked.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied this app's location permission. Go to settings in order to fix this issue.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
