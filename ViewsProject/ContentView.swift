//
//  ContentView.swift
//  ViewsProject
//
//  Created by petera on 2/5/23.
//

import SwiftUI

// Our observable object class
class GameSettings: ObservableObject {
    @Published var score = 0
}

class Book: ObservableObject {
    @Published var title: String
    @Published var author: String
    @Published var copies: Int

    init(title: String, author: String, copies: Int) {
        self.title = title
        self.author = author
        self.copies = copies
    }
}


// A view that creates the GameSettings object,
// and places it into the environment for the
// navigation stack.
struct ContentView: View {
    @State private var show = false
    @State var lunch = "paste"
    @State var book = Book(title:
                            "The Hitchhiker’s Guide to the Galaxy", author: "Douglas Adams", copies: 4)
    //@ObservedObject var settings = GameSettings()
    @State var setting = GameSettings()
    
    var body: some View {
        VStack{
            
            if !show {
                FirstView(show: $show, lunch: $lunch, book: $book, settings: $setting)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
            }
            if show {
                ScoreView(show: $show, lunch: $lunch, book: $book, setting: $setting)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
            }
        }
    }
}

struct ScoreView: View {
    @Binding var show: Bool
    @Binding var lunch: String
    @Binding var book: Book
    @Binding var setting: GameSettings
    
    var body: some View {
        VStack{
            HStack{
                Text("Type your lunch choice: ")
                TextField("Type Lunch ", text: $lunch)
            }
            HStack {
                Text("Lunch: \(lunch)")
                //Text("Score: \(settings.score)")
            }
            Text("Bookinfo!").bold().font(.largeTitle)

            HStack {
                Text("Title: \(book.title)")
            }

            HStack {
                Text("Author: \(book.author)")
            }
            
            Text("Score!").bold().font(.largeTitle)
            HStack {
                Text("Score: \(setting.score)")
            }
            
            Button("Back") { self.show = false }
        }.padding(50)
    }
    
}

struct FirstView: View {
    @Binding var show: Bool
    @Binding var lunch: String
    @Binding var book: Book
    @Binding var settings: GameSettings
    
    var body: some View {
        
        VStack {
            HStack{
                Button("Increase Score") {
                    settings.score += 1
                    print(settings.score)
                }
                Text("Scre: \(settings.score)")
            }
            
            HStack{
                Text("Type your lunch choice: ")
                TextField("Type Lunch ", text: $lunch)
            }
            HStack {
                Text("Lunch: \(lunch)")
            }
            
            Text("Bookinfo!").bold().font(.largeTitle)
            HStack{
                Text("Type the book title: ")
                TextField("Title ", text: $book.title)
            }
            HStack {
                Text("Title: \(book.title)")
            }
            HStack{
                Text("Type the book author: ")
                TextField("Title ", text: $book.author)
            }
            HStack {
                Text("Author: \(book.author)")
            }
           
            Button("Next") { self.show = true }
        }
        .frame(width: 400, height: 400)
        .padding(50)
        .environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
