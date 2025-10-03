//
//  ListingApp.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import SwiftUI

@main
struct ListingApp: App {
    @StateObject var viewModel = PostsViewModel()
   
    init() {
            UINavigationBar.appearance().tintColor = UIColor.systemGreen
        }
   
    var body: some Scene {
        WindowGroup {
            TabView {
                PostsListView(viewModel: viewModel)
                    .tabItem {
                        Label("Posts", systemImage: "list.bullet")
                        Text("Posts")
                    }

                FavoritesListView(viewModel: viewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                        Text("Favorites")
                    }
            }
           // .tint(.green)
            .accentColor(.green)
        }
    }
}
