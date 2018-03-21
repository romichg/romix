
If vmplayer gives you error about 3d acceleration not being available  you need to add

```mks.gl.allowBlacklistedDrivers = "TRUE"```

to ./vmplayer/preferences

this comes from https://askubuntu.com/questions/537787/enable-3d-hw-acceleration-on-vmware-workstation-10-on-ubuntu-14-04


Now why do you need 3d acceleration you might ask?

well I found the hard way today that if you are sharing a screen with Ring Central and 3d is not available the screen will flicker between your desktop (even though you are only sharing an application not your desktop)  and the app you are sharing

best of all, you will never know this

only others who are viewing your shared screen will

Why Ring Central (or Zoom Meetings since it is just a white labeled version of Zoom) needs direct GPU access to share screens, I don't know. But it does.

btw, playing a video without 3d acceleration is fine


oh and one other thing. For some reason if you simply run the VM and record audio within the VM the audio cracks and hisses

but if you open up pavuaudiocontrol  on the host  - which is basically pulseaudio input control, and don't do anything, but just keep it open

the audio is fine


RomichG I don't understand why vmplayer keeps auto-suspending my VM

RomichG Man I knwo.. every time it gets an idle timeout from X

it is stoopid

I don't like vmplayer

man.. All I need is a simple virtualisation solution ...

sergetruth https://www.youtube.com/watch?v=GlC73tjQCII

https://kb.vmware.com/s/article/2056501

