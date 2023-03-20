import Foundation

func readFiles(){
    
    // THIS is a string
    print(NSHomeDirectory())
    let libsupport = NSHomeDirectory().appending("/Library/Application Support/com.peterai.ViewsProject")
    //let propfilesupport = libsupport.appending("/vmPreference.json")
    
    // THIS is a URL
    let fm = FileManager.default
    let home = fm.homeDirectoryForCurrentUser
    let appsupp = home.appendingPathComponent("Library/Application Support")
    
    let filesDirectory = appsupp.appendingPathComponent("com.peterai.ViewsProject")
    //let propsFile = filesDirectory.appendingPathComponent("vmPreferences.json")
    
    if !(fm.fileExists(atPath: libsupport)){
        do {
            try fm.createDirectory(at: filesDirectory, withIntermediateDirectories: false)
            print("Directory created at: ", filesDirectory)
        } catch {
            print("Could not create required directory.")
        }
    }
    /*
    let p = "vmPath"
    let q = "/users/data/vm.vm"
    writeFile(stuff: p+","+q, completion: {
        str in DispatchQueue.main.async {
            print("The woke mob", str)
        }
    })
     */
    print(appsupp.path)
}

func writeFile(stuff: String, worker: Worker, completion: @escaping (String) -> Void ) {
    // THIS is a URL
    let fm = FileManager.default
    let filesDirectory = fm.homeDirectoryForCurrentUser.appendingPathComponent("Library/Application Support/com.peterai.ViewsProject")
    
    let propsFileName = "vmPreferences.json"
    let propsFile = filesDirectory.appendingPathComponent(propsFileName)
    
    print("My stuff input is: \(stuff)")
    //let data = Data(stuff.utf8)
    
    let fileInput = """
    {
        "ID": \(Int.random(in: 1...1000)),
        "Name": "\(worker.name)",
        "Age": \(worker.age),
        "Title": "\(worker.title)"
    }
    """
    
    print(fileInput)
    let data = Data(fileInput.utf8)
    
    let myFile =  NSHomeDirectory().appending("/Library/Application Support/com.peterai.ViewsProject/vmPreferences.json")
    print("My Silly String: \(myFile)")
    
    do {
        //let jsonData = try JSONSerialization.data(withJSONObject: fileInput,
             //options: .prettyPrinted)
        //print(jsonData)
        
        let strippedFile = propsFile.absoluteString.replacingOccurrences(of: "%20", with: " ")
        let theWordFile = strippedFile.index(strippedFile.startIndex, offsetBy: 7)
        let newStringWithoutTheWordFileInIt = strippedFile.suffix(from: theWordFile)
        print("My convertedUrl string ", newStringWithoutTheWordFileInIt)
        
        //if (fm.fileExists(atPath: String(newStringWithoutTheWordFileInIt))){
        if (fm.fileExists(atPath: myFile)){
            print("yup, the file is there. Appending new entry.")
            let fileContents = try String(contentsOf: propsFile)
            if fileContents.starts(with: "["){
                //let openingBracket = fileContents.index(fileContents.startIndex, offsetBy: 1)
                
                let nonbracketedFileContents = fileContents[fileContents.index(fileContents.startIndex, offsetBy: 1) ..< fileContents.index(fileContents.endIndex, offsetBy: -2)]
                
                let newFileContents = "[\(nonbracketedFileContents),\n\(fileInput)]\n"
                let d = Data(newFileContents.utf8)
                try d.write(to: propsFile)
            } else {
                let newFileContents = "[\(fileContents),\n\(fileInput)]\n"
                let d = Data(newFileContents.utf8)
                try d.write(to: propsFile)
            }
        } else {
            print("No file exists. Writing to new file.")
            try data.write(to: propsFile)
        }
    } catch {
        print("could not write there")
    }
}

func deleteFile(){
    let fm = FileManager.default
    let myUrl = fm.homeDirectoryForCurrentUser.appendingPathComponent("Library/Application Support/com.peterai.ViewsProject/vmPreferences.json")
    do {
        try fm.removeItem(at: myUrl)
        print("Deleted that file for YA")
    } catch {
        print("File not deleted")
    }
}

func readFromFile(){
    /* This is just a string */
    let myFile =  NSHomeDirectory().appending("/Library/Application Support/com.peterai.ViewsProject/vmPreference.json")
    print("String: \(myFile)")
    
    /* This is a file URL. Notice it uses a FM object. */
    let fm = FileManager.default
    let myUrl = fm.homeDirectoryForCurrentUser.appendingPathComponent("Library/Application Support/com.peterai.ViewsProject/vmPreferences.json")
    print("URL: \(myUrl)")
    do {
        let fileContents = try String(contentsOf: myUrl)
        let fileData = fileContents.data(using: .utf8)!
        
        let workers: [WorkerObject] = try! JSONDecoder().decode([WorkerObject].self, from: fileData)
        
        print(workers.count)
        for worker in workers{
            print(worker)
        }
    } catch {
        print("couldn't find no strings")
    }
}
