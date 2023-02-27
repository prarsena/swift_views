import SwiftUI

var window: NSWindow!

class MyLunch: ObservableObject {
    @Published var lunch = "pizza"
}

struct SecondView: View {
    @Binding var lunch: String
    @Binding var lunchObject: MyLunch
    @Binding var refresh: Bool
    
    func closeWindow() {
        NSApplication.shared.keyWindow?.close()
        refresh.toggle()
    }
    
    var body: some View {
        VStack(alignment: .center,content: {
            Text("Second Vieww😭🧠").font(.largeTitle)
            
            HStack(alignment: .top, spacing: 10) {
                TextField("What is lnch?", text: $lunch)
                Text("Lunch is \(lunch) ")
            }
            
            HStack(alignment: .top, spacing: 10) {
                TextField("What is lunch object?", text: $lunchObject.lunch)
                Text("My lunchObject is \(lunchObject.lunch) ")
            }
            Button("Save", action: closeWindow)
        }).padding(100)
    }
}

struct FourthView: View {
    @State var lunch = "sushi"
    @State var lunchObject = MyLunch()
    @State var refresh: Bool = false
    
    func openWindow(){
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.setFrameAutosaveName("Create VM")
        window.contentView = NSHostingView(rootView: SecondView(lunch: $lunch, lunchObject:$lunchObject, refresh: $refresh))
        window.makeKeyAndOrderFront(nil)
    }
    
    func quitApp() {
        NSApplication.shared.terminate(self)
    }
    
    var body: some View {
        VStack {
            Text("Fourth View😭🧠").font(.largeTitle).italic()
            
            HStack(alignment: .top) {
                Text("Lunch is: ")
                    .frame(width: 100, alignment: .leading)
                Spacer().frame(width: 50)
                Text("\(lunch) ")
                    .frame(width: 100, alignment: .trailing)
            }
            
            HStack(alignment: .top) {
                Text("LunchObject is: ")
                    .frame(width: 100, alignment: .leading)
                Spacer().frame(width: 50)
                Text("\(lunchObject.lunch) ")
                    .frame(width: 100, alignment: .trailing)
            }
            
            HStack(){
                Button(action: quitApp){
                    Text("Quit")
                }.padding(0)
                
                Spacer().frame(width: 100)
                
                Button(action: openWindow ){
                    Text("Edit objects")
                }
            }
            
            Text("\(String(refresh))").hidden()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(50)
        .onAppear(perform: {
            print("Hi i'm here")
        })
    }
}

struct PassDataBetweenWindowsView: View {
    var body: some View{
        VStack{
            FourthView()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PassDataBetweenWindowsView_Previews: PreviewProvider {
    static var previews: some View {
        PassDataBetweenWindowsView()
    }
}
