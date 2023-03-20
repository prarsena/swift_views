import SwiftUI

class Worker: ObservableObject  {
    @Published var name: String = ""
    @Published var age: Int = 18
    @Published var title: String = ""
}

struct SimplePassDataView: View {
    @State var name = "Peter"
    @State var show = false
    @State var worker = Worker()
    
    var body: some View {
        if !show {
            ViewOne(name: $name, show: $show, worker: $worker)
        }
        if show {
            ViewTwo(name: $name, show: $show, worker: $worker)
        }
    }
}

struct ViewOne: View {
    @Binding var name: String
    @Binding var show: Bool
    @Binding var worker: Worker
    @State var refresh = false
    @State var tempName = ""
    @State var tempTitle = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("Enter your name!")
                TextField("What's your name?", text: $tempName)
            }
            HStack{
                Text("Enter your age: ")
                Text("\(worker.age)")
            }
            HStack{
                Button("Decrease age", action: {
                    worker.age = worker.age - 1
                    print("Age has decreased to ", worker.age)
                    refresh.toggle()
                })
                
                Button("Increase age", action: {
                    worker.age = worker.age + 1
                    print("Age has increased to ", worker.age)
                    refresh.toggle()
                })
            }
            HStack{
                Text("Enter your title!")
                TextField("What's your title?", text: $tempTitle)
            }
            Button("Next"){ self.show = true }
            Text("\(String(refresh))").hidden()
            
            let myStringToWrite: String = "Worker name, \(worker.name), Worker age, \(worker.age)"
            
            Button("Write to file", action: {
                refresh.toggle()
                worker.name = tempName
                worker.title = tempTitle
                writeFile(stuff: myStringToWrite, worker: worker, completion: {
                    str in DispatchQueue.main.async{
                        print("Success", str)
                        tempName = ""
                        tempTitle = ""
                        refresh.toggle()
                    }
                })
            })
            
            Button("Print file contents ", action:{
                refresh.toggle()
                readFromFile()
            })
            HStack{
                Button("Quit", action: {
                    NSApplication.shared.keyWindow?.close()
                })
                Button("Delete data", action: deleteFile )
            }
            
        }.padding(50)
    }
}

struct ViewTwo: View {
    @Binding var name: String
    @Binding var show: Bool
    @Binding var worker: Worker
    var body: some View {
        VStack{
            Text("Hello \(worker.name)!")
            Text("You are \(worker.age)!")
            
            Button("Back"){ self.show = false}
        }.padding(150).frame(width: 600)
    }
}
