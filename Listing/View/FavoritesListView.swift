//
//  ListingApp.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var viewModel: PostsViewModel

    var body: some View {
        NavigationStack {
            List {
                if viewModel.favoritePosts.isEmpty {
                    Text("No favorites yet!")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.favoritePosts) { post in
                        NavigationLink(destination: PostDetailView(viewModel: viewModel, post: post, sourceTitle: "Favorites")) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(post.title)
                                        .font(.headline)
                                    Text("User ID: \(post.userId)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.toggleFavorite(post: post)
                                }) {
                                    Image(systemName: viewModel.isFavorite(post: post) ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
