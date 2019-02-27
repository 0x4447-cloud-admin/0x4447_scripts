
# Play RTSP in X Window (Linux)

#### Method 1:

`ffplay -fs rtsp://<user>:<password>@<address|IP>:<port#>/<rest of address>`

#### Method 2 

(Primarily for Raspberry Pi as it utilizes HW Accelerator for better FPS):

`vlc --fullscreen rtsp://:@<address|IP>:<port#>/`
