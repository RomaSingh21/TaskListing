//
//  ListingApp.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import Foundation
import SwiftUI

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var searchText: String = ""
    @Published var favorites: Set<Int> = [] // store favorite post IDs
    @Published var isLoading = false
    @Published var errorMessage: String?

    var filteredPosts: [Post] {
        if searchText.isEmpty {
            return posts
        } else {
            return posts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var favoritePosts: [Post] {
        posts.filter { favorites.contains($0.id) }
    }

    func toggleFavorite(post: Post) {
        if favorites.contains(post.id) {
            favorites.remove(post.id)
        } else {
            favorites.insert(post.id)
        }
    }

    func isFavorite(post: Post) -> Bool {
        favorites.contains(post.id)
    }

    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Post].self, from: data)
            self.posts = decoded
        } catch {
            self.errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
