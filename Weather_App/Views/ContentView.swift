//
//  ContentView.swift
//  Weather_App
//
//  Created by Mayk on 9/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var daily: DailyResponse?
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            if let location = locationManager.location {
                if let weather = weather, let daily = daily {
                    WeatherView(weather: weather)
                    GeometryReader { reader in
                        VStack {
                            ForecastListView(daily: [daily])
                                .offset(y: reader.frame(in: .global).height - 40)
                                .offset(y: offset)
                                .gesture(DragGesture()
                                    .onChanged({ (value) in
                                        withAnimation {
                                            if value.startLocation.y > reader.frame(in: .global).midX {
                                                if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 210) {
                                                    offset = value.translation.height
                                                }
                                            }
                                            
                                            if value.startLocation.y < reader.frame(in: .global).midX {
                                                if value.translation.height > 0 && offset < 0 {
                                                    offset = (-reader.frame(in: .global).height + 150) + value.translation.height
                                                }
                                                
                                            }
                                        }
                                    })
                                        .onEnded({ (value) in
                                            withAnimation {
                                                if value.startLocation.y > reader.frame(in: .global).midX {
                                                    if -value.translation.height > reader.frame(in: .global).midX {
                                                        offset = (-reader.frame(in: .global).height + 100)
                                                        return
                                                    }
                                                    offset = 0
                                                }
                                                
                                                if value.startLocation.y < reader.frame(in: .global).midX {
                                                    if value.translation.height < reader.frame(in: .global).midX {
                                                        offset = (-reader.frame(in: .global).height + 150)
                                                        return
                                                    }
                                                    offset = 0
                                                }
                                            }
                                        })
                                )
                        }
                        .ignoresSafeArea(.all, edges: .bottom)
                    }
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                daily = try await weatherManager.getDailyForecast(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
