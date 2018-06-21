# rosbag_record_gui
GUI tool using Zenity for rosbag record in ROS.


## Prereqs

- Ubuntu
- GTK+
- Zenity

## Usage
1. Update permissions if needed:
`chmod +x rosbag_gui.sh`
2. Run: `./rosbag_gui.sh`

### Enter a file name 
![Image showing gui](https://i.imgur.com/mgXxogh.png "Enter in Filename")

### Enter in a comment
![Image showing gui](https://i.imgur.com/rNTTHGR.png "Enter in a comment")

### Select topics to record
![Image showing gui](https://i.imgur.com/pRbEGtF.png "Enter in a comment")

### Verify
![Image showing gui](https://i.imgur.com/NxANhiQ.png "Enter in a comment")

### Expected Output
![Image showing gui](https://i.imgur.com/KKzrUsT.png "Enter in a comment")

### Finish Recording

Use `crtl+c` on the terminal window to finish recording

### Default Storage Location

`$HOME\rosbag-data\$TODAY\$filename.bag`

## License

MIT

