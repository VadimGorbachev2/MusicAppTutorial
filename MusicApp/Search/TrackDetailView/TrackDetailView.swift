//
//  TrackDetailView.swift
//  MusicApp
//
//  Created by Vadim  Gorbachev on 21.11.2019.
//  Copyright © 2019 Vadim  Gorbachev. All rights reserved.
//

// MARK: recent track

import UIKit

class TrackDetailView: UIView {
    
    // MARK: IBOuthlets
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trackImageView.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.2705882353, blue: 0.3529411765, alpha: 1)
    }
    
    
    // MARK: IBActions
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
    }
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func previousTrack(_ sender: Any) {
    }
    @IBAction func nextTrack(_ sender: Any) {
    }
    @IBAction func playPauseAction(_ sender: Any) {
    }
    
    
}
