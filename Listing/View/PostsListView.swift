//
//  ListingApp.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 0) {
                    
                    // Search TextField
                    TextField("Search by title...", text: $viewModel.searchText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.top, 10)

                    Spacer().frame(height: 10)

                    Group {
                        // Loading State
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView("Loading...")
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        // Error State
                        else if let error = viewModel.errorMessage {
                            VStack(spacing: 12) {
                                Text(error)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)

                                Button("Retry") {
                                    Task { await viewModel.fetchPosts() }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.green)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        // Success State
                        else {
                            // Check if search result is empty
                            if viewModel.filteredPosts.isEmpty {
                                VStack {
                                    Spacer()
                                    Text(viewModel.searchText.isEmpty ? "No posts available" : "No results found")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                // List of posts
                                List {
                                    ForEach(viewModel.filteredPosts) { post in
                                        HStack(alignment: .top, spacing: 12) {
                                            
                                            NavigationLink(
                                                destination: PostDetailView(
                                                    viewModel: viewModel,
                                                    post: post,
                                                    sourceTitle: "Posts"
                                                )
                                            ) {
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text(post.title)
                                                        .font(.headline)
                                                        .foregroundColor(.black)

                                                    Text("User ID: \(post.userId)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)

                                                    Text("Post ID: \(post.id)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)

                                                    Text(post.body)
                                                        .font(.body)
                                                        .foregroundColor(.secondary)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            Button {
                                                viewModel.toggleFavorite(post: post)
                                            } label: {
                                                Image(systemName: viewModel.isFavorite(post: post) ? "heart.fill" : "heart")
                                                    .foregroundColor(.red)
                                                    .font(.title3)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                        .padding(.vertical, 12)
                                        .listRowSeparator(.hidden)
                                        .listRowBackground(Color.white)
                                    }
                                }
                                .listStyle(.plain)
                                .scrollContentBackground(.hidden)
                                .padding(.bottom, 10)
                                .refreshable {
                                    await viewModel.fetchPosts()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                }
            }
            .navigationTitle("Posts")
        }
        .task {
            await viewModel.fetchPosts()
        }
    }
}
