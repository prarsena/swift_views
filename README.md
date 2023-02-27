# swift_views

If you aren't too experienced on Xcode and Swift, but have Xcode installed and have a basic understanding of git, do this:

1. Clone repo and look in `ViewsProject`. 

2. Open `AppDelegate.swift` -- this is the primary file that directs all others in the app. 
   
   **Note**: I don't use Storyboard files to program in Swift. This style is like graphical programming. I could delete those files but then I'd have to adjust other properties.

3. That file says `let contentView = SimplePassDataView() ` (or some other view). This means: When the app opens, display this "VIEW". 

There are several views to display, so you could change that line to whichever view you want the app to display. Default is usually called `ContentView.swift` but this can be easily changed. 

The reason for this project is to practice passing data between views and windows, and to learn more about swift more generally. 

Swift is an Apple product. As such, they cut off users quickly when they don't want to upgrade. I have been running OS X Catalina (10.15) because my favorite laptop runs this version (2012 macbook air 11"). I don't have access to many new features of the language (such as Scenes, Window Groups, and @StateObjects), but country girls make do. I have uncovered some cool workarounds. 

I hope to one day soon to dig deeper into Objective-C because it actually becomes more relevant the deeper into the architecture I want to get, regardless of how much Apple likes to change and drop support for older hardware... Apple stills uses many foundational objects named after the NextStep operating system (google that one) from the 90s. 

Anyway just some interesting things to call out:

- `SimplePassDataView.swift` 

This is a simple example of using @State vars to display data. It's probably a best practice to setAppDelegate to a master view (in this case, `SimplePassDataView`), which then immediately shows `ViewOne`. On `ViewOne` you can press a button which will show `ViewTwo`, where you can then go back to `ViewOne`. 

I think it also references the functions file, which demos how to write data to files. 

- `PassDataBetweenWindowsView.swift`

This file extends the Views aspect but introducing a second window via the `openWindow` function. The important thing here is that you pass the second window a @State variable, which reads it as a @Binding variable. 

It also uses the ObservableObject class, which is a way to pass Structs around between views/windows prior to OS 11, which introduced @StateObjects. 
