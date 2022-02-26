docker run --rm -d -v /tmp/.X11-unix:/tmp/.X11-unix:rw --security-opt seccomp="$PWD"/secprofile/chrome.json --cap-add=SYS_ADMIN -p 8080:10000 rosera/xpra-chrome:1.0
