import AVFoundation

var audioPlayer : AVAudioPlayer!

func playSound(audioFileName: String){
    guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3")
    else {
        print("couldn't set up url")
        return
    }
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
        
    }
    catch {
        print(error.localizedDescription)
    }
}

func stopSound() {
    audioPlayer?.stop()
}



