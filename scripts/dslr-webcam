#!/bin/bash
v4l2-ctl -d /dev/video1 -c timeout=1000
gphoto2 --summary
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -vf 'fade=in:0:10,fps=fps=30' -f v4l2 /dev/video1
