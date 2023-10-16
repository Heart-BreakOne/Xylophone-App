//

import UIKit
//Imports AVFoundation for multimedia handling
import AVFoundation

class ViewController: UIViewController {
    
    //Creates an instance of AVAudioPlayer
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Reduces opacity while a key note is being pressed.
    @IBAction func touchDown(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    //Key note is pressed
    @IBAction func keyPressed(_ sender: UIButton) {
        
        //Gets what note was pressed by the user
        let currentNote: String = sender.titleLabel?.text ?? ""
        
        /*Code should execute after 0.2 second delay.
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
         //Bring's sender's opacity back up to fully opaque.
         sender.alpha = 1.0
         }*/
        
        //Sets opacity back to normal as the user released the button
        sender.alpha = 1
        //Executes playSound function with the note pressed by the user as a parameter
        playSound(note: currentNote)
    }
    
    
    //Plays the sound from an audio file
    func playSound(note: String) {
        //Gets the path of the audio file
        guard let path = Bundle.main.path(forResource: note, ofType:"wav", inDirectory: "Sounds") else {
            return }
        //Converts the path to url
        let url = URL(fileURLWithPath: path)
        print(url)
        //Attempts to play the sound
        do {
            //Create a new audio player obj using the url
            player = try AVAudioPlayer(contentsOf: url)
            //Plays the sound
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    //Support iOS 10 or earlier.
    func playSound2(note: String) {
        guard let url = Bundle.main.url(forResource: note, withExtension: "wav", subdirectory: "Sounds") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11 +. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
