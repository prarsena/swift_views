import SwiftUI

class MyVariableStates: ObservableObject  {
    static var archKnown = false
    static var qemuInstalled = false
    static var socketVmInstalled = false
    @Published var isoLoc = "Specify ISO location"
}

let a = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
let b = ProcessInfo.processInfo.operatingSystemVersion.minorVersion
//let result = try? safeShell("uname -m")
let result = "Intel"

class myFileInfo: ObservableObject {
    @Published var title: String
    @Published var location: String
    
    init(title: String, location: String) {
        self.title = title
        self.location = location
    }
}

struct RunMachineView: View {
    @State private var show = false
    @State var localStates = MyVariableStates()
    @State var refresh = false
    
    var body: some View {
        
        VStack{
            if !show {
                RootView(show: $show, localVarStates: $localStates, refresh: $refresh)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
                    //.environmentObject(myText)
            }
            if show {
                NextView(show: $show, localStates: $localStates)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
            }
        }
    }
}

struct RootView: View {
    @Binding var show: Bool
    @Binding var localVarStates: MyVariableStates
    @Binding var refresh: Bool
    
    func chooseIso()  {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        if panel.runModal() == .OK {
            localVarStates.isoLoc = panel.url?.lastPathComponent ?? "<none>"
            refresh.toggle()
        }
        NSLog("ISO location: " + self.localVarStates.isoLoc)
        
    }
    
    var body: some View {
        VStack{
            Text("Linux Server😭🧠").font(.title).italic()
            HStack(alignment: .top, spacing: 10) {
                Text("OS: " + String(a) + "." + String(b))
                Text("CPU Arch: " + (result))
                
            }
            Form{
                HStack{
                    Button(action: chooseIso ) {
                        Text("Locate ISO").frame(width:80, alignment: .leading)
                        Image("icons8-file-folder-48")
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()
                            .frame(width: 16, height: 14)
                    }.buttonStyle(BorderedButtonStyle())
                    
                    TextField(" ",text: $localVarStates.isoLoc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                }
            }
            
            Button("Next") { self.show = true }
            Text("This is the first view")
            Text(String(refresh)).hidden()
        }
    }
}

struct NextView: View {
    @Binding var show: Bool
    @Binding var localStates: MyVariableStates
    func addThings(){
        sleep(3)
        print(1 + 2)
    }
    
    var body: some View {
        VStack{
            Form{
                HStack{
                    Button(action: addThings ) {
                        Text("Locate ISO")
                            .frame(width:80, alignment: .leading)
                        Image("icons8-file-folder-48")
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()
                            .frame(width: 16, height: 14)
                    }.buttonStyle(BorderedButtonStyle())
                    
                    
                    TextField(" ",text: $localStates.isoLoc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                }
                
                HStack{
                    Button("Click me", action: addThings )
                        
                }
            }
            Button("Back") { self.show = false }
            Text("This is the second view")
        }
    }
}
